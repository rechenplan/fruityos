#include <stdio.h>
#include <stdlib.h>

extern int parseProgram(char** program);

void error(char* missing) {
	printf("syntax error: expected %s\n", missing);
	exit(1);
}

void report(char* token) {
	printf("%s\n", token);
}

int main(int argc, char** argv) {
	char* prog = argv[1];
	if (argc == 2) {
		parseProgram(&prog);
	} else {
		printf("Usage: %s string\n", argv[0]);
	}
}
