#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
jabara=$(CDPATH= cd -- "$root/../.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jbc-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

echo "Building jbc..."
for source in jbc lexer parser emitter; do
    cc -std=c89 -pedantic -Wall -Wextra -Werror -O2 \
        -c "$root/$source.c" -o "$tmp/$source.o"
done
cc "$tmp/jbc.o" "$tmp/lexer.o" "$tmp/parser.o" "$tmp/emitter.o" \
    -o "$jabara/bin/jbc"
