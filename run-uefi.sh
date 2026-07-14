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

if test ! -f "$root/fruityos_uefi.img"; then
    echo "run-uefi.sh: fruityos_uefi.img was not found; run ./build.sh first" >&2
    exit 1
fi

image=$(mktemp "${TMPDIR:-/tmp}/fruityos-uefi-XXXXXX")
trap 'rm -f "$image"' EXIT HUP INT TERM
cp "$root/fruityos_uefi.img" "$image"

qemu-system-x86_64 -m 512 -bios "$ovmf" \
    -drive "format=raw,file=$image,index=0,if=ide" --no-reboot
