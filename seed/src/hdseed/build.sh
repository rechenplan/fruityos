#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
nasm -f bin -DJUICER_LONG_ONLY -DJUICER_FREESTANDING -I "$root/../../../jabara/lib/" \
    "$root/hdseed.s" -o "$root/../../bin/hdseed.bin"
