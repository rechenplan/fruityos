#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
    echo "usage: test-linux.sh PHOBOS" >&2
    exit 2
fi

phobos=$1
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=${TMPDIR:-/tmp}/phobos-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"
cc -O2 -Wall -Wextra "$here/harness.c" -o "$tmp/harness"

"$phobos" "$here/semantics.sol" "$tmp/semantics.bin"
"$tmp/harness" "$tmp/semantics.bin" 0

"$phobos" "$here/words.sol" "$tmp/words.bin"
"$tmp/harness" "$tmp/words.bin" 42

"$phobos" "$here/compact.sol" "$tmp/compact.bin"
[ "$(wc -c < "$tmp/compact.bin")" -eq 44 ]

"$phobos" "$here/multiple-first.sol" "$here/multiple-second.sol" "$tmp/split.bin"
"$phobos" "$here/multiple-combined.sol" "$tmp/combined.bin"
cmp "$tmp/split.bin" "$tmp/combined.bin"

"$phobos" "$here/extern-first.sol" "$here/extern-second.sol" "$tmp/extern.bin"
if "$phobos" "$here/extern-first.sol" "$tmp/unresolved.bin" >"$tmp/out" 2>"$tmp/err"; then
    echo "expected unresolved extern to fail" >&2
    exit 1
fi

"$phobos" "$here/data.sol" "$tmp/data.bin"
actual=$(od -An -tx1 -v "$tmp/data.bin" | tr -d ' \n')
expected=0100000000332277665544ffeeddccbbaa99888070605040302010410a00
if [ "$actual" != "$expected" ]; then
    echo "unexpected data layout: $actual" >&2
    exit 1
fi

"$phobos" "$here/semantics.sol" "$tmp/first.bin"
"$phobos" "$here/semantics.sol" "$tmp/second.bin"
cmp "$tmp/first.bin" "$tmp/second.bin"

{
    echo 'sol 1'
    echo 'org 0'
    awk 'BEGIN { for (i = 0; i < 100000; i++) print "nop" }'
} > "$tmp/stress.sol"
"$phobos" "$tmp/stress.sol" "$tmp/stress.bin"
[ "$(wc -c < "$tmp/stress.bin")" -eq 100000 ]
