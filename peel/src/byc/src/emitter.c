#include "pith.h"
#include "lexer.h"
#include "parser.h"

#define SYM_CNT	1024
#define SYM_LEN 256

extern void puts(char* str);
extern void printf(char* fmt, int n, char* s);
extern void error(char* msg);

static char globals[SYM_CNT][SYM_LEN];
static int gCnt;
static char* inRegOrder[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };
static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l);

static void emitRvalue(astnode_t* rvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l) {
	switch (rvalue->subType) {
		case RVALUE_BINOP: {
			astnode_t* a = rvalue->kid;
			astnode_t* op = rvalue->kid->sibling;
			astnode_t* b = rvalue->kid->sibling->sibling;
			emitRvalue(b, fd, symbols, n, l);
			puts("\tpush\trax\n");
			emitRvalue(a, fd, symbols, n, l);
			puts("\tpop\trdi\n");
			switch (op->kid->token) {
				case TOKEN_PLUS: puts("\tadd\trax, rdi\n"); break;
				case TOKEN_MINUS: puts("\tsub\trax, rdi\n"); break;
				case TOKEN_ASTERISK: puts("\tmul\trdi\n"); break;
				case TOKEN_DIVIDE: puts("\txor\trdx, rdx\n\tdiv\trdi\n"); break;
				case TOKEN_MODULUS: puts("\txor\trdx, rdx\n\tdiv\trdi\n\tmov\trax, rdx\n"); break;
				case TOKEN_AND: puts("\tand\trax, rdi\n"); break;
				case TOKEN_BAND: {
					puts("\txor\trdx, rdx\n");
					puts("\ttest\trax, rax\n");
					puts("\tsetnz\tdl\n");
					puts("\tmov\trax, rdx\n");
					puts("\txor\trdx, rdx\n");
					puts("\ttest\trdi, rdi\n");
					puts("\tsetnz\tdl\n");
					puts("\tmov\trdi, rdx\n");
					puts("\tand\trax, rdi\n");
				}
				break;
				case TOKEN_OR: puts("\tor\trax, rdi\n"); break;
				case TOKEN_BOR: {
					puts("\txor\trdx, rdx\n");
					puts("\ttest\trax, rax\n");
					puts("\tsetnz\tdl\n");
					puts("\tmov\trax, rdx\n");
					puts("\txor\trdx, rdx\n");
					puts("\ttest\trdi, rdi\n");
					puts("\tsetnz\tdl\n");
					puts("\tmov\trdi, rdx\n");
					puts("\tor\trax, rdi\n");
				}
				break;
				case TOKEN_XOR: puts("\txor\trax, rdi\n"); break;
				case TOKEN_LSHIFT: puts("\tmov\trcx, rdi\n\tshl\trax, cl\n"); break;
				case TOKEN_RSHIFT: puts("\tmov\trcx, rdi\n\tshr\trax, cl\n"); break;
				case TOKEN_EQUAL: {
					puts("\txor\trdx, rdx\n");
					puts("\tcmp\trax, rdi\n");
					puts("\tsete\tdl\n");
					puts("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_NOTEQUAL: {
					puts("\txor\trdx, rdx\n");
					puts("\tcmp\trax, rdi\n");
					puts("\tsetne\tdl\n");
					puts("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_GREATERTHAN: {
					puts("\txor\trdx, rdx\n");
					puts("\tcmp\trax, rdi\n");
					puts("\tsetg\tdl\n");
					puts("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_LESSTHAN: {
					puts("\txor\trdx, rdx\n");
					puts("\tcmp\trax, rdi\n");
					puts("\tsetl\tdl\n");
					puts("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_GEQ: {
					puts("\txor\trdx, rdx\n");
					puts("\tcmp\trax, rdi\n");
					puts("\tsetge\tdl\n");
					puts("\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_LEQ: {
					puts("\txor\trdx, rdx\n");
					puts("\tcmp\trax, rdi\n");
					puts("\tsetle\tdl\n");
					puts("\tmov\trax, rdx\n");
				}
				break;
			}
		}
		break;
		case RVALUE_FUNCTION_CALL: {
			astnode_t* f = rvalue->kid;
			astnode_t* param = f->sibling->sibling;
			emitLvalue(f, fd, symbols, n, l);
			puts("\tpush\trax\n");
			int i = 0;
			while (param && param->type == AST_RVALUE) {
				i++;
				emitRvalue(param, fd, symbols, n, l);
				puts("\tpush\trax\n");
				param = param->sibling->sibling;
			}
			while (i > 0) {
				printf("\tpop\t%s\n", 0, inRegOrder[--i]);
			}
			puts("\tpop\trax\n\tcall\trax\n");
		}
		break;
		case RVALUE_ASSIGN: {
			astnode_t* lvalue = rvalue->kid;
			rvalue = lvalue->sibling->sibling;
			emitLvalue(lvalue, fd, symbols, n, l);
			puts("\tpush\trax\n");
			emitRvalue(rvalue, fd, symbols, n, l);
			puts("\tpop\trdi\n");
			puts("\tmov\t[rdi], rax\n");
		}
		break;
		case RVALUE_LVALUE: {
			emitLvalue(rvalue->kid, fd, symbols, n, l);
			puts("\tmov\trax, [rax]\n");
		}
		break;
		case RVALUE_UNARY: {
			astnode_t* op = rvalue->kid;
			emitRvalue(rvalue->kid->sibling, fd, symbols, n, l);
			switch(op->kid->token) {
				case TOKEN_MINUS:
					puts("\tneg\trax\n");
				break;
				case TOKEN_NOT:
					puts("\tnot\trax\n");
				break;
				case TOKEN_BNOT:
					puts("\txor\trdx, rdx\n");
					puts("\ttest\trax, rax\n");
					puts("\tsetz\tdl\n");
					puts("\tmov\trax, rdx\n");
				break;
			}
		}
		break;
		case RVALUE_PARENS: emitRvalue(rvalue->kid->sibling, fd, symbols, n, l); break;
		case RVALUE_CONSTANT: {
			astnode_t* constant = rvalue->kid->kid;
			switch (constant->token) {
				case TOKEN_NUMBER: printf("\tmov\trax, %s\n", 0, constant->value); break;
				case TOKEN_STRING: {
					int l1 = (*l)++;
					int l2 = (*l)++;
					printf("\tjmp\t.L%d\n", l2, 0);
					printf(".L%d:\n", l1, 0);
					printf("\tdb\t%s\n", 0, constant->value);
					puts("\tdb 0\n");
					printf(".L%d:\n", l2, 0);
					printf("\tmov\trax, .L%d\n", l1, 0);
				}
				break;
			}
		}
		break;
	}
}

static int stringsAreEqual(char* a, char* b) {
	while ((*a == *b) && (*a) && (*b)) {
		a++;
		b++;
	}
	return *a == *b;
}

static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l) {
	switch (lvalue->subType) {
		case LVALUE_ID: {
			char* id = lvalue->kid->value;
			int i;

			for (i = 0; i < n; i++) {
				if (stringsAreEqual(id, symbols[i]))
					break;
			}

			if (i < n) {
				printf("\tmov\trax, rbp\n\tmov\trdi, %d\n\tsub\trax, rdi\n", (i + 1) * 8, 0);
				//printf("\tlea\trax, qword [rbp - %d]\n", (i + 1) * 8, 0);
			} else {
				for (i = 0; i < gCnt; i++) {
					if (stringsAreEqual(id, globals[i]))
						break;
				}
				if (i == gCnt) {
					printf("\textern\t%s\n", 0, id);
				}
				printf("\tmov\trax, %s\n", 0, id);
			}
		}
		break;
		case LVALUE_INDIRECTION: {
			astnode_t* rvalue = lvalue->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n, l);
		}
		break;
	}
}

static void emitStatement(astnode_t* statement, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l) {
	switch(statement->subType) {
		case STATEMENT_LOCAL: {
			error("local encounter after begining of subroutine");
		}
		break;
		case STATEMENT_IF: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n, l);
			int l1 = (*l)++;
			int l2 = (*l)++;
			printf("\ttest\trax, rax\n\tjz\t.L%d\n", l1, 0);
			astnode_t* substate = statement->kid->sibling->sibling->sibling;
			while (substate && substate->token != TOKEN_ELSE && substate->token != TOKEN_END) {
				emitStatement(substate, fd, symbols, n, l);
				substate = substate->sibling;
			}
			printf("\tjmp .L%d\n", l2, 0);
			printf(".L%d:\n", l1, 0);
			if (substate && substate->token == TOKEN_ELSE) {
				substate = substate->sibling;
				while (substate && substate->kid && substate->kid->token != TOKEN_END) {
					emitStatement(substate, fd, symbols, n, l);
					substate = substate->sibling;
				}
			}
			printf(".L%d:\n", l2, 0);
		}
		break;
		case STATEMENT_WHILE: {
			astnode_t* rvalue = statement->kid->sibling;
			int l1 = (*l)++;
			int l2 = (*l)++;
			astnode_t* substate = statement->kid->sibling->sibling->sibling;
			printf("\tjmp\t.L%d\n", l2, 0);
			printf(".L%d:\n", l1, 0);
			while (substate && substate->token != TOKEN_END) {
				emitStatement(substate, fd, symbols, n, l);
				substate = substate->sibling;
			}
			printf(".L%d:\n", l2, 0);
			emitRvalue(rvalue, fd, symbols, n, l);
			printf("\ttest\trax, rax\n\tjnz\t.L%d\n", l1, 0);
		}
		break;
		case STATEMENT_RETURN: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n, l);
			puts("\tmov\trsp, rbp\n");
			puts("\tpop\trbp\n");
			puts("\tret\n");
		}
		break;
		case STATEMENT_RVALUE: {
			astnode_t* rvalue = statement->kid;
			emitRvalue(rvalue, fd, symbols, n, l);
		}
		break;
	}
}

