#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "parser.h"

#define SYM_CNT	256
#define SYM_LEN 256

static char globals[SYM_CNT][SYM_LEN];
static int gCnt;

static char* inRegOrder[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };

static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n);

static void emitRvalue(astnode_t* rvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n) {
	switch (rvalue->subType) {
		case RVALUE_BINOP: {
			astnode_t* a = rvalue->kid;
			astnode_t* op = rvalue->kid->sibling;
			astnode_t* b = rvalue->kid->sibling->sibling;
			emitRvalue(b, fd, symbols, n);
			printf("\tpush\trax\n");
			emitRvalue(a, fd, symbols, n);
			printf("\tpop\trdi\n");
			switch (op->kid->token) {
				case TOKEN_PLUS: printf("\tadd\trax, rdi\n"); break;
				case TOKEN_MINUS: printf("\tsub\trax, rdi\n"); break;
				case TOKEN_ASTERISK: printf("\tmul\trdi\n"); break;
				case TOKEN_DIVIDE: printf("\txor\trdx, rdx\n\tdiv\trdi\n"); break;
				case TOKEN_MODULUS: printf("\txor\trdx, rdx\n\tdiv\trdi\n\tmov\trax, rdx\n"); break;
				case TOKEN_AND: printf("\tand\trax, rdi\n"); break;
				case TOKEN_BAND: {
					printf("\txor\trdx, rdx\n");
					printf("\ttest\trax, rax\n");
					printf("\tsetnz\tdl\n");
					printf("\tmov\trax, rdx\n");
					printf("\txor\trdx, rdx\n");
					printf("\ttest\trdi, rdi\n");
					printf("\tsetnz\tdl\n");
					printf("\tmov\trdi, rdx\n");
					printf("\tand\trax, rdi\n");
				}
				break;
				case TOKEN_OR: printf("\tor\trax, rdi\n"); break;
				case TOKEN_BOR: {
					printf("\txor\trdx, rdx\n");
					printf("\ttest\trax, rax\n");
					printf("\tsetnz\tdl\n");
					printf("\tmov\trax, rdx\n");
					printf("\txor\trdx, rdx\n");
					printf("\ttest\trdi, rdi\n");
					printf("\tsetnz\tdl\n");
					printf("\tmov\trdi, rdx\n");
					printf("\tor\trax, rdi\n");
				}
				break;
				case TOKEN_XOR: printf("\txor\trax, rdi\n"); break;
				case TOKEN_LSHIFT: printf("\tmov\trcx, rdi\n\tshl\trax, cl\n"); break;
				case TOKEN_RSHIFT: printf("\tmov\trcx, rdi\n\tshr\trax, cl\n"); break;
				case TOKEN_EQUAL: {
					printf("\txor\trdx, rdx\n");
					printf("\tcmp\trax, rdi\n");
					printf("\tsete\tdl\n");
					printf("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_NOTEQUAL: {
					printf("\txor\trdx, rdx\n");
					printf("\tcmp\trax, rdi\n");
					printf("\tsetne\tdl\n");
					printf("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_GREATERTHAN: {
					printf("\txor\trdx, rdx\n");
					printf("\tcmp\trax, rdi\n");
					printf("\tsetg\tdl\n");
					printf("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_LESSTHAN: {
					printf("\txor\trdx, rdx\n");
					printf("\tcmp\trax, rdi\n");
					printf("\tsetl\tdl\n");
					printf("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_GEQ: {
					printf("\txor\trdx, rdx\n");
					printf("\tcmp\trax, rdi\n");
					printf("\tsetge\tdl\n");
					printf("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_LEQ: {
					printf("\txor\trdx, rdx\n");
					printf("\tcmp\trax, rdi\n");
					printf("\tsetle\tdl\n");
					printf("\tmov\trax, rdx\n");
				}
				break;
			}
		}
		break;
		case RVALUE_FUNCTION_CALL: {
			astnode_t* f = rvalue->kid;
			astnode_t* param = f->sibling->sibling;
			emitLvalue(f, fd, symbols, n);
			printf("\tpush\trax\n");
			int i = 0;
			while (param && param->type == AST_RVALUE) {
				emitRvalue(param, fd, symbols, n);
				printf("\tmov\t%s, rax\n", inRegOrder[i++]);
				param = param->sibling->sibling;
			}
			printf("\tpop\trax\n\tcall\trax\n");
		}
		break;
		case RVALUE_ASSIGN: {
			astnode_t* lvalue = rvalue->kid;
			rvalue = lvalue->sibling->sibling;
			emitLvalue(lvalue, fd, symbols, n);
			printf("\tpush\trax\n");
			emitRvalue(rvalue, fd, symbols, n);
			printf("\tpop\trdi\n");
			printf("\tmov\tqword [rdi], rax\n");
		}
		break;
		case RVALUE_LVALUE: {
			emitLvalue(rvalue->kid, fd, symbols, n);
			printf("\tmov\trax, qword [rax]\n");
		}
		break;
		case RVALUE_UNARY: {
			astnode_t* op = rvalue->kid;
			emitRvalue(rvalue->kid->sibling, fd, symbols, n);
			switch(op->kid->token) {
				case TOKEN_MINUS:
				printf("\tneg\trax\n");
				break;
				case TOKEN_NOT:
				printf("\tnot\trax\n");
				break;
				case TOKEN_BNOT:
				printf("\t; BNOT\n");
				break;
			}
		}
		break;
		case RVALUE_PARENS: emitRvalue(rvalue->kid->sibling, fd, symbols, n); break;
		case RVALUE_CONSTANT: printf("\tmov\trax, %s\n", rvalue->kid->kid->value); break;
	}
}

static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n) {
	switch (lvalue->subType) {
		case LVALUE_ID: {
			char* id = lvalue->kid->value;
			int i, j;
			for (i = 0; i < n; i++) {
				j = 0;
				while (id[j] == symbols[i][j] && id[j] && symbols[i][j]) {
					j++;
				}
				if (id[j] == symbols[i][j]) {
					break;
				}
			}
			if (i < n)
				printf("\tlea\trax, qword [rbp - %d]\n", (i + 1) * 8);
			else {
				for (i = 0; i < gCnt; i++) {
					j = 0;
					while (id[j] == globals[i][j] && id[j] && globals[i][j]) {
						j++;
					}
					if (id[j] == globals[i][j]) {
						break;
					}
				}
				if (i == gCnt)
					printf("\textern\t%s\n", id);
				printf("\tmov\trax, %s\n", id);
			}
		}
		break;
		case LVALUE_INDIRECTION: {
			astnode_t* rvalue = lvalue->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n);
		}
		break;
	}
}

static void emitStatement(astnode_t* statement, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l) {
	switch(statement->subType) {
		case STATEMENT_LOCAL: {
			// should have appeared at the begining of the function!
		}
		break;
		case STATEMENT_IF: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n);
			int l1 = (*l)++;
			int l2 = (*l)++;
			printf("\ttest\trax, rax\n\tjz\tL%d\n", l1);
			astnode_t* substate = statement->kid->sibling->sibling->sibling;
			while (substate && substate->token != TOKEN_ELSE && substate->token != TOKEN_END) {
				emitStatement(substate, fd, symbols, n, l);
				substate = substate->sibling;
			}
			printf("\tjmp L%d\n", l2);
			printf("L%d:\n", l1);
			if (substate && substate->token == TOKEN_ELSE) {
				substate = substate->sibling;
				while (substate && substate->kid && substate->kid->token != TOKEN_END) {
					emitStatement(substate, fd, symbols, n, l);
					substate = substate->sibling;
				}
			}
			printf("L%d:\n", l2);
		}
		break;
		case STATEMENT_WHILE: {
			astnode_t* rvalue = statement->kid->sibling;
			int l1 = (*l)++;
			int l2 = (*l)++;
			astnode_t* substate = statement->kid->sibling->sibling->sibling;
			printf("\tjmp\tL%d\nL%d:\n", l2, l1);
			while (substate && substate->token != TOKEN_END) {
				emitStatement(substate, fd, symbols, n, l);
				substate = substate->sibling;
			}
			printf("L%d:\n", l2);
			emitRvalue(rvalue, fd, symbols, n);
			printf("\ttest\trax, rax\n\tjnz\tL%d\n", l1);
		}
		break;
		case STATEMENT_RETURN: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n);
			printf("\tmov\trsp, rbp\n");
			printf("\tpop\trbp\n");
			printf("\tret\n");
		}
		break;
		case STATEMENT_RVALUE: {
			astnode_t* rvalue = statement->kid;
			emitRvalue(rvalue, fd, symbols, n);
		}
		break;
	}
}

