#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char* tokens[];
extern int nextToken(char* buffer, int* read, char* outBuf);

int printProgram(char* program) {
	char buffer[256];
	int read = 0;
	int symbol = 0;

	while (*program) {
		symbol = nextToken(program, &read, buffer);
		if (symbol == -4) return -1;
		program += read;
		if (symbol < 0) {
			printf("%s\n", buffer);
		}
		else {
			printf("%s\n", tokens[symbol]);
		}
	}
	return 0;
}

int main(int argc, char** argv) {
	if (argc == 2) {
		if (printProgram(argv[1]) < 0)
			printf("SYNTAX ERROR\n");
	} else {
		printf("Usage: %s string\n", argv[0]);
	}

}
