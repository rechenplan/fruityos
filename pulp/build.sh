#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/pulp-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

rm -rf "$root/bin"
mkdir -p "$root/bin"

echo "[ Building FruityOS kernel with Jabara ]"

cat "$root/src/platform.jabara" "$root"/src/*.jabara > "$tmp/pulp.jabara"
"$fruity/jabara/bin/jc" module "$tmp/pulp.jabara" "$tmp/pulp-generated.asm"
cat "$root/src/entry.asm" "$root/src/idt.asm" "$tmp/pulp-generated.asm" \
    > "$tmp/pulp.asm"
nasm -f bin "$tmp/pulp.asm" -o "$root/bin/pulp.bin"
"$fruity/peel/bin/juicer.elf" c "$root/bin/pulp.bin" "$root/bin/pulp.sys"

echo "pulp: Jabara kernel build passed"
