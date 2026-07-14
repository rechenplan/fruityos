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
for program in concat copy del echo jar juicer mkdir orgasm pish; do
    cp "$root/peel/bin/$program.fap" "$root/initrd/bin"
done
cp "$root/jabara/lib/elf-runtime.asm" "$root/jabara/lib/fap-runtime.asm" \
    "$root/initrd/lib"
"$root/peel/bin/juicer.elf" c "$root/peel/bin/jc.asm" \
    "$root/initrd/lib/jc.asm.jz"
cp "$root/scripts/init.psh" "$root/initrd/init.psh"

echo "[ Packaging FruityOS source tree ]"
source_tmp=$(mktemp -d "${TMPDIR:-/tmp}/fruityos-source-XXXXXX")
trap 'rm -rf "$source_tmp"' EXIT HUP INT TERM
mkdir -p "$source_tmp/fruityos"
git -C "$root" ls-files --cached --others --exclude-standard -z | \
    tar -C "$root" --null -T - -cf - | \
    tar -C "$source_tmp/fruityos" -xf -
cat "$source_tmp/fruityos/pulp/src/platform.jabara" \
    "$source_tmp/fruityos"/pulp/src/*.jabara > "$source_tmp/pulp.jabara"
"$root/jabara/bin/jc" module "$source_tmp/pulp.jabara" \
    "$source_tmp/fruityos/pulp/pulp-generated.asm"
cp "$root/pulp/bin/pulp.bin" "$source_tmp/fruityos/pulp/pulp.bin"
rm -f "$source_tmp/pulp.jabara"
(
    cd "$source_tmp/fruityos"
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
stat --printf="FruityOS size is %s bytes.\n" "$root/fruityos_hdd.img"
truncate -s 384K "$root/fruityos_hdd.img"
find . -regex '.*\.\(jabara\|yuzu\|asm\|s\|c\)' -print | \
    xargs wc -l > "$root/loc.txt"

rm -f "$root/initrd.jar"
rm -rf "$source_tmp"
trap - EXIT HUP INT TERM

echo "fruityos: Jabara and NASM build passed"
