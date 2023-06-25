#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../lexer.h"

extern char* tokens[];

int printProgram(char* program) {
	char buffer[256];
	int read = 0;
	int tokenIdx = 0;

	while (*program) {
		tokenIdx = nextToken(program, &read, buffer);
		program += read;
		if (tokenIdx < 0) {
			return -1;
		} else if (tokenIdx == TOKEN_STRING || tokenIdx == TOKEN_NUMBER || tokenIdx == TOKEN_NAME) {
			printf("%s\n", buffer);
		} else {
			printf("%s\n", tokens[tokenIdx]);
		}
	}
	return 0;
}

int main(int argc, char** argv) {
	if (argc == 2) {
		if (printProgram(argv[1]) < 0) {
			printf("SYNTAX ERROR\n");
		}
	} else {
		printf("Usage: %s string\n", argv[0]);
	}
}
