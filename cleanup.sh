#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)

"$root/yuzu/cleanup.sh"
"$root/jabara/cleanup.sh"
"$root/peel/cleanup.sh"
"$root/seed/cleanup.sh"
"$root/pulp/cleanup.sh"
rm -rf "$root/initrd.jar" "$root/log.txt" "$root/tmp"
rm -f "$root/bin/fruityos_hdd.img" "$root/bin/fruityos_floppy.img" \
    "$root/bin/fruityos_uefi.img" "$root/bin/fruityos.efi"
