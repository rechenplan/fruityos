#include "pith.h"

auto_t main(int argc, char* argv) {
	while (argc > 0) {
		while (*argv)
			putch(*(argv++));
		putch(10);
		argv++;
		argc--;
	}
	while (*argv) {
		while (*argv)
			putch(*(argv++));
		putch(10);
		argv++;
	}
	return 0;
}
