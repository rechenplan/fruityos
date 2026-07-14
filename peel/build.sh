#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
fruity=$(CDPATH= cd -- "$root/.." && pwd)
jc="$fruity/jabara/bin/jc"
pith="$fruity/jabara/lib/pith.jabara"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/peel-build-XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

rm -rf "$root/bin"
mkdir -p "$root/bin"

echo "[ Building FruityOS userland with Jabara ]"

compile() {
    format=$1
    source=$2
    output=$3
    name=$(basename "$output")
    cat "$pith" "$source" > "$tmp/$name.jabara"
    "$jc" "$format" "$tmp/$name.jabara" "$tmp/$name-generated.asm"
    cat "$tmp/$name-generated.asm" \
        "$fruity/jabara/lib/$format-runtime.asm" > "$tmp/$name.asm"
    nasm -f bin "$tmp/$name.asm" -o "$output"
}

compile elf "$root/src/jar/jar.jabara" "$root/bin/jar.elf"
compile elf "$root/src/juicer/juicer.jabara" "$root/bin/juicer.elf"
chmod +x "$root/bin/jar.elf" "$root/bin/juicer.elf"

for source in "$root"/src/*/*.jabara; do
    program=$(basename "$(dirname -- "$source")")
    compile fap "$source" "$tmp/$program.raw"
    "$root/bin/juicer.elf" c "$tmp/$program.raw" "$root/bin/$program.fap"
done

cat "$pith" "$fruity"/jabara/src/orgasm/*.jabara > "$tmp/orgasm.jabara"
"$jc" fap "$tmp/orgasm.jabara" "$tmp/orgasm-generated.asm"
cat "$tmp/orgasm-generated.asm" "$fruity/jabara/lib/fap-runtime.asm" \
    > "$tmp/orgasm.asm"
nasm -f bin "$tmp/orgasm.asm" -o "$tmp/orgasm.raw"
"$root/bin/juicer.elf" c "$tmp/orgasm.raw" "$root/bin/orgasm.fap"

cat "$pith" "$fruity"/yuzu/src/yc/*.yuzu > "$tmp/yc.jabara"
"$jc" fap "$tmp/yc.jabara" "$tmp/yc-generated.asm"
cat "$tmp/yc-generated.asm" "$fruity/jabara/lib/fap-runtime.asm" \
    > "$tmp/yc.asm"
nasm -f bin "$tmp/yc.asm" -o "$tmp/yc.raw"
"$root/bin/juicer.elf" c "$tmp/yc.raw" "$root/bin/yc.fap"

cat "$pith" "$fruity/yuzu/src/zest/main.yuzu" \
    "$fruity/yuzu/src/zest/lex.yuzu" "$fruity/yuzu/src/zest/parse.yuzu" \
    "$fruity/yuzu/src/zest/emit.yuzu" "$fruity/yuzu/src/zest/elf.yuzu" \
    > "$tmp/zest.jabara"
"$jc" fap "$tmp/zest.jabara" "$tmp/zest-generated.asm"
cat "$tmp/zest-generated.asm" "$fruity/jabara/lib/fap-runtime.asm" \
    > "$tmp/zest.asm"
nasm -f bin "$tmp/zest.asm" -o "$tmp/zest.raw"
"$root/bin/juicer.elf" c "$tmp/zest.raw" "$root/bin/zest.fap"

cat "$fruity"/jabara/src/jc/*.jabara \
    "$fruity/jabara/lib/jc-fap-config.jabara" > "$tmp/jc.jabara"
"$jc" module "$tmp/jc.jabara" "$tmp/jc-module.asm"
cat "$fruity/jabara/lib/fap-module-runtime.asm" \
    "$fruity/jabara/lib/fap-runtime.asm" "$tmp/jc-module.asm" > "$tmp/jc.asm"
nasm -f bin "$tmp/jc.asm" -o "$tmp/jc.raw"
"$root/bin/juicer.elf" c "$tmp/jc.raw" "$root/bin/jc.fap"

echo "peel: Jabara userland build passed"
