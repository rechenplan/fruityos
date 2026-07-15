#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
fruity=$(CDPATH= cd "$root/.." && pwd)
peel="$fruity/peel"
output="$fruity/bin"
tmp=${TMPDIR:-/tmp}/jabara-peel-test-$$
(umask 077 && mkdir "$tmp") || exit 1
trap 'rm -rf "$tmp"' 0
trap 'exit 1' 1 2 3 15

mkdir -p "$output"

for source in "$peel"/src/*/*.jabara; do
    program=$(basename "$(dirname "$source")")
    cat "$root/lib/pith.jabara" "$source" > "$tmp/$program.jabara"
    "$root/bin/jc" "$tmp/$program.jabara" "$tmp/$program-generated.asm"
    if test "$program" = juicer; then
        cat "$root/lib/elf-header.asm" "$tmp/$program-generated.asm" \
            "$root/lib/juicer-runtime.asm" "$root/lib/elf-runtime.asm" \
            > "$tmp/$program.asm"
    else
        cat "$root/lib/elf-header.asm" "$tmp/$program-generated.asm" \
            "$root/lib/elf-runtime.asm" > "$tmp/$program.asm"
    fi
    nasm -f bin "$tmp/$program.asm" -o "$output/$program"
    chmod +x "$output/$program"
done

echo "jabara: Peel programs compiled into $output"
