#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
jabara="$root/../.."
bootstrap="$jabara/bin/jbc"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jc-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

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
