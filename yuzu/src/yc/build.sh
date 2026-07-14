#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/yc-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$root/bin"
cat "$fruity/jabara/lib/pith.jabara" "$root"/src/yc/*.yuzu > "$tmp/yc.jabara"
"$fruity/jabara/bin/jc" elf "$tmp/yc.jabara" "$tmp/yc-generated.asm"
cat "$tmp/yc-generated.asm" "$fruity/jabara/lib/elf-runtime.asm" \
    > "$tmp/yc.asm"
nasm -f bin "$tmp/yc.asm" -o "$root/bin/yc"
chmod +x "$root/bin/yc"
