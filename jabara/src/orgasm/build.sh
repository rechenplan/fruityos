#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
jabara=$(CDPATH= cd -- "$root/../.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/orgasm-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$jabara/bin"
cat "$jabara/lib/pith.jabara" "$root/main.jabara" "$root/lex.jabara" \
    "$root/modern.jabara" "$root/parse.jabara" "$root/emit.jabara" "$root/elf.jabara" \
    > "$tmp/orgasm.jabara"
"$jabara/bin/jc" elf "$tmp/orgasm.jabara" "$tmp/orgasm-generated.asm"
cat "$tmp/orgasm-generated.asm" "$jabara/lib/elf-runtime.asm" \
    > "$tmp/orgasm.asm"
nasm -f bin "$tmp/orgasm.asm" -o "$jabara/bin/orgasm"
chmod +x "$jabara/bin/orgasm"
