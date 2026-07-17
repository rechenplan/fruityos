#!/bin/sh
set -eu

if [ "$#" -ne 3 ]; then
    echo "usage: test-link-linux.sh MARS ORGASM PAD" >&2
    exit 2
fi

mars=$1
orgasm=$2
pad=$3
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=${TMPDIR:-/tmp}/mars-link-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"

"$mars" -o 65792 -M "$tmp/sol.map" "$here/link.sol"
grep '^sol_entry equ 65792$' "$tmp/sol.map" >/dev/null
"$orgasm" -m "$tmp/asm.map" "$tmp/sol.map" "$here/link.asm" "$tmp/asm.bin"
"$pad" "$tmp/asm.bin" 256 256
"$mars" -o 65792 -M "$tmp/final.map" "$here/link.sol" "$tmp/asm.map"
grep '^sol_end equ ' "$tmp/sol.map" > "$tmp/sol-end"
grep '^sol_end equ ' "$tmp/final.map" > "$tmp/final-end"
cmp "$tmp/sol-end" "$tmp/final-end"
"$mars" -o 65792 "$here/link.sol" "$tmp/asm.map" "$tmp/sol.bin"
cat "$tmp/asm.bin" "$tmp/sol.bin" > "$tmp/image.bin"
cc -O2 -Wall -Wextra "$here/link-harness.c" -o "$tmp/harness"
"$tmp/harness" "$tmp/image.bin"
