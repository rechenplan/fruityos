#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/yc-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$root/bin"
"$fruity/jabara/bin/jc" "$fruity/jabara/lib/pith.jabara" \
    "$root"/src/yc/*.yuzu "$tmp/yc-generated.asm"
"$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/elf-header.asm" \
    "$tmp/yc-generated.asm" "$fruity/jabara/lib/elf-runtime.asm" \
    "$root/bin/yc"
chmod +x "$root/bin/yc"
