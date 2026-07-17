#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "usage: test-linux.sh HARUKA MARS" >&2
    exit 2
fi

haruka=$1
mars=$2
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
runtime=$here/../../lib/haruka-runtime.sol
tmp=${TMPDIR:-/tmp}/haruka-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"
cc -O2 -Wall -Wextra "$here/harness.c" -o "$tmp/harness"

for name in basic record lift closure curry lift-shallow lift-twice lift-nested-create curry-three; do
    "$haruka" "$here/$name.hr" "$tmp/$name.sol"
    awk 'NR == 2 { print; print "org 0x100000000"; next } { print }' \
        "$tmp/$name.sol" > "$tmp/$name-fixed.sol"
    "$mars" "$tmp/$name-fixed.sol" "$runtime" "$tmp/$name.bin"
    "$tmp/harness" "$tmp/$name.bin"
done

for name in invalid-lift-sub invalid-lift-captured invalid-old-constructor; do
    if "$haruka" "$here/$name.hr" "$tmp/$name.sol" >"$tmp/$name.out" 2>"$tmp/$name.err"; then
        echo "expected $name to fail" >&2
        exit 1
    fi
done
