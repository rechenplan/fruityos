#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jabara-test-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

fruity="$root/../yuzu"
juicer="$root/../peel/bin/juicer.elf"
pith="$root/lib/pith.jabara"
elf_runtime="$root/lib/elf-runtime.asm"
fap_runtime="$root/lib/fap-runtime.asm"

expect_failure() {
    if "$root/bin/jbc" "$1" "$tmp/error.asm" >/dev/null 2>&1; then
        echo "jabara: expected compilation to fail: $1" >&2
        exit 1
    fi
}

expect_jc_failure() {
    if "$root/bin/jc" "$1" "$tmp/jc-error.asm" >/dev/null 2>&1; then
        echo "jc: expected compilation to fail: $1" >&2
        exit 1
    fi
}

assemble_elf() {
    cat "$root/lib/elf-header.asm" "$1" "$elf_runtime" > "$1-linked.asm"
    nasm -f bin "$1-linked.asm" -o "$2"
    chmod +x "$2"
}

for test in error-sub-value error-undeclared-extern; do
    expect_failure "$root/tests/$test.jabara"
done

for test in closure record; do
    "$root/bin/jbc" "$root/tests/$test.jabara" "$tmp/$test.asm"
    assemble_elf "$tmp/$test.asm" "$tmp/$test"
    "$tmp/$test"
done

cat "$pith" "$root/tests/arguments.jabara" > "$tmp/arguments.jabara"
"$root/bin/jbc" "$tmp/arguments.jabara" "$tmp/arguments.asm"
assemble_elf "$tmp/arguments.asm" "$tmp/arguments"
set +e
"$tmp/arguments" "$root/tests/compat.jabara" "$tmp/arguments.out"
argument_status=$?
set -e
test "$argument_status" -eq 3
test -f "$tmp/arguments.out"

cat "$pith" "$fruity"/src/yc/*.yuzu > "$tmp/yc.jabara"
"$root/bin/jbc" "$tmp/yc.jabara" "$tmp/yc-flat.asm"
assemble_elf "$tmp/yc-flat.asm" "$tmp/yc"
"$tmp/yc" "$root/tests/compat.jabara" "$tmp/selfhost.asm"
cat "$fruity/lib/_start.asm" "$tmp/selfhost.asm" "$fruity/lib/libpith.asm" \
    > "$tmp/selfhost-linked.asm"
nasm -felf64 "$tmp/selfhost-linked.asm" -o "$tmp/selfhost.o"
ld -s "$tmp/selfhost.o" -o "$tmp/selfhost"
set +e
"$tmp/selfhost"
selfhost_status=$?
set -e
test "$selfhost_status" -eq 10

cat "$fruity/src/zest/main.yuzu" "$fruity/src/zest/lex.yuzu" \
    "$fruity/src/zest/parse.yuzu" "$fruity/src/zest/emit.yuzu" \
    "$fruity/src/zest/elf.yuzu" > "$tmp/zest.jabara"
cat "$pith" "$tmp/zest.jabara" > "$tmp/zest-with-pith.jabara"
"$root/bin/jbc" "$tmp/zest-with-pith.jabara" "$tmp/zest.asm"
assemble_elf "$tmp/zest.asm" "$tmp/zest"

for test in closure record; do
    "$root/bin/jc" "$root/tests/$test.jabara" "$tmp/jc-$test.asm"
    assemble_elf "$tmp/jc-$test.asm" "$tmp/jc-$test"
    "$tmp/jc-$test"
done

"$root/bin/jc-self" "$root/tests/record.jabara" "$tmp/jc-self-record.asm"
assemble_elf "$tmp/jc-self-record.asm" "$tmp/jc-self-record"
"$tmp/jc-self-record"

for test in error-sub-value error-undeclared-extern; do
    expect_jc_failure "$root/tests/$test.jabara"
done

"$root/bin/jc" "$tmp/yc.jabara" "$tmp/jc-yc-flat.asm"
assemble_elf "$tmp/jc-yc-flat.asm" "$tmp/jc-yc"
"$tmp/jc-yc" "$root/tests/compat.jabara" "$tmp/jc-compat.asm"
cat "$fruity/lib/_start.asm" "$tmp/jc-compat.asm" "$fruity/lib/libpith.asm" \
    > "$tmp/jc-compat-linked.asm"
nasm -felf64 "$tmp/jc-compat-linked.asm" -o "$tmp/jc-compat.o"
ld "$tmp/jc-compat.o" -o "$tmp/jc-compat"
set +e
"$tmp/jc-compat"
jc_compat_status=$?
set -e
test "$jc_compat_status" -eq 10

"$root/bin/jbc" "$root/tests/record.jabara" "$tmp/record-jbc.asm"
"$root/bin/jc" "$root/tests/record.jabara" "$tmp/record-jc.asm"
if grep -q '^org ' "$tmp/record-jbc.asm" "$tmp/record-jc.asm"; then
    echo "jabara: compiler output unexpectedly selects an origin" >&2
    exit 1
fi
cat "$root/lib/fap-stack-runtime.asm" "$fap_runtime" \
    "$tmp/record-jbc.asm" > "$tmp/record-jbc-linked.asm"
cat "$root/lib/fap-stack-runtime.asm" "$fap_runtime" \
    "$tmp/record-jc.asm" > "$tmp/record-jc-linked.asm"
nasm -f bin "$tmp/record-jbc-linked.asm" -o "$tmp/record-jbc.raw"
nasm -f bin "$tmp/record-jc-linked.asm" -o "$tmp/record-jc.raw"
if test -x "$juicer"; then
    "$juicer" c "$tmp/record-jbc.raw" "$tmp/record.fap"
    "$juicer" d "$tmp/record.fap" "$tmp/record-roundtrip.raw"
    cmp "$tmp/record-jbc.raw" "$tmp/record-roundtrip.raw"
    "$juicer" c "$tmp/record-jc.raw" "$tmp/jc-record.fap"
    "$juicer" d "$tmp/jc-record.fap" "$tmp/jc-record-roundtrip.raw"
    cmp "$tmp/record-jc.raw" "$tmp/jc-record-roundtrip.raw"
    first_byte=$(od -An -N1 -t u1 "$tmp/record-jbc.raw")
    test "$first_byte" -eq 235
fi

"$root/test-peel.sh"

echo "jabara: all tests passed"
