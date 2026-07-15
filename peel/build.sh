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
    target=$1
    source=$2
    output=$3
    name=$(basename "$output")
    "$jc" "$pith" "$source" "$tmp/$name-generated.asm"
    if test "$target" = elf; then
        "$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/elf-header.asm" \
            "$tmp/$name-generated.asm" "$fruity/jabara/lib/elf-runtime.asm" \
            "$output"
    else
        "$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/fap-stack-runtime.asm" \
            "$fruity/jabara/lib/fap-runtime.asm" \
            "$tmp/$name-generated.asm" "$output"
    fi
}

compile elf "$root/src/jar/jar.jabara" "$root/bin/jar.elf"
compile elf "$root/src/juicer/juicer.jabara" "$root/bin/juicer.elf"
chmod +x "$root/bin/jar.elf" "$root/bin/juicer.elf"

for source in "$root"/src/*/*.jabara; do
    program=$(basename "$(dirname -- "$source")")
    compile fap "$source" "$tmp/$program.raw"
    "$root/bin/juicer.elf" c "$tmp/$program.raw" "$root/bin/$program.fap"
done

"$jc" "$pith" "$fruity"/jabara/src/orgasm/*.jabara \
    "$tmp/orgasm-generated.asm"
"$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/fap-stack-runtime.asm" \
    "$fruity/jabara/lib/fap-runtime.asm" "$tmp/orgasm-generated.asm" \
    "$tmp/orgasm.raw"
"$root/bin/juicer.elf" c "$tmp/orgasm.raw" "$root/bin/orgasm.fap"

"$jc" "$pith" "$fruity"/yuzu/src/yc/*.yuzu "$tmp/yc-generated.asm"
"$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/fap-stack-runtime.asm" \
    "$fruity/jabara/lib/fap-runtime.asm" "$tmp/yc-generated.asm" "$tmp/yc.raw"
"$root/bin/juicer.elf" c "$tmp/yc.raw" "$root/bin/yc.fap"

"$jc" "$pith" "$fruity/yuzu/src/zest/main.yuzu" \
    "$fruity/yuzu/src/zest/lex.yuzu" "$fruity/yuzu/src/zest/parse.yuzu" \
    "$fruity/yuzu/src/zest/emit.yuzu" "$fruity/yuzu/src/zest/elf.yuzu" \
    "$tmp/zest-generated.asm"
"$fruity/jabara/bin/orgasm" "$fruity/jabara/lib/fap-stack-runtime.asm" \
    "$fruity/jabara/lib/fap-runtime.asm" "$tmp/zest-generated.asm" \
    "$tmp/zest.raw"
"$root/bin/juicer.elf" c "$tmp/zest.raw" "$root/bin/zest.fap"

"$jc" "$fruity"/jabara/src/jc/*.jabara \
    "$fruity/jabara/lib/jc-fap-config.jabara" "$tmp/jc-module.asm"
cat "$fruity/jabara/lib/fap-module-runtime.asm" \
    "$fruity/jabara/lib/fap-runtime.asm" "$tmp/jc-module.asm" \
    > "$root/bin/jc.asm"

echo "peel: Jabara userland build passed"
