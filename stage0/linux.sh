#!/bin/sh
set -eu

# Host continuation for Linux x86-64.
# Run from stage0, after build.bat has generated out/orgseed.elf.

if [ ! -f out/orgseed.elf ]; then
    echo "missing out/orgseed.elf; run build.bat under DOS first" >&2
    exit 1
fi

chmod +x out/orgseed.elf

seed=out/orgseed.elf
jbc=out/jbc.elf
orgasm=out/orgasm.elf
module=out/module.asm

compile_tool() {
    target=$1
    suffix=$2
    name=$3
    source=$4

    echo "JBC: $name for $target"
    "$jbc" \
        "../lib/$target/pith.jabara" \
        "$source" \
        "$module"

    echo "Orgasm: $name.$suffix"
    "$orgasm" \
        "../lib/$target/start.asm" \
        "$module" \
        "../lib/$target/runtime.asm" \
        "out/$name.$suffix"
}

compile_orgasm() {
    target=$1
    suffix=$2

    echo "JBC: Orgasm for $target"
    "$jbc" \
        "../lib/$target/pith.jabara" \
        ../jabara/src/orgasm/main.jabara \
        ../jabara/src/orgasm/lex.jabara \
        ../jabara/src/orgasm/modern.jabara \
        ../jabara/src/orgasm/parse.jabara \
        ../jabara/src/orgasm/emit.jabara \
        "$module"

    echo "Orgasm: orgasm.$suffix"
    "$orgasm" \
        "../lib/$target/start.asm" \
        "$module" \
        "../lib/$target/runtime.asm" \
        "out/orgasm.$suffix"
}

echo "Seed Orgasm: assembling stage0/jbc.asm"
"$seed" \
    ../lib/linux-x86_64/start.asm \
    jbc.asm \
    ../lib/linux-x86_64/runtime.asm \
    "$jbc"
chmod +x "$jbc"

echo "JBC: compiling the current Orgasm sources"
"$jbc" \
    ../lib/linux-x86_64/pith.jabara \
    ../jabara/src/orgasm/main.jabara \
    ../jabara/src/orgasm/lex.jabara \
    ../jabara/src/orgasm/modern.jabara \
    ../jabara/src/orgasm/parse.jabara \
    ../jabara/src/orgasm/emit.jabara \
    "$module"

echo "Seed Orgasm: assembling current orgasm.elf"
"$seed" \
    ../lib/linux-x86_64/start.asm \
    "$module" \
    ../lib/linux-x86_64/runtime.asm \
    "$orgasm"
chmod +x "$orgasm"

# Nothing below this point is assembled by the seed.
compile_tool linux-x86_64 elf juicer ../peel/src/juicer/juicer.hr
compile_tool linux-x86_64 elf jews ../peel/src/jews/jews.hr
compile_tool linux-x86_64 elf concat ../peel/src/concat/concat.hr
compile_tool linux-x86_64 elf pish ../peel/src/pish/pish.hr

compile_orgasm windows-x86_64 exe
compile_tool windows-x86_64 exe juicer ../peel/src/juicer/juicer.hr
compile_tool windows-x86_64 exe jews ../peel/src/jews/jews.hr
compile_tool windows-x86_64 exe concat ../peel/src/concat/concat.hr
compile_tool windows-x86_64 exe pish ../peel/src/pish/pish.hr

compile_orgasm fruityos-x86_64 fap
compile_tool fruityos-x86_64 fap juicer ../peel/src/juicer/juicer.hr
compile_tool fruityos-x86_64 fap jews ../peel/src/jews/jews.hr
compile_tool fruityos-x86_64 fap concat ../peel/src/concat/concat.hr
compile_tool fruityos-x86_64 fap pish ../peel/src/pish/pish.hr

rm -f "$module"
chmod +x out/*.elf

echo "Stage 0 complete. All bootstrap binaries are in stage0/out."
