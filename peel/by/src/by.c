#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "parser.h"

extern astnode_t* parseProgram(char** program);
extern void emitProgram(astnode_t* program, int fd);

void error(char* missing) { printf("syntax error: expected %s\n", missing); exit(1); }
void* allocMemory(int size) { return malloc(size); }
void freeMemory(void* ptr) { free(ptr); }

int main(int argc, char** argv) {
	if (argc == 2) {
		FILE* f = fopen(argv[1], "r");
		if (!f) {
			printf("Unable to open \"%s\"\n", argv[1]);
			exit(1);
		}
		fseek(f, 0, SEEK_END);
		int size = ftell(f);
		rewind(f);
		char* buf = malloc(size);
		char* prog = buf;
		fread(buf, size, 1, f);
		fclose(f);
		emitProgram(parseProgram(&prog), 0);
		free(buf);
	} else {
		printf("usage: %s file\n", argv[0]);
	}
}
