#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)

"$root/src/byc/clean.sh"
"$root/src/zest/clean.sh"
"$root/src/yc/clean.sh"
rm -rf "$root/bin"