static void emitDefinition(astnode_t* definition, int fd) {
	astnode_t* functionId = definition->kid->sibling;
	char symbols[SYM_CNT][SYM_LEN];
	int l = 0;
	int n = 0;
	astnode_t* parameter = functionId->sibling->sibling;

	memset(symbols, 0, sizeof(symbols));
	printf("\nglobal %s\n", functionId->value);
	printf("%s:\n", functionId->value);
	printf("\tpush\trbp\n");
	printf("\tmov\trbp, rsp\n");

	if (parameter && parameter->token == TOKEN_RPAREN) parameter = parameter->sibling;
	while (parameter && parameter->token == TOKEN_ID) {
		int j = 0;
		do {
			symbols[n][j] = parameter->value[j];
		} while (parameter->value[j++]);
		parameter = parameter->sibling->sibling;
		n++;
	}
	int frameSetup = 0, m = n;
	astnode_t* statement = parameter;
	while (statement->type == AST_STATEMENT) {
		if (statement->subType == STATEMENT_LOCAL) {
			astnode_t* node = statement->kid;
			while (node) {
				int j = 0;
				do {
					symbols[m][j] = node->sibling->value[j];
				} while (node->sibling->value[j++]);
				node = node->sibling->sibling;
				m++;
			}
		}
		else {
			if (!frameSetup) {
				printf("\tsub\trsp, %d\n", m * 8);
				int i;
				for (i = 0; i < n; i++) {
					printf("\tmov\tqword [rbp - %d], %s\t; %s\n", (i + 1) * 8, inRegOrder[i], symbols[i]);
				}
				for (i = n; i < m; i++) {
					printf("\tmov\tqword [rbp - %d], 0\t;%s\n", (i + 1) * 8, symbols[i]);
				}
				frameSetup = 1;
			}
			emitStatement(statement, fd, symbols, m, &l);
		}
		statement = statement->sibling;
	}
	printf("\tmov\trsp, rbp\n");
	printf("\tpop\trbp\n");
	printf("\tret\n");
}

void emitProgram(astnode_t* program, int fd) {
	astnode_t* definition = program ? program->kid : 0;
	gCnt = 0;
	printf("; this code was generated by a tool. assemble with nasm.\n");
	printf("bits 64\n\n");
	printf("section .text\n");
	while (definition) {
		strcpy(globals[gCnt++], definition->kid->sibling->value);
		emitDefinition(definition, fd);
		definition = definition->sibling;
	}
	printf("\n");
}
