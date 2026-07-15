#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)

rm -rf "$root/bin"
mkdir -p "$root/bin"
echo "[ Building FruityOS bootloader with NASM ]"

"$root/src/fdseed/build.sh"
"$root/src/hdseed/build.sh"
