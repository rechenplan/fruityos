#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
    echo "usage: test-linux.sh MARS" >&2
    exit 2
fi

mars=$1
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=${TMPDIR:-/tmp}/mars-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"
cc -O2 -Wall -Wextra "$here/harness.c" -o "$tmp/harness"

"$mars" "$here/semantics.sol" "$tmp/semantics.bin"
"$tmp/harness" "$tmp/semantics.bin" 0

"$mars" "$here/words.sol" "$tmp/words.bin"
"$tmp/harness" "$tmp/words.bin" 42

"$mars" "$here/compact.sol" "$tmp/compact.bin"
[ "$(wc -c < "$tmp/compact.bin")" -eq 41 ]

"$mars" "$here/multiple-first.sol" "$here/multiple-second.sol" "$tmp/split.bin"
"$mars" "$here/multiple-combined.sol" "$tmp/combined.bin"
cmp "$tmp/split.bin" "$tmp/combined.bin"

"$mars" "$here/extern-first.sol" "$here/extern-second.sol" "$tmp/extern.bin"
if "$mars" "$here/extern-first.sol" "$tmp/unresolved.bin" >"$tmp/out" 2>"$tmp/err"; then
    echo "expected unresolved extern to fail" >&2
    exit 1
fi

"$mars" "$here/data.sol" "$tmp/data.bin"
actual=$(od -An -tx1 -v "$tmp/data.bin" | tr -d ' \n')
expected=0100000000332277665544ffeeddccbbaa99888070605040302010410a00
if [ "$actual" != "$expected" ]; then
    echo "unexpected data layout: $actual" >&2
    exit 1
fi

"$mars" "$here/semantics.sol" "$tmp/first.bin"
"$mars" "$here/semantics.sol" "$tmp/second.bin"
cmp "$tmp/first.bin" "$tmp/second.bin"

{
    echo 'sol 1'
    echo 'org 0'
    awk 'BEGIN { for (i = 0; i < 100000; i++) print "nop" }'
} > "$tmp/stress.sol"
"$mars" "$tmp/stress.sol" "$tmp/stress.bin"
[ "$(wc -c < "$tmp/stress.bin")" -eq 100000 ]
