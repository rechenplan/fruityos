#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
jabara="$root/../.."
fruity="$root/../../../yuzu"
bootstrap="$jabara/bin/jbc"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jc-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$jabara/bin"
cat "$root"/*.jabara > "$tmp/jc.jabara"
"$bootstrap" "$tmp/jc.jabara" "$tmp/jc.asm"
cat "$fruity/lib/_start.asm" "$tmp/jc.asm" "$fruity/lib/libpith.asm" > "$tmp/jc-linked.asm"
nasm -felf64 "$tmp/jc-linked.asm" -o "$tmp/jc.o"
ld "$tmp/jc.o" -o "$jabara/bin/jc"

"$jabara/bin/jc" "$tmp/jc.jabara" "$tmp/jc-self.asm"
cat "$fruity/lib/_start.asm" "$tmp/jc-self.asm" "$fruity/lib/libpith.asm" > "$tmp/jc-self-linked.asm"
nasm -felf64 "$tmp/jc-self-linked.asm" -o "$tmp/jc-self.o"
ld "$tmp/jc-self.o" -o "$jabara/bin/jc-self"

echo "jc: bootstrap and self-host build passed"