static void emitDefinition(astnode_t* definition, int fd, int *l) {
	astnode_t* functionId = definition->kid->sibling;
	char symbols[SYM_CNT][SYM_LEN];
	int n = 0;
	astnode_t* parameter = functionId->sibling->sibling;

	int s, r;
	for (s = 0; s < SYM_CNT; s++)
		for (r = 0; r < SYM_LEN; r++)
			symbols[s][r] = 0;

	putch(10);
	printf("%s:\n", 0, functionId->value);
	puts("\tpush\trbp\n");
	puts("\tmov\trbp, rsp\n");

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
				int i;

				/*
				printf("\tmov\trax, %d\n", m * 8, 0);
				printf("\tsub\trsp, rax\n", m * 8, 0);
				for (i = 0; i < n; i++) {
					printf("\tmov\tqword [rbp - %d], %s\n", (i + 1) * 8, inRegOrder[i]);
				}
				for (i = n; i < m; i++) {
					printf("\tmov\tqword [rbp - %d], 0\n", (i + 1) * 8, 0);
				}
				*/
				puts("\txor\trax, rax\n");
				for (i = 0; i < n; i++) {
					printf("\tpush\t%s\n", 0, inRegOrder[i]);
				}
				for (i = n; i < m; i++) {
					puts("\tpush\trax\n");
				}
				frameSetup = 1;
			}
			emitStatement(statement, fd, symbols, m, l);
		}
		statement = statement->sibling;
	}
	puts("\tmov\trsp, rbp\n");
	puts("\tpop\trbp\n");
	puts("\tret\n");
}

void emitProgram(astnode_t* program, int fd) {
	astnode_t* definition = program ? program->kid : 0;
	int l = 0;
	int i;
	puts("; this code was generated by a tool. assemble with nasm.\n");
	puts("bits 64\n\n");
	//puts("section .text\n");
	gCnt = 0;
	while (definition) {
		char* idStr = definition->kid->sibling->value;
		i = 0;
		while (idStr[i]) {
			globals[gCnt][i] = idStr[i];
			i++;
		}
		globals[gCnt][i] = 0;
		puts("global ");
		puts(globals[gCnt]);
		putch(10);
		definition = definition->sibling;
		gCnt++;
	}
	definition = program ? program->kid : 0;
	while (definition) {
		emitDefinition(definition, fd, &l);
		definition = definition->sibling;
	}
	puts("\n");
}
