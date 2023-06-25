#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char* tokens[];
extern int nextToken(char* buffer, int* read, char* outBuf);

void printProgram(char* program) {
	char buffer[256];
	int read = 0;
	int symbol = 0;

	while (*program) {
		symbol = nextToken(program, &read, buffer);
		program += read;
		if (symbol < 0) {
			printf("%s\n", buffer);
		}
		else {
			printf("%s\n", tokens[symbol]);
		}
	}
}

int main(int argc, char** argv) {
	if (argc == 2) {
		printProgram(argv[1]);
	} else {
		printf("Usage: %s string\n", argv[0]);
	}

}
