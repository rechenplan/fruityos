#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "parser.h"

#define SYM_CNT	256
#define SYM_LEN 256

extern astnode_t* parseProgram(char** program);
static void emitLvalue(astnode_t* lvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n);

void error(char* missing) { printf("syntax error: expected %s\n", missing); exit(1); }
void* allocMemory(int size) { return malloc(size); }
void freeMemory(void* ptr) { free(ptr); }

static void emitRvalue(astnode_t* rvalue, int fd, char symbols[SYM_CNT][SYM_LEN], int n) {
	switch (rvalue->subType) {
		case -1: emitRvalue(rvalue->kid, fd, symbols, n); break;
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
				case TOKEN_ASTERISK: break;
				case TOKEN_DIVIDE: break;
				case TOKEN_MODULUS: break;
				case TOKEN_AND: printf("\tand\trax, rdi\n"); break;
				case TOKEN_BAND: break;
				case TOKEN_OR: printf("\tor\trax, rdi\n"); break;
				case TOKEN_BOR: break;
				case TOKEN_XOR: printf("\txor\trax, rdi\n"); break;
				case TOKEN_LSHIFT: break;
				case TOKEN_RSHIFT: break;
				case TOKEN_EQUAL: break;
				case TOKEN_NOTEQUAL: break;
				case TOKEN_GREATERTHAN: break;
				case TOKEN_LESSTHAN: break;
				case TOKEN_GEQ: break;
				case TOKEN_LEQ: break;
			}
		}
		break;
		case RVALUE_FUNCTION_CALL: break;
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
		case RVALUE_LVALUE: emitLvalue(rvalue->kid, fd, symbols, n); printf("\tmov\trax, qword [rax]\n"); break;
		case RVALUE_UNARY: break;
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
			else
				printf("\tmov\trax, %s\n", id);
		}
		break;
		case LVALUE_INDIRECTION: {
			astnode_t* rvalue = lvalue->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n);
		}
		break;
	}
}

static void emitStatement(astnode_t* statement, int fd, char symbols[SYM_CNT][SYM_LEN], int n) {
	switch(statement->subType) {
		case STATEMENT_LOCAL: {
			// should have appeared at the begining of the function!
		}
		break;
		case STATEMENT_IF: {
		}
		break;
		case STATEMENT_WHILE: {
		}
		break;
		case STATEMENT_RETURN: {
			astnode_t* rvalue = statement->kid->sibling;
			emitRvalue(rvalue, fd, symbols, n);
			printf("\tmov\trsp, rbp\n");
			printf("\tret\n\n");
		}
		break;
		case STATEMENT_RVALUE: {
			astnode_t* rvalue = statement->kid;
			emitRvalue(rvalue, fd, symbols, n);
		}
		break;
	}
}

static char* inRegOrder[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9", "rbp+8", "rbp+16", "rbp+24"};

static void emitDefinition(astnode_t* definition, int fd) {
	astnode_t* functionId = definition->kid->sibling;
	char symbols[SYM_CNT][SYM_LEN];
	memset(symbols, 0, sizeof(symbols));
	printf("global %s\n", functionId->value);
	printf("%s:", functionId->value);
	astnode_t* parameter = functionId->sibling->sibling;
	int n = 0;
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
				printf("\n");
				printf("\tmov\trbp, rsp\n");
				printf("\tsub\trsp, %d\n", m * 8);
				int i;
				for (i = 0; i < n; i++) {
					printf("\tmov\tqword [rbp - %d], %s\t;%s\n", (i + 1) * 8, inRegOrder[i], symbols[i]);
				}
				for (i = n; i < m; i++) {
					printf("\tmov\tqword [rbp - %d], 0\t;%s\n", (i + 1) * 8, symbols[i]);
				}
				frameSetup = 1;
			}
			emitStatement(statement, fd, symbols, m);
		}
		statement = statement->sibling;
	}
}

static void emitProgram(astnode_t* program, int fd) {
	astnode_t* definition = program->kid;
	printf("bits 64\n\n");
	printf("section .text\n\n");
	while (definition) {
		emitDefinition(definition, fd);
		definition = definition->sibling;
	}
}


int main(int argc, char** argv) {
	char* prog = argv[1];
	emitProgram(parseProgram(&prog), 0);
}
