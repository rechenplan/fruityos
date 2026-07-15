#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if test "$#" -ne 1; then
    echo "usage: $0 uefi|hdd|fd" >&2
    exit 2
fi

case $1 in
    uefi)
        source_image="$root/bin/fruityos_uefi.img"
        if test -f /usr/share/qemu/OVMF.fd; then
            ovmf=/usr/share/qemu/OVMF.fd
        elif test -f /usr/share/ovmf/OVMF.fd; then
            ovmf=/usr/share/ovmf/OVMF.fd
        else
            echo "run.sh: OVMF.fd was not found" >&2
            exit 1
        fi
        ;;
    hdd)
        source_image="$root/bin/fruityos_hdd.img"
        ;;
    fd)
        source_image="$root/bin/fruityos_floppy.img"
        ;;
    *)
        echo "usage: $0 uefi|hdd|fd" >&2
        exit 2
        ;;
esac

if test ! -f "$source_image"; then
    echo "run.sh: $source_image was not found; run ./build.sh first" >&2
    exit 1
fi

image=$(mktemp "${TMPDIR:-/tmp}/fruityos-$1-XXXXXX")
trap 'rm -f "$image"' EXIT HUP INT TERM
cp "$source_image" "$image"

case $1 in
    uefi)
        qemu-system-x86_64 -m 512 -bios "$ovmf" \
            -drive "format=raw,file=$image,index=0,if=ide" --no-reboot
        ;;
    hdd)
        qemu-system-x86_64 -m 512 \
            -drive "format=raw,file=$image,index=0,if=ide" --no-reboot
        ;;
    fd)
        qemu-system-x86_64 -m 512 \
            -drive "format=raw,file=$image,index=0,if=floppy" \
            -boot a --no-reboot
        ;;
esac
