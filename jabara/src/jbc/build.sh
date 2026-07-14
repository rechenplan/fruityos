#!/bin/sh
set -eu

echo "Building jbc..."
cc -std=c89 -pedantic -Wall -Wextra -Werror -O2 -c jbc.c -o jbc.o
cc -std=c89 -pedantic -Wall -Wextra -Werror -O2 -c lexer.c -o lexer.o
cc -std=c89 -pedantic -Wall -Wextra -Werror -O2 -c parser.c -o parser.o
cc -std=c89 -pedantic -Wall -Wextra -Werror -O2 -c emitter.c -o emitter.o
cc jbc.o lexer.o parser.o emitter.o -o ../../bin/jbc
rm -f jbc.o lexer.o parser.o emitter.o
