#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
nasm -f bin "$root/fdseed.s" -o "$root/../../bin/fdseed.bin"
