#!/bin/sh
set -eu

if test "$(id -u)" -ne 0; then
    echo "debian-init.sh: run this script with sudo" >&2
    exit 1
fi

apt-get install nasm gcc qemu-system-x86 ovmf
