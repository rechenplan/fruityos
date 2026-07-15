#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
jabara=$(CDPATH= cd "$root/../.." && pwd)
tmp=${TMPDIR:-/tmp}/orgasm-test-$$
(umask 077 && mkdir "$tmp") || exit 1
if test -z "${KEEP_TMP:-}"; then
    trap 'rm -rf "$tmp"' 0
else
    echo "orgasm test files: $tmp"
fi
trap 'exit 1' 1 2 3 15

"$jabara/bin/jc" "$jabara/lib/pith.jabara" \
    "$jabara/tests/closure.jabara" "$tmp/closure-generated.asm"
cat "$jabara/lib/fap-stack-runtime.asm" "$jabara/lib/fap-runtime.asm" \
    "$tmp/closure-generated.asm" \
    > "$tmp/closure.asm"
"$jabara/bin/orgasm" "$jabara/lib/fap-stack-runtime.asm" \
    "$jabara/lib/fap-runtime.asm" "$tmp/closure-generated.asm" \
    "$tmp/closure.raw"
nasm -f bin "$tmp/closure.asm" -o "$tmp/closure-nasm.raw"
test -s "$tmp/closure.raw"

"$jabara/bin/jc" "$jabara/lib/pith.jabara" "$root"/*.jabara \
    "$tmp/orgasm-generated.asm"
cat "$jabara/lib/fap-stack-runtime.asm" "$jabara/lib/fap-runtime.asm" \
    "$tmp/orgasm-generated.asm" \
    > "$tmp/orgasm.asm"
"$jabara/bin/orgasm" "$jabara/lib/fap-stack-runtime.asm" \
    "$jabara/lib/fap-runtime.asm" "$tmp/orgasm-generated.asm" \
    "$tmp/orgasm.raw"
nasm -f bin "$tmp/orgasm.asm" -o "$tmp/orgasm-nasm.raw"
test -s "$tmp/orgasm.raw"

cat > "$tmp/descriptor.asm" <<'EOF'
org 0x10000
bits 64
sys:
db 0
tss_start:
TSS equ tss_start - sys + 0x10000
dw TSS & 65535
db (TSS >> 16) & 255
db (TSS >> 24) & 255
dd (TSS >> 32)
dq 0x800000 + (6 << 3)
mov al, 0x20
mov al, dil
out 0x20, al
mov [0x800000 + (6 << 3)], rdi
EOF
"$jabara/bin/orgasm" "$tmp/descriptor.asm" "$tmp/descriptor.raw"
nasm -f bin "$tmp/descriptor.asm" -o "$tmp/descriptor-nasm.raw"
cmp "$tmp/descriptor.raw" "$tmp/descriptor-nasm.raw"

"$jabara/bin/jc" "$jabara/lib/pith.jabara" "$root"/*.jabara \
    "$tmp/orgasm-module.asm"
"$jabara/bin/orgasm" "$jabara/lib/elf-header.asm" \
    "$tmp/orgasm-module.asm" "$jabara/lib/elf-runtime.asm" \
    "$tmp/orgasm-self"
chmod +x "$tmp/orgasm-self"
if "$tmp/orgasm-self" > "$tmp/orgasm-self.out"; then :; fi
grep -q "usage: orgasm" "$tmp/orgasm-self.out"
"$tmp/orgasm-self" "$jabara/lib/fap-stack-runtime.asm" \
    "$jabara/lib/fap-runtime.asm" "$tmp/closure-generated.asm" \
    "$tmp/closure-self.raw"
cmp "$tmp/closure.raw" "$tmp/closure-self.raw"

fruity=$(CDPATH= cd "$jabara/.." && pwd)
"$jabara/bin/jc" "$fruity"/pulp/src/*.jabara "$tmp/pulp-generated.asm"
cat "$fruity/pulp/src/entry.asm" "$fruity/pulp/src/idt.asm" \
    "$jabara/lib/juicer-runtime.asm" "$tmp/pulp-generated.asm" \
    > "$tmp/pulp.asm"
"$jabara/bin/orgasm" "$fruity/pulp/src/entry.asm" \
    "$fruity/pulp/src/idt.asm" "$jabara/lib/juicer-runtime.asm" \
    "$tmp/pulp-generated.asm" "$tmp/pulp.bin"
nasm -f bin "$tmp/pulp.asm" -o "$tmp/pulp-nasm.bin"
test -s "$tmp/pulp.bin"

orgasm_size=$(wc -c < "$tmp/pulp.bin")
nasm_size=$(wc -c < "$tmp/pulp-nasm.bin")
test "$orgasm_size" -le $((nasm_size * 2))

echo "orgasm: Jabara FAP, self-host, and Pulp assembly passed"
