#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
#include "parser.h"

/*
	Bytecode

	00: null-terminator
	01: identifier (next word is index in table)
	02: deffunc (00 if 00 { 01 } 01 deffunc
*/

extern astnode_t* parseProgram(char** program);

void error(char* missing) { printf("syntax error: expected %s\n", missing); exit(1); }
void* allocMemory(int size) { return malloc(size); }
void freeMemory(void* ptr) { free(ptr); }

static void emitRvalue(astnode_t* rvalue, int fd) {
}

static void emitLvalue(astnode_t* lvalue, int fd) {
}

static void emitStatement(astnode_t* statement, int fd) {
	switch(statement->subType) {
		case STATEMENT_LOCAL:
			printf("local statement\n");
		break;
		case STATEMENT_IF:
			printf("if statement\n");
		break;
		case STATEMENT_WHILE:
			printf("while statement\n");
		break;
		case STATEMENT_RETURN:
			printf("return statement\n");
		break;
		case STATEMENT_RVALUE:
			printf("rvalue statement\n");
		break;
	}
}


static void emitDefinition(astnode_t* definition, int fd) {
	astnode_t* functionId = definition->kid->sibling;
	printf("Defining function \"%s\" with identifiers: ", functionId->value);
	astnode_t* parameter = functionId->sibling->sibling;
	if (parameter && parameter->token == TOKEN_RPAREN) {
		printf("none\n");
	}
	else {
		while (parameter && parameter->token == TOKEN_ID) {
			printf("%s ", parameter->value);
			parameter = parameter->sibling->sibling;
		}
	}
	printf("\n");
	astnode_t* statement = parameter;
	while (statement->type == AST_STATEMENT) {
		emitStatement(statement, fd);
		statement = statement->sibling;
	}
}

static void emitProgram(astnode_t* program, int fd) {
	astnode_t* definition = program->kid;
	while (definition) {
		emitDefinition(definition, fd);
		definition = definition->sibling;
	}
}


int main(int argc, char** argv) {
	char* prog = argv[1];
	emitProgram(parseProgram(&prog), 0);
}
