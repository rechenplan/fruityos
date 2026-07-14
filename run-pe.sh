#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if test -f /usr/share/qemu/OVMF.fd; then
    ovmf=/usr/share/qemu/OVMF.fd
elif test -f /usr/share/ovmf/OVMF.fd; then
    ovmf=/usr/share/ovmf/OVMF.fd
else
    echo "run-pe.sh: OVMF.fd was not found" >&2
    exit 1
fi

if test ! -f "$root/fruityos.efi"; then
    echo "run-pe.sh: fruityos.efi was not found; run ./build.sh first" >&2
    exit 1
fi

esp=$(mktemp -d "${TMPDIR:-/tmp}/fruityos-pe-XXXXXX")
trap 'rm -rf "$esp"' EXIT HUP INT TERM
mkdir -p "$esp/EFI/BOOT"
cp "$root/fruityos.efi" "$esp/EFI/BOOT/BOOTX64.EFI"

env -u GDK_PIXBUF_MODULEDIR -u GDK_PIXBUF_MODULE_FILE -u GIO_MODULE_DIR \
    -u GTK_EXE_PREFIX -u GTK_IM_MODULE_FILE -u GTK_MODULES -u GTK_PATH \
    -u LOCPATH -u SNAP_LIBRARY_PATH \
    XDG_DATA_DIRS=/usr/local/share:/usr/share \
    qemu-system-x86_64 -m 512 -bios "$ovmf" \
    -drive "format=raw,file=fat:rw:$esp,index=0,if=ide" --no-reboot
