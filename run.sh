#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)

if test "$#" -ne 1; then
    echo "usage: $0 uefi|hdd|fd" >&2
    exit 2
fi

case $1 in
    uefi)
        source_image="$root/bin/fruityos_uefi.img"
        if test -n "${OVMF:-}" && test -f "$OVMF"; then
            ovmf=$OVMF
        elif test -f /usr/share/qemu/OVMF.fd; then
            ovmf=/usr/share/qemu/OVMF.fd
        elif test -f /usr/share/ovmf/OVMF.fd; then
            ovmf=/usr/share/ovmf/OVMF.fd
        elif test -f /usr/local/share/qemu/edk2-x86_64-code.fd; then
            ovmf=/usr/local/share/qemu/edk2-x86_64-code.fd
        elif test -f /opt/homebrew/share/qemu/edk2-x86_64-code.fd; then
            ovmf=/opt/homebrew/share/qemu/edk2-x86_64-code.fd
        else
            echo "run.sh: UEFI firmware was not found; set OVMF to its path" >&2
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

image=${TMPDIR:-/tmp}/fruityos-$1-$$.img
(umask 077 && : > "$image") || exit 1
trap 'rm -f "$image"' 0
trap 'exit 1' 1 2 3 15
cp "$source_image" "$image"

case $1 in
    uefi)
        qemu-system-x86_64 -m 512 -bios "$ovmf" \
            -drive "format=raw,file=$image,if=none,id=fruitydisk" \
            -device "ide-hd,drive=fruitydisk,bootindex=0" -no-reboot
        ;;
    hdd)
        qemu-system-x86_64 -m 512 \
            -drive "format=raw,file=$image,index=0,if=ide" -no-reboot
        ;;
    fd)
        qemu-system-x86_64 -m 512 \
            -drive "format=raw,file=$image,index=0,if=floppy" \
            -boot a -no-reboot
        ;;
esac
