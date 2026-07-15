#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
jabara="$root/../.."
bootstrap="$jabara/bin/jbc"
tmp=${TMPDIR:-/tmp}/jc-build-$$
(umask 077 && mkdir "$tmp") || exit 1
trap 'rm -rf "$tmp"' 0
trap 'exit 1' 1 2 3 15

mkdir -p "$jabara/bin"
"$bootstrap" "$root"/*.jabara "$tmp/jc-generated.asm"
"$jabara/bin/orgasm" "$jabara/lib/elf-header.asm" \
    "$tmp/jc-generated.asm" "$jabara/lib/elf-runtime.asm" "$jabara/bin/jc"
chmod +x "$jabara/bin/jc"

"$jabara/bin/jc" "$root"/*.jabara "$tmp/jc-self-generated.asm"
"$jabara/bin/orgasm" "$jabara/lib/elf-header.asm" \
    "$tmp/jc-self-generated.asm" "$jabara/lib/elf-runtime.asm" \
    "$jabara/bin/jc-self"
chmod +x "$jabara/bin/jc-self"

echo "jc: bootstrap and self-host build passed"
