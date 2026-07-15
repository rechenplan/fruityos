#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/pulp-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

rm -rf "$root/bin"
mkdir -p "$root/bin"

echo "[ Building FruityOS kernel with Jabara ]"

"$fruity/jabara/bin/jc" "$root"/src/*.jabara "$tmp/pulp-generated.asm"
"$fruity/jabara/bin/orgasm" "$root/src/entry.asm" "$root/src/idt.asm" \
    "$tmp/pulp-generated.asm" "$root/bin/pulp.bin"
"$fruity/peel/bin/juicer.elf" c "$root/bin/pulp.bin" "$root/bin/pulp.sys"

echo "pulp: Jabara kernel build passed"
