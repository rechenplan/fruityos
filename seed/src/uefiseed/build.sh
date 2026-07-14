#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
seed=$(CDPATH= cd -- "$root/../.." && pwd)
fruity=$(CDPATH= cd -- "$seed/.." && pwd)

if test "$#" -ne 3; then
    echo "usage: $0 pulp.sys initrd.jar fruityos_uefi.img" >&2
    exit 2
fi

pulp=$1
initrd=$2
image=$3
efi="$fruity/fruityos.efi"

mkdir -p "$seed/bin"
nasm -f bin "-DPULP_SYS=\"$pulp\"" "-DINITRD_JAR=\"$initrd\"" \
    "$root/uefiseed.asm" -o "$efi"

efi_size=$(stat -c %s "$efi")
nasm -f bin -DUEFI_IMAGE "-DEFI_APP=\"$efi\"" "-DEFI_SIZE=$efi_size" \
    "$root/uefiseed.asm" -o "$image"

echo "uefiseed: built $efi and $image with embedded kernel and initrd"
