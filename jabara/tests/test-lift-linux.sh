#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "usage: test-lift-linux.sh JC ROOT" >&2
    exit 2
fi

jc=$1
root=$2
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=${TMPDIR:-/tmp}/jabara-lift-test-$$
trap 'rm -rf "$tmp"' EXIT INT TERM
mkdir -p "$tmp"

build() {
    name=$1
    "$jc" "$root/lib/linux-x86_64/pith.jabara" "$here/$name.jabara" "$tmp/$name.asm"
    "$root/bin/orgasm" "$root/lib/linux-x86_64/start.asm" "$tmp/$name.asm" \
        "$root/lib/linux-x86_64/runtime.asm" "$tmp/$name.raw"
    "$root/bin/orgasm" "$root/lib/linux-x86_64/juicer-decode-stub.asm" "$tmp/stub"
    "$root/bin/juicer" c "$tmp/$name.raw" "$tmp/$name.juiced"
    "$root/bin/concat" "$tmp/$name" "$tmp/stub" "$tmp/$name.juiced"
    chmod +x "$tmp/$name"
}

for name in lift lift-shallow lift-twice lift-nested-create curry-three closure record stack-region; do
    build "$name"
    "$tmp/$name"
done

for name in invalid-lift-sub invalid-lift-captured invalid-old-constructor; do
    if "$jc" "$root/lib/linux-x86_64/pith.jabara" "$here/$name.jabara" \
        "$tmp/$name.asm" >"$tmp/$name.out" 2>"$tmp/$name.err"; then
        echo "expected $name to fail" >&2
        exit 1
    fi
done
