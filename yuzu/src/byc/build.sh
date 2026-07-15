#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")/../.." && pwd)
fruity=$(CDPATH= cd "$root/.." && pwd)
tmp=${TMPDIR:-/tmp}/byc-build-$$
(umask 077 && mkdir "$tmp") || exit 1
trap 'rm -rf "$tmp"' 0
trap 'exit 1' 1 2 3 15

mkdir -p "$root/bin"
"$fruity/jabara/bin/jc" "$fruity/jabara/lib/pith.jabara" \
    "$root"/src/yc/*.yuzu "$tmp/byc-generated.asm"
"$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/elf-header.asm" \
    "$tmp/byc-generated.asm" "$fruity/jabara/lib/elf-runtime.asm" \
    "$root/bin/byc"
chmod +x "$root/bin/byc"
