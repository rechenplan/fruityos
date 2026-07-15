#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
jabara=$(CDPATH= cd "$root/../.." && pwd)
tmp=${TMPDIR:-/tmp}/orgasm-build-$$
(umask 077 && mkdir "$tmp") || exit 1
trap 'rm -rf "$tmp"' 0
trap 'exit 1' 1 2 3 15

mkdir -p "$jabara/bin"
"$jabara/bin/jbc" "$jabara/lib/pith.jabara" "$root/main.jabara" \
    "$root/lex.jabara" "$root/modern.jabara" "$root/parse.jabara" \
    "$root/emit.jabara" "$tmp/orgasm-generated.asm"
cat "$jabara/lib/elf-header.asm" "$tmp/orgasm-generated.asm" \
    "$jabara/lib/elf-runtime.asm" \
    > "$tmp/orgasm.asm"
nasm -f bin "$tmp/orgasm.asm" -o "$jabara/bin/orgasm"
chmod +x "$jabara/bin/orgasm"
