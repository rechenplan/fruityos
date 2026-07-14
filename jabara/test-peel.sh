#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
peel="$fruity/peel"
output="$fruity/bin"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jabara-peel-test-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$output"

for source in "$peel"/src/*/*.jabara; do
    program=$(basename "$(dirname -- "$source")")
    cat "$root/lib/pith.jabara" "$source" > "$tmp/$program.jabara"
    "$root/bin/jc" elf "$tmp/$program.jabara" "$tmp/$program-generated.asm"
    cat "$tmp/$program-generated.asm" "$root/lib/elf-runtime.asm" \
        > "$tmp/$program.asm"
    nasm -f bin "$tmp/$program.asm" -o "$output/$program"
    chmod +x "$output/$program"
done

echo "jabara: Peel programs compiled into $output"
