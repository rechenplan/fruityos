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
cp "$root"/peel/bin/*.fap "$root/initrd/bin"
cp "$root/jabara/lib/elf-runtime.asm" "$root/jabara/lib/fap-runtime.asm" \
    "$root/initrd/lib"
cp "$root/scripts/init.psh" "$root/initrd/init.psh"

cd "$root/initrd"
"$root/peel/bin/jar.elf" c initrd.jar
mv initrd.jar "$root/initrd.jar"
cd "$root"

"$root/seed/src/uefiseed/build.sh" "$root/pulp/bin/pulp.sys" \
    "$root/initrd.jar" "$root/fruityos_uefi.img"

cat "$root/seed/bin/hdseed.bin" "$root/pulp/bin/pulp.sys" "$root/initrd.jar" \
    > "$root/fruityos_hdd.img"
stat --printf="FruityOS size is %s bytes.\n" "$root/fruityos_hdd.img"
truncate -s 256K "$root/fruityos_hdd.img"
find . -regex '.*\.\(jabara\|yuzu\|asm\|s\|c\)' -print | \
    xargs wc -l > "$root/loc.txt"

rm -f "$root/initrd.jar"

echo "fruityos: Jabara and NASM build passed"
