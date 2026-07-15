#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
rm -f "$root/jbc.o" "$root/lexer.o" "$root/parser.o" "$root/emitter.o"
