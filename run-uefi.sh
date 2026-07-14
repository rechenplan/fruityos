#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if test -f /usr/share/qemu/OVMF.fd; then
    ovmf=/usr/share/qemu/OVMF.fd
elif test -f /usr/share/ovmf/OVMF.fd; then
    ovmf=/usr/share/ovmf/OVMF.fd
else
    echo "run-uefi.sh: OVMF.fd was not found" >&2
    exit 1
fi

exec qemu-system-x86_64 -m 512 -bios "$ovmf" \
    -drive "format=raw,file=$root/fruityos_uefi.img,index=0,if=ide" --no-reboot
