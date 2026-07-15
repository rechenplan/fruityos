#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
fruity=$(CDPATH= cd "$root/.." && pwd)
tmp=${TMPDIR:-/tmp}/pulp-build-$$
(umask 077 && mkdir "$tmp") || exit 1
trap 'rm -rf "$tmp"' 0
trap 'exit 1' 1 2 3 15

rm -rf "$root/bin"
mkdir -p "$root/bin"

echo "[ Building FruityOS kernel with Jabara ]"

"$fruity/jabara/bin/jc" "$root"/src/*.jabara "$tmp/pulp-generated.asm"
"$fruity/jabara/bin/orgasm" "$root/src/entry.asm" "$root/src/idt.asm" \
    "$fruity/jabara/lib/juicer-runtime.asm" "$tmp/pulp-generated.asm" \
    "$root/bin/pulp.bin"
"$fruity/peel/bin/juicer.elf" c "$root/bin/pulp.bin" "$root/bin/pulp.sys"
pulp_size=$(wc -c < "$root/bin/pulp.sys")
if test "$pulp_size" -gt 8192; then
    echo "pulp: pulp.sys exceeds 8 KiB ($pulp_size bytes)" >&2
    exit 1
fi

echo "pulp: Jabara kernel build passed ($pulp_size-byte pulp.sys)"
