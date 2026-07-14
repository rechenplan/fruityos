#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
jabara=$(CDPATH= cd -- "$root/../.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/orgasm-test-XXXXXX")
if test -z "${KEEP_TMP:-}"; then
    trap 'rm -rf "$tmp"' EXIT HUP INT TERM
else
    echo "orgasm test files: $tmp"
fi

cat "$jabara/lib/pith.jabara" "$jabara/tests/closure.jabara" \
    > "$tmp/closure.jabara"
"$jabara/bin/jc" fap "$tmp/closure.jabara" "$tmp/closure-generated.asm"
cat "$tmp/closure-generated.asm" "$jabara/lib/fap-runtime.asm" \
    > "$tmp/closure.asm"
"$jabara/bin/orgasm" f "$tmp/closure.asm" "$tmp/closure.raw"
nasm -f bin "$tmp/closure.asm" -o "$tmp/closure-nasm.raw"
test -s "$tmp/closure.raw"

cat "$jabara/lib/pith.jabara" "$root"/*.jabara > "$tmp/orgasm.jabara"
"$jabara/bin/jc" fap "$tmp/orgasm.jabara" "$tmp/orgasm-generated.asm"
cat "$tmp/orgasm-generated.asm" "$jabara/lib/fap-runtime.asm" \
    > "$tmp/orgasm.asm"
"$jabara/bin/orgasm" f "$tmp/orgasm.asm" "$tmp/orgasm.raw"
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
"$jabara/bin/orgasm" f "$tmp/descriptor.asm" "$tmp/descriptor.raw"
nasm -f bin "$tmp/descriptor.asm" -o "$tmp/descriptor-nasm.raw"
cmp "$tmp/descriptor.raw" "$tmp/descriptor-nasm.raw"

"$jabara/bin/jc" module "$tmp/orgasm.jabara" "$tmp/orgasm-module.asm"
cat "$jabara/../peel/lib/_start.asm" "$tmp/orgasm-module.asm" \
    "$jabara/../yuzu/lib/libpith.asm" > "$tmp/orgasm-self.asm"
"$jabara/bin/orgasm" e "$tmp/orgasm-self.asm" "$tmp/orgasm-self"
chmod +x "$tmp/orgasm-self"
if "$tmp/orgasm-self" > "$tmp/orgasm-self.out"; then :; fi
grep -q "usage: orgasm" "$tmp/orgasm-self.out"

fruity=$(CDPATH= cd -- "$jabara/.." && pwd)
cat "$fruity/pulp/src/platform.jabara" "$fruity"/pulp/src/*.jabara \
    > "$tmp/pulp.jabara"
"$jabara/bin/jc" module "$tmp/pulp.jabara" "$tmp/pulp-generated.asm"
cat "$fruity/pulp/src/entry.asm" "$fruity/pulp/src/idt.asm" \
    "$tmp/pulp-generated.asm" > "$tmp/pulp.asm"
"$jabara/bin/orgasm" f "$tmp/pulp.asm" "$tmp/pulp.bin"
nasm -f bin "$tmp/pulp.asm" -o "$tmp/pulp-nasm.bin"
test -s "$tmp/pulp.bin"

orgasm_size=$(stat -c %s "$tmp/pulp.bin")
nasm_size=$(stat -c %s "$tmp/pulp-nasm.bin")
test "$orgasm_size" -ge "$nasm_size"
test "$orgasm_size" -le $((nasm_size * 2))

echo "orgasm: Jabara FAP, self-host, and Pulp assembly passed"
