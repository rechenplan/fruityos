#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if test ! -f "$root/fruityos_hdd.img"; then
    echo "run.sh: fruityos_hdd.img was not found; run ./build.sh first" >&2
    exit 1
fi

image=$(mktemp "${TMPDIR:-/tmp}/fruityos-hdd-XXXXXX")
trap 'rm -f "$image"' EXIT HUP INT TERM
cp "$root/fruityos_hdd.img" "$image"

qemu-system-x86_64 -m 512 \
    -drive "format=raw,file=$image,index=0,if=ide" --no-reboot
