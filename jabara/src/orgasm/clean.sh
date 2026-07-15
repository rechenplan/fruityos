#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
rm -f "$root/../../bin/orgasm" "$root"/*.o "$root"/*.asm \
    "$root/_.jabara"
