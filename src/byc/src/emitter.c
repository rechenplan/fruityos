#include "pith.h"
#include "lexer.h"
#include "parser.h"

#define SYM_CNT	1024
#define SYM_LEN 256

extern void fputs(int fd, char* str);
extern void fprintf(int fd, char* fmt, int n, char* s);
extern void error(char* msg);

static char globals[SYM_CNT][SYM_LEN];
static int gCnt;
static char* inRegOrder[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };
static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l, char* fcn);

static void emitRvalue(astnode_t* rvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l, char* fcn) {
	switch (rvalue->subType) {
		case RVALUE_BINOP: {
			astnode_t* a = rvalue->kid;
			astnode_t* op = rvalue->kid->sibling;
			astnode_t* b = rvalue->kid->sibling->sibling;
			emitRvalue(b, fd, symbols, n, l, fcn);
			fputs(fd, "\tpush\trax\n");
			emitRvalue(a, fd, symbols, n, l, fcn);
			fputs(fd, "\tpop\trdi\n");
			switch (op->kid->token) {
				case TOKEN_PLUS: fputs(fd, "\tadd\trax, rdi\n"); break;
				case TOKEN_MINUS: fputs(fd, "\tsub\trax, rdi\n"); break;
				case TOKEN_ASTERISK: fputs(fd, "\tmul\trdi\n"); break;
				case TOKEN_DIVIDE: fputs(fd, "\txor\trdx, rdx\n\tdiv\trdi\n"); break;
				case TOKEN_MODULUS: fputs(fd, "\txor\trdx, rdx\n\tdiv\trdi\n\tmov\trax, rdx\n"); break;
				case TOKEN_AND: fputs(fd, "\tand\trax, rdi\n"); break;
				case TOKEN_BAND: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\ttest\trax, rax\n");
					fputs(fd, "\tsetnz\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\ttest\trdi, rdi\n");
					fputs(fd, "\tsetnz\tdl\n");
					fputs(fd, "\tmov\trdi, rdx\n");
					fputs(fd, "\tand\trax, rdi\n");
				}
				break;
				case TOKEN_OR: fputs(fd, "\tor\trax, rdi\n"); break;
				case TOKEN_BOR: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\ttest\trax, rax\n");
					fputs(fd, "\tsetnz\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\ttest\trdi, rdi\n");
					fputs(fd, "\tsetnz\tdl\n");
					fputs(fd, "\tmov\trdi, rdx\n");
					fputs(fd, "\tor\trax, rdi\n");
				}
				break;
				case TOKEN_XOR: fputs(fd, "\txor\trax, rdi\n"); break;
				case TOKEN_LSHIFT: fputs(fd, "\tmov\trcx, rdi\n\tshl\trax, cl\n"); break;
				case TOKEN_RSHIFT: fputs(fd, "\tmov\trcx, rdi\n\tshr\trax, cl\n"); break;
				case TOKEN_EQUAL: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\tcmp\trax, rdi\n");
					fputs(fd, "\tsete\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_NOTEQUAL: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\tcmp\trax, rdi\n");
					fputs(fd, "\tsetne\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_GREATERTHAN: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\tcmp\trax, rdi\n");
					fputs(fd, "\tsetg\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_LESSTHAN: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\tcmp\trax, rdi\n");
					fputs(fd, "\tsetl\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_GEQ: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\tcmp\trax, rdi\n");
					fputs(fd, "\tsetge\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				}
				break;
				case TOKEN_LEQ: {
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\tcmp\trax, rdi\n");
					fputs(fd, "\tsetle\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				}
				break;
			}
		}
		break;
		case RVALUE_FUNCTION_CALL: {
			astnode_t* f = rvalue->kid;
			astnode_t* param = f->sibling->sibling;
			emitLvalue(f, fd, symbols, n, l, fcn);
			fputs(fd, "\tpush\trax\n");
			int i = 0;
			while (param && param->type == AST_RVALUE) {
				i++;
				emitRvalue(param, fd, symbols, n, l, fcn);
				fputs(fd, "\tpush\trax\n");
				param = param->sibling->sibling;
			}
			while (i > 0) {
				fprintf(fd, "\tpop\t%s\n", 0, inRegOrder[--i]);
			}
			fputs(fd, "\tpop\trax\n\tcall\trax\n");
		}
		break;
		case RVALUE_ASSIGN: {
			astnode_t* lvalue = rvalue->kid;
			rvalue = lvalue->sibling->sibling;
			emitLvalue(lvalue, fd, symbols, n, l, fcn);
			fputs(fd, "\tpush\trax\n");
			emitRvalue(rvalue, fd, symbols, n, l, fcn);
			fputs(fd, "\tpop\trdi\n");
			fputs(fd, "\tmov\t[rdi], rax\n");
		}
		break;
		case RVALUE_LVALUE: {
			emitLvalue(rvalue->kid, fd, symbols, n, l, fcn);
			fputs(fd, "\tmov\trax, [rax]\n");
		}
		break;
		case RVALUE_UNARY: {
			astnode_t* op = rvalue->kid;
			emitRvalue(rvalue->kid->sibling, fd, symbols, n, l, fcn);
			switch(op->kid->token) {
				case TOKEN_MINUS:
					fputs(fd, "\tneg\trax\n");
				break;
				case TOKEN_NOT:
					fputs(fd, "\tnot\trax\n");
				break;
				case TOKEN_BNOT:
					fputs(fd, "\txor\trdx, rdx\n");
					fputs(fd, "\ttest\trax, rax\n");
					fputs(fd, "\tsetz\tdl\n");
					fputs(fd, "\tmov\trax, rdx\n");
				break;
			}
		}
		break;
		case RVALUE_PARENS: emitRvalue(rvalue->kid->sibling, fd, symbols, n, l, fcn); break;
		case RVALUE_CONSTANT: {
			astnode_t* constant = rvalue->kid->kid;
			switch (constant->token) {
				case TOKEN_NUMBER: fprintf(fd, "\tmov\trax, %s\n", 0, constant->value); break;
				case TOKEN_STRING: {
					int l1 = (*l)++;
					int l2 = (*l)++;
					fprintf(fd, "\tjmp\t%s_L%d\n", l2, fcn);
					fprintf(fd, "%s_L%d:\n", l1, fcn);
					fprintf(fd, "\tdb\t%s\n", 0, constant->value);
					fputs(fd, "\tdb 0\n");
					fprintf(fd, "%s_L%d:\n", l2, fcn);
					fprintf(fd, "\tmov\trax, %s_L%d\n", l1, fcn);
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

static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l, char* fcn) {
	switch (lvalue->subType) {
		case LVALUE_ID: {
			char* id = lvalue->kid->value;
			int i;

			for (i = 0; i < n; i++) {
				if (stringsAreEqual(id, symbols[i]))
					break;
			}

			if (i < n) {
				fprintf(fd, "\tmov\trax, rbp\n\tmov\trdi, %d\n\tsub\trax, rdi\n", (i + 1) * 8, 0);
				//fprintf(fd, "\tlea\trax, qword [rbp - %d]\n", (i + 1) * 8, 0);
			} else {
				/*
				for (i = 0; i < gCnt; i++) {
					if (stringsAreEqual(id, globals[i]))
						break;
				}
				if (i == gCnt) {
					fprintf(fd, "Undefined symbol %s\n", 0, id);
					exit();
				}
				*/
				fprintf(fd, "\tmov\trax, %s\n", 0, id);
			}
		}
		break;
		case LVALUE_INDIRECTION: {
			astnode_t* rvalue = lvalue->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n, l, fcn);
		}
		break;
	}
}

static void emitStatement(astnode_t* statement, int fd, char symbols[SYM_CNT][SYM_LEN], int n, int* l, char* fcn) {
	switch(statement->subType) {
		case STATEMENT_LOCAL: {
			error("local encounter after begining of subroutine");
		}
		break;
		case STATEMENT_IF: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n, l, fcn);
			int l1 = (*l)++;
			int l2 = (*l)++;
			fprintf(fd, "\ttest\trax, rax\n\tjz\t%s_L%d\n", l1, fcn);
			astnode_t* substate = statement->kid->sibling->sibling->sibling;
			while (substate && substate->token != TOKEN_ELSE && substate->token != TOKEN_END) {
				emitStatement(substate, fd, symbols, n, l, fcn);
				substate = substate->sibling;
			}
			fprintf(fd, "\tjmp %s_L%d\n", l2, fcn);
			fprintf(fd, "%s_L%d:\n", l1, fcn);
			if (substate && substate->token == TOKEN_ELSE) {
				substate = substate->sibling;
				while (substate && substate->kid && substate->kid->token != TOKEN_END) {
					emitStatement(substate, fd, symbols, n, l, fcn);
					substate = substate->sibling;
				}
			}
			fprintf(fd, "%s_L%d:\n", l2, fcn);
		}
		break;
		case STATEMENT_WHILE: {
			astnode_t* rvalue = statement->kid->sibling;
			int l1 = (*l)++;
			int l2 = (*l)++;
			astnode_t* substate = statement->kid->sibling->sibling->sibling;
			fprintf(fd, "\tjmp\t%s_L%d\n", l2, fcn);
			fprintf(fd, "%s_L%d:\n", l1, fcn);
			while (substate && substate->token != TOKEN_END) {
				emitStatement(substate, fd, symbols, n, l, fcn);
				substate = substate->sibling;
			}
			fprintf(fd, "%s_L%d:\n", l2, fcn);
			emitRvalue(rvalue, fd, symbols, n, l, fcn);
			fprintf(fd, "\ttest\trax, rax\n\tjnz\t%s_L%d\n", l1, fcn);
		}
		break;
		case STATEMENT_RETURN: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n, l, fcn);
			fputs(fd, "\tmov\trsp, rbp\n");
			fputs(fd, "\tpop\trbp\n");
			fputs(fd, "\tret\n");
		}
		break;
		case STATEMENT_RVALUE: {
			astnode_t* rvalue = statement->kid;
			emitRvalue(rvalue, fd, symbols, n, l, fcn);
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

	fputch(fd,10);
	fprintf(fd, "%s:\n", 0, functionId->value);
	fputs(fd, "\tpush\trbp\n");
	fputs(fd, "\tmov\trbp, rsp\n");

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
				fprintf(fd, "\tmov\trax, %d\n", m * 8, 0);
				fprintf(fd, "\tsub\trsp, rax\n", m * 8, 0);
				for (i = 0; i < n; i++) {
					fprintf(fd, "\tmov\tqword [rbp - %d], %s\n", (i + 1) * 8, inRegOrder[i]);
				}
				for (i = n; i < m; i++) {
					fprintf(fd, "\tmov\tqword [rbp - %d], 0\n", (i + 1) * 8, 0);
				}
				*/
				fputs(fd, "\txor\trax, rax\n");
				for (i = 0; i < n; i++) {
					fprintf(fd, "\tpush\t%s\n", 0, inRegOrder[i]);
				}
				for (i = n; i < m; i++) {
					fputs(fd, "\tpush\trax\n");
				}
				frameSetup = 1;
			}
			emitStatement(statement, fd, symbols, m, l, functionId->value);
		}
		statement = statement->sibling;
	}
	fputs(fd, "\tmov\trsp, rbp\n");
	fputs(fd, "\tpop\trbp\n");
	fputs(fd, "\tret\n");
}

void emitProgram(astnode_t* program, int fd) {
	astnode_t* definition = program ? program->kid : 0;
	int l = 0;
	int i;
	fputs(fd, "; this code was generated by a tool. assemble with nasm.\n");
	fputs(fd, "bits 64\n\n");
	//fputs(fd, "section .text\n");
	gCnt = 0;
	while (definition) {
		char* idStr = definition->kid->sibling->value;
		i = 0;
		while (idStr[i]) {
			globals[gCnt][i] = idStr[i];
			i++;
		}
		globals[gCnt][i] = 0;
		fputs(fd, "global ");
		fputs(fd, globals[gCnt]);
		fputch(fd,10);
		definition = definition->sibling;
		gCnt++;
	}
	definition = program ? program->kid : 0;
	while (definition) {
		l = 0;
		emitDefinition(definition, fd, &l);
		definition = definition->sibling;
	}
	fputs(fd, "\n");
}
