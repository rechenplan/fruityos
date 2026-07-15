#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
mkdir -p "$root/bin"

"$root/jabara/build.sh"
"$root/yuzu/build.sh"
"$root/peel/build.sh"
"$root/seed/build.sh"
"$root/pulp/build.sh"

echo "[ Creating initial RAM filesystem ]"
rm -rf "$root/initrd"
mkdir -p "$root/initrd/bin" "$root/initrd/src"
cp "$root/pulp/bin/pulp.sys" "$root/initrd/pulp.sys"
for program in jar juicer orgasm pish; do
    cp "$root/peel/bin/$program.fap" "$root/initrd/bin"
done
cp "$root/scripts/init.psh" "$root/initrd/init.psh"

echo "[ Packaging FruityOS source tree ]"
source_tmp=${TMPDIR:-/tmp}/fruityos-source-$$
source_jar=$source_tmp.jar
(umask 077 && mkdir "$source_tmp") || exit 1
trap 'rm -rf "$source_tmp"; rm -f "$source_jar"' 0
trap 'exit 1' 1 2 3 15
mkdir -p "$source_tmp/fruityos/peel/bin" "$source_tmp/fruityos/peel/tmp" \
    "$source_tmp/fruityos/pulp/bin" "$source_tmp/fruityos/pulp/tmp" \
    "$source_tmp/fruityos/jabara/tmp"
cp "$root/scripts/build.psh" "$source_tmp/fruityos/build.psh"
cp "$root/scripts/peel-build.psh" "$source_tmp/fruityos/peel/build.psh"
cp "$root/scripts/pulp-build.psh" "$source_tmp/fruityos/pulp/build.psh"
cp "$root/scripts/jabara-build.psh" "$source_tmp/fruityos/jabara/build.psh"
tar -C "$root" -cf - \
    peel/src \
    pulp/src \
    jabara/src/jc/emitter.jabara jabara/src/jc/lexer.jabara \
    jabara/src/jc/main.jabara jabara/src/jc/model.jabara \
    jabara/src/jc/parser.jabara jabara/src/jc/runtime.jabara \
    jabara/src/orgasm/emit.jabara \
    jabara/src/orgasm/lex.jabara jabara/src/orgasm/main.jabara \
    jabara/src/orgasm/modern.jabara jabara/src/orgasm/parse.jabara \
    jabara/lib/jc-fap-config.jabara jabara/lib/pith.jabara \
    jabara/lib/fap-module-runtime.asm jabara/lib/fap-runtime.asm \
    jabara/lib/fap-stack-runtime.asm | \
    tar -C "$source_tmp/fruityos" -xf -
"$root/peel/bin/juicer.elf" c "$root/peel/bin/jc.asm" \
    "$source_tmp/fruityos/jabara/jc.asm.jz"
(
    cd "$source_tmp"
    "$root/peel/bin/jar.elf" c "$source_jar"
)
"$root/peel/bin/juicer.elf" c "$source_jar" \
    "$root/initrd/src/fruityos.jz"

cd "$root/initrd"
"$root/peel/bin/jar.elf" c initrd.jar
mv initrd.jar "$root/initrd.jar"
cd "$root"

"$root/seed/src/uefiseed/build.sh" "$root/initrd.jar" \
    "$root/bin/fruityos_uefi.img"

cat "$root/seed/bin/hdseed.bin" "$root/initrd.jar" \
    > "$root/bin/fruityos_hdd.img"
image_size=$(wc -c < "$root/bin/fruityos_hdd.img")
echo "FruityOS size is $image_size bytes."
if test "$image_size" -gt 1048576; then
    echo "build.sh: BIOS image exceeds its 1 MiB load window" >&2
    exit 1
fi
padding=$((1048576 - image_size))
if test "$padding" -gt 0; then
    blocks=$((padding / 1024))
    remainder=$((padding % 1024))
    if test "$blocks" -gt 0; then
        dd if=/dev/zero bs=1024 count="$blocks" \
            >> "$root/bin/fruityos_hdd.img" 2>/dev/null
    fi
    if test "$remainder" -gt 0; then
        dd if=/dev/zero bs=1 count="$remainder" \
            >> "$root/bin/fruityos_hdd.img" 2>/dev/null
    fi
fi

cat "$root/seed/bin/fdseed.bin" "$root/initrd.jar" \
    > "$root/bin/fruityos_floppy.img"
floppy_size=$(wc -c < "$root/bin/fruityos_floppy.img")
if test "$floppy_size" -gt 350208; then
    echo "build.sh: floppy image exceeds its 342 KiB load window" >&2
    exit 1
fi
padding=$((1474560 - floppy_size))
if test "$padding" -gt 0; then
    blocks=$((padding / 1024))
    remainder=$((padding % 1024))
    if test "$blocks" -gt 0; then
        dd if=/dev/zero bs=1024 count="$blocks" \
            >> "$root/bin/fruityos_floppy.img" 2>/dev/null
    fi
    if test "$remainder" -gt 0; then
        dd if=/dev/zero bs=1 count="$remainder" \
            >> "$root/bin/fruityos_floppy.img" 2>/dev/null
    fi
fi
find . -type f \( -name '*.jabara' -o -name '*.yuzu' -o \
    -name '*.asm' -o -name '*.s' -o -name '*.c' \) \
    -exec wc -l {} + > "$root/loc.txt"

rm -f "$root/initrd.jar"
rm -f "$source_jar"
rm -rf "$source_tmp"
trap - 0 1 2 3 15

echo "fruityos: Jabara and NASM build passed"
