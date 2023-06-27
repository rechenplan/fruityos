#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
#include "parser.h"

extern astnode_t* parseProgram(char** program);

void error(char* missing) { printf("syntax error: expected %s\n", missing); exit(1); }
void* allocMemory(int size) { return malloc(size); }
void freeMemory(void* ptr) { free(ptr); }

static void emitRvalue(astnode_t* rvalue, int fd) {
	switch (rvalue->subType) {
		case RVALUE_BINOP:
		case RVALUE_FUNCTION_CALL:
		case RVALUE_ASSIGN:
		case RVALUE_LVALUE:
		case RVALUE_UNARY:
		case RVALUE_PARENS:
		case RVALUE_CONSTANT:
		break;
	}
}

static void emitLvalue(astnode_t* lvalue, int fd) {
	switch (lvalue->subType) {
		case LVALUE_ID:
		case LVALUE_INDIRECTION:
		break;
	}
}

static void emitStatement(astnode_t* statement, int fd) {
	switch(statement->subType) {
		case STATEMENT_LOCAL: {
			int idCnt = 0;
			astnode_t* node = statement->kid;
			while (node) {
				node = node->sibling->sibling;
				idCnt++;
			}
			printf("\tsub\trsp, %d\n", 8 * idCnt);
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
			emitRvalue(rvalue, fd);
			printf("\tmov\trsp, rbp\n");
			printf("\tret\n\n");
		}
		break;
		case STATEMENT_RVALUE: {
			astnode_t* rvalue = statement->kid;
			emitRvalue(rvalue, fd);
		}
		break;
	}
}

static char* inRegOrder[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9", "rbp+8", "rbp+16", "rbp+24"};

static void emitDefinition(astnode_t* definition, int fd) {
	astnode_t* functionId = definition->kid->sibling;
	printf("global %s\n", functionId->value);
	printf("%s: ; ", functionId->value);
	astnode_t* parameter = functionId->sibling->sibling;
	int n = 0;
	if (parameter && parameter->token == TOKEN_RPAREN) {
		printf("no parameters\n");
	}
	else {
		while (parameter && parameter->token == TOKEN_ID) {
			printf("%s=%s ", inRegOrder[n++], parameter->value);
			parameter = parameter->sibling->sibling;
		}
	}
	printf("\n");
	printf("\tmov\trbp, rsp\n");
	astnode_t* statement = parameter;
	while (statement->type == AST_STATEMENT) {
		emitStatement(statement, fd);
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
