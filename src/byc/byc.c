#include "pith.h"
#include "lexer.h"
#include "parser.h"

void fputs(int fd, char* s) {
	while (*s) {
		fputch(fd, *(s++));
	}
}

static void fputn(int fd, int n) {
	int m, i = 100000000;
	int trailing = 1;
	if (!n) {
		fputch(fd, '0');
		return;
	}
	while (i > 0) {
		m = n / i;
		if (trailing) {
			if (m != 0) {
				trailing = 0;
				fputch(fd, m + '0');
			}
		}
		else {
			fputch(fd, m + '0');
		}
		n %= i;
		i = i / 10;
	}
}

void fprintf(int fd, char* fmt, int n, char* s) {
	while (*fmt) {
		char c = *(fmt++);
		if (c == '\\') {
			c = *(fmt++);
			switch (c) {
				case 't': fputch(fd, '\t'); break;
				case 'n': fputch(fd, '\n'); break;
			}
		}
		else if (c == '%') {
			c = *(fmt++);
			switch (c) {
				case 's': fputs(fd, s); break;
				case 'd': fputn(fd, n); break;
			}
		}
		else {
			fputch(fd, c);
		}
	}
}

extern astnode_t* parseProgram(char** program);
extern void emitProgram(astnode_t* program, int fd);

void error(char* msg) { fprintf(0, "err: %s\n", 0, msg); exit(); }
void* sbrk(unsigned int size) { void* t = brk(-1); brk(t + size); return t; }
void* allocMemory(int size) { return sbrk(size); }
void freeMemory(void* ptr) { }


char* getNextArg(char* arg) {
	while (*(arg++));
	return arg;
}

int main(int argc, char* arg) {
	if (argc == 3) {
		char* fname = getNextArg(arg);
		int fd = open(fname, 0);
		if (fd < 0) {
			fprintf(0, "Unable to open \"%s\"\n", 0, fname);
			exit();
		}
		char* oname = getNextArg(fname);
		int fout = creat(oname);
		char* buf = allocMemory(1024 * 1024);
		char* prog = buf;
		*prog = 1;
		while (read(fd, prog++, 1) > 0 && (prog - buf < 1024 * 1024)) {}
		close(fd);
		*prog = 0;
		prog = buf;
		emitProgram(parseProgram(&prog), fout);
		close(fout);
		freeMemory(buf);
	} else {
		fprintf(0, "usage: %s in.yuzu out.asm\n", 0, arg);
	}
}
