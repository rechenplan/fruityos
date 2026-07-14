#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
jabara="$root/../.."
bootstrap="$jabara/bin/jbc"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jc-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$jabara/bin"
cat "$root"/*.jabara > "$tmp/jc.jabara"
"$bootstrap" elf "$tmp/jc.jabara" "$tmp/jc.asm"
nasm -f bin "$tmp/jc.asm" -o "$jabara/bin/jc"
chmod +x "$jabara/bin/jc"

"$jabara/bin/jc" elf "$tmp/jc.jabara" "$tmp/jc-self.asm"
nasm -f bin "$tmp/jc-self.asm" -o "$jabara/bin/jc-self"
chmod +x "$jabara/bin/jc-self"

echo "jc: bootstrap and self-host build passed"
