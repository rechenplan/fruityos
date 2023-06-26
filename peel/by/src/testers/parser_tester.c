#include <stdio.h>
#include <stdlib.h>
#include "../lexer.h"
#include "../parser.h"

extern astnode_t* parseProgram(char** program);
extern astnode_t* createNode(int type);
extern void destroyNode(astnode_t* node);
extern void appendKid(astnode_t* parent, astnode_t* child);
extern char* tokens[];

void printAst(astnode_t* node) {
        if (!node) return;
        if (node->type == AST_LEAF) {
		if (node->token == TOKEN_STRING || node->token == TOKEN_NUMBER || node->token == TOKEN_ID) {
			printf("%s ", node->value);
                }
                else {
                        printf("%s ", tokens[node->token]);
                }
        }
        printAst(node->kid);
        printAst(node->sibling);
}

void* allocMemory(int size) {
	return malloc(size);
}

void freeMemory(void* ptr) {
	free(ptr);
}

void error(char* missing) {
	printf("syntax error: expected %s\n", missing);
	exit(1);
}

int main(int argc, char** argv) {
	char* prog = argv[1];
	if (argc == 2) {
		astnode_t* ast = parseProgram(&prog);
		printAst(ast);
		destroyNode(ast);
	} else {
		printf("Usage: %s string\n", argv[0]);
	}
}
