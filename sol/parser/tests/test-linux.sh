#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
    echo "usage: test-linux.sh ROOT" >&2
    exit 2
fi

root=$(CDPATH= cd -- "$1" && pwd)
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
parser=$(CDPATH= cd -- "$here/.." && pwd)
tmp=${TMPDIR:-/tmp}/sol-parser-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"

for name in parser errors instructions words stress; do
    "$root/bin/pish" "$root/bin/jc.psh" linux-x86_64 "$tmp/$name" \
        "$parser/model.hr" "$parser/lexer.hr" "$parser/parser.hr" \
        "$here/$name.hr"
    "$tmp/$name"
done
