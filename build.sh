#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

"$root/jabara/build.sh"
"$root/yuzu/build.sh"
"$root/peel/build.sh"
"$root/seed/build.sh"
"$root/pulp/build.sh"

echo "[ Creating initial RAM filesystem ]"
rm -rf "$root/initrd"
mkdir -p "$root/initrd/bin" "$root/initrd/lib" "$root/initrd/src"
for program in concat del jar juicer orgasm pish; do
    cp "$root/peel/bin/$program.fap" "$root/initrd/bin"
done
cp "$root/jabara/lib/elf-runtime.asm" "$root/jabara/lib/fap-runtime.asm" \
    "$root/initrd/lib"
cp "$root/scripts/init.psh" "$root/initrd/init.psh"

echo "[ Packaging FruityOS source tree ]"
source_tmp=$(mktemp -d "${TMPDIR:-/tmp}/fruityos-source-XXXXXX")
trap 'rm -rf "$source_tmp"' EXIT HUP INT TERM
mkdir -p "$source_tmp/fruityos/peel/bin" "$source_tmp/fruityos/peel/tmp" \
    "$source_tmp/fruityos/pulp/bin" "$source_tmp/fruityos/pulp/tmp" \
    "$source_tmp/fruityos/jabara"
tar -C "$root" -cf - \
    build.psh \
    peel/build.psh peel/src \
    pulp/build.psh pulp/src \
    jabara/lib/pith.jabara jabara/lib/fap-runtime.asm \
    jabara/lib/fap-stack-runtime.asm | \
    tar -C "$source_tmp/fruityos" -xf -
"$root/peel/bin/juicer.elf" c "$root/peel/bin/jc.asm" \
    "$source_tmp/fruityos/jabara/jc.asm.jz"
(
    cd "$source_tmp"
    "$root/peel/bin/jar.elf" c "$source_tmp/fruityos.jar"
)
"$root/peel/bin/juicer.elf" c "$source_tmp/fruityos.jar" \
    "$root/initrd/src/fruityos.jz"

cd "$root/initrd"
"$root/peel/bin/jar.elf" c initrd.jar
mv initrd.jar "$root/initrd.jar"
cd "$root"

"$root/seed/src/uefiseed/build.sh" "$root/pulp/bin/pulp.sys" \
    "$root/initrd.jar" "$root/fruityos_uefi.img"

cat "$root/seed/bin/hdseed.bin" "$root/pulp/bin/pulp.sys" "$root/initrd.jar" \
    > "$root/fruityos_hdd.img"
image_size=$(stat --printf="%s" "$root/fruityos_hdd.img")
echo "FruityOS size is $image_size bytes."
if test "$image_size" -gt 1048576; then
    echo "build.sh: BIOS image exceeds its 1 MiB load window" >&2
    exit 1
fi
truncate -s 1M "$root/fruityos_hdd.img"
find . -regex '.*\.\(jabara\|yuzu\|asm\|s\|c\)' -print | \
    xargs wc -l > "$root/loc.txt"

rm -f "$root/initrd.jar"
rm -rf "$source_tmp"
trap - EXIT HUP INT TERM

echo "fruityos: Jabara and NASM build passed"
