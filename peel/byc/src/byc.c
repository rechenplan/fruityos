#include "pith.h"
#include "lexer.h"
#include "parser.h"

void puts(char* s) {
	while (*s) {
		putch(*(s++));
	}
}

static void putn(int n) {
	int m, i = 100000000;
	while (i > 0) {
		m = n / i;
		putch(m + '0');
		n %= i;
		i = i / 10;
	}
}

void printf(char* fmt, int n, char* s) {
	while (*fmt) {
		char c = *(fmt++);
		if (c == '\\') {
			c = *(fmt++);
			switch (c) {
				case 't': putch('\t'); break;
				case 'n': putch('\n'); break;
			}
		}
		else if (c == '%') {
			c = *(fmt++);
			switch (c) {
				case 's': puts(s); break;
				case 'd': putn(n); break;
			}
		}
		else {
			putch(c);
		}
	}
}

extern astnode_t* parseProgram(char** program);
extern void emitProgram(astnode_t* program, int fd);

void error(char* msg) { printf("err: %s\n", 0, msg); exit(); }
void* sbrk(unsigned int size) { void* t = brk(-1); brk(t + size); return t; }
void* allocMemory(int size) { return sbrk(size); }
void freeMemory(void* ptr) { }


char* getNextArg(char* arg) {
	while (*(arg++));
	return arg;
}

int main(int argc, char* arg) {
	if (argc == 2) {
		char* fname = getNextArg(arg);
		int fd = open(fname, 0);
		if (fd < 0) {
			printf("Unable to open \"%s\"\n", 0, fname);
			exit();
		}
		char* buf = allocMemory(1024 * 1024);
		char* prog = buf;
		*prog = 1;
		while (read(fd, prog++, 1) > 0 && (prog - buf < 1024 * 1024)) {}
		close(fd);
		*prog = 0;
		prog = buf;
		emitProgram(parseProgram(&prog), 0);
		freeMemory(buf);
	} else {
		printf("usage: %s filename\n", 0, arg);
	}
}
