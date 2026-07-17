#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "usage: test-linux.sh JC ROOT" >&2
    exit 2
fi

jc=$1
root=$2
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
parser=$(CDPATH= cd -- "$here/.." && pwd)
tmp=${TMPDIR:-/tmp}/sol-parser-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"

build() {
    name=$1
    "$jc" "$root/lib/linux-x86_64/pith.jabara" \
        "$parser/model.jabara" "$parser/lexer.jabara" "$parser/parser.jabara" \
        "$here/$name.jabara" "$tmp/$name.asm"
    "$root/bin/orgasm" "$root/lib/linux-x86_64/start.asm" "$tmp/$name.asm" \
        "$root/lib/linux-x86_64/runtime.asm" "$tmp/$name.raw"
    "$root/bin/orgasm" "$root/lib/linux-x86_64/juicer-decode-stub.asm" "$tmp/stub"
    "$root/bin/juicer" c "$tmp/$name.raw" "$tmp/$name.juiced"
    "$root/bin/concat" "$tmp/$name" "$tmp/stub" "$tmp/$name.juiced"
    chmod +x "$tmp/$name"
}

for name in parser errors instructions words stress; do
    build "$name"
    "$tmp/$name"
done
