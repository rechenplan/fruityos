#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")/../.." && pwd)
fruity=$(CDPATH= cd "$root/.." && pwd)
tmp=${TMPDIR:-/tmp}/yc-build-$$
(umask 077 && mkdir "$tmp") || exit 1
trap 'rm -rf "$tmp"' 0
trap 'exit 1' 1 2 3 15

mkdir -p "$root/bin"
"$fruity/jabara/bin/jc" "$fruity/jabara/lib/pith.jabara" \
    "$root"/src/yc/*.yuzu "$tmp/yc-generated.asm"
"$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/elf-header.asm" \
    "$tmp/yc-generated.asm" "$fruity/jabara/lib/elf-runtime.asm" \
    "$root/bin/yc"
chmod +x "$root/bin/yc"
