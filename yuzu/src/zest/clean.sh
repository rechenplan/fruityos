#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
rm -f "$root/../../bin/zest" "$root"/*.o "$root"/*.asm "$root/_.yuzu"
