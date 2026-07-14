#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/zest-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$root/bin"
cat "$fruity/jabara/lib/pith.jabara" "$root/src/zest/main.yuzu" \
    "$root/src/zest/lex.yuzu" "$root/src/zest/parse.yuzu" \
    "$root/src/zest/emit.yuzu" "$root/src/zest/elf.yuzu" \
    > "$tmp/zest.jabara"
"$fruity/jabara/bin/jc" elf "$tmp/zest.jabara" "$tmp/zest-generated.asm"
cat "$tmp/zest-generated.asm" "$fruity/jabara/lib/elf-runtime.asm" \
    > "$tmp/zest.asm"
nasm -f bin "$tmp/zest.asm" -o "$root/bin/zest"
chmod +x "$root/bin/zest"
