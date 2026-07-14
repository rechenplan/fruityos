#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/jabara-test-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

fruity="$root/../yuzu"
pith="$root/lib/pith.jabara"

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

expect_failure "$root/tests/error-missing-main.jabara"
expect_failure "$root/tests/error-sub-value.jabara"
expect_failure "$root/tests/error-undeclared-extern.jabara"
expect_failure "$root/tests/error-var-alias.jabara"
expect_failure "$root/tests/error-lambda-alias.jabara"

"$root/bin/jbc" "$root/tests/compat.yuzu" "$tmp/compat.asm"
"$root/bin/jbc" "$root/tests/closure.jabara" "$tmp/closure.asm"
cat "$fruity/lib/_start.asm" "$tmp/closure.asm" "$fruity/lib/libpith.asm" > "$tmp/closure-linked.asm"
nasm -felf64 "$tmp/closure-linked.asm" -o "$tmp/closure.o"
ld -s "$tmp/closure.o" -o "$tmp/closure"
"$tmp/closure"

"$root/bin/jbc" "$root/tests/record.jabara" "$tmp/record.asm"
cat "$fruity/lib/_start.asm" "$tmp/record.asm" "$fruity/lib/libpith.asm" > "$tmp/record-linked.asm"
nasm -felf64 "$tmp/record-linked.asm" -o "$tmp/record.o"
ld -s "$tmp/record.o" -o "$tmp/record"
"$tmp/record"

cat "$pith" "$root/tests/arguments.yuzu" > "$tmp/arguments.jabara"
"$root/bin/jbc" "$tmp/arguments.jabara" "$tmp/arguments.asm"
cat "$fruity/lib/_start.asm" "$tmp/arguments.asm" "$fruity/lib/libpith.asm" > "$tmp/arguments-linked.asm"
nasm -felf64 "$tmp/arguments-linked.asm" -o "$tmp/arguments.o"
ld -s "$tmp/arguments.o" -o "$tmp/arguments"
set +e
"$tmp/arguments" "$root/tests/compat.yuzu" "$tmp/arguments.out"
argument_status=$?
set -e
test "$argument_status" -eq 3
test -f "$tmp/arguments.out"

cat "$pith" "$fruity"/src/yc/*.yuzu > "$tmp/yc.yuzu"
"$root/bin/jbc" "$tmp/yc.yuzu" "$tmp/yc.asm"
cat "$fruity/lib/_start.asm" "$tmp/yc.asm" "$fruity/lib/libpith.asm" > "$tmp/yc-linked.asm"
nasm -felf64 "$tmp/yc-linked.asm" -o "$tmp/yc.o"
ld -s "$tmp/yc.o" -o "$tmp/yc"
"$tmp/yc" "$root/tests/compat.yuzu" "$tmp/selfhost.asm"
cat "$fruity/lib/_start.asm" "$tmp/selfhost.asm" "$fruity/lib/libpith.asm" > "$tmp/selfhost-linked.asm"
nasm -felf64 "$tmp/selfhost-linked.asm" -o "$tmp/selfhost.o"
ld -s "$tmp/selfhost.o" -o "$tmp/selfhost"
set +e
"$tmp/selfhost"
selfhost_status=$?
set -e
test "$selfhost_status" -eq 10

cat "$fruity/src/zest/main.yuzu" "$fruity/src/zest/lex.yuzu" \
    "$fruity/src/zest/parse.yuzu" "$fruity/src/zest/emit.yuzu" \
    "$fruity/src/zest/elf.yuzu" > "$tmp/zest.yuzu"
cat "$pith" "$tmp/zest.yuzu" > "$tmp/zest-with-pith.jabara"
"$root/bin/jbc" "$tmp/zest-with-pith.jabara" "$tmp/zest.asm"
cat "$fruity/lib/_start.asm" "$tmp/zest.asm" "$fruity/lib/libpith.asm" > "$tmp/zest-linked.asm"
nasm -felf64 "$tmp/zest-linked.asm" -o "$tmp/zest.o"
ld -s "$tmp/zest.o" -o "$tmp/zest"

for test in closure record; do
    "$root/bin/jc" "$root/tests/$test.jabara" "$tmp/jc-$test.asm"
    cat "$fruity/lib/_start.asm" "$tmp/jc-$test.asm" "$fruity/lib/libpith.asm" \
        > "$tmp/jc-$test-linked.asm"
    nasm -felf64 "$tmp/jc-$test-linked.asm" -o "$tmp/jc-$test.o"
    ld -s "$tmp/jc-$test.o" -o "$tmp/jc-$test"
    "$tmp/jc-$test"
done

"$root/bin/jc-self" "$root/tests/record.jabara" "$tmp/jc-self-record.asm"
nasm -felf64 "$tmp/jc-self-record.asm" -o "$tmp/jc-self-record.o"

expect_jc_failure "$root/tests/error-missing-main.jabara"
expect_jc_failure "$root/tests/error-sub-value.jabara"
expect_jc_failure "$root/tests/error-undeclared-extern.jabara"
expect_jc_failure "$root/tests/error-var-alias.jabara"
expect_jc_failure "$root/tests/error-lambda-alias.jabara"

"$root/bin/jc" "$tmp/yc.yuzu" "$tmp/jc-yc.asm"
cat "$fruity/lib/_start.asm" "$tmp/jc-yc.asm" "$fruity/lib/libpith.asm" \
    > "$tmp/jc-yc-linked.asm"
nasm -felf64 "$tmp/jc-yc-linked.asm" -o "$tmp/jc-yc.o"
ld "$tmp/jc-yc.o" -o "$tmp/jc-yc"
"$tmp/jc-yc" "$root/tests/compat.yuzu" "$tmp/jc-compat.asm"
cat "$fruity/lib/_start.asm" "$tmp/jc-compat.asm" "$fruity/lib/libpith.asm" \
    > "$tmp/jc-compat-linked.asm"
nasm -felf64 "$tmp/jc-compat-linked.asm" -o "$tmp/jc-compat.o"
ld "$tmp/jc-compat.o" -o "$tmp/jc-compat"
set +e
"$tmp/jc-compat"
jc_compat_status=$?
set -e
test "$jc_compat_status" -eq 10

echo "jabara: all tests passed"
