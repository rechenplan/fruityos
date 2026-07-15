#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)

"$root/src/jbc/clean.sh"
"$root/src/jc/clean.sh"
"$root/src/orgasm/clean.sh"
rm -rf "$root/bin"
