#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

rm -rf "$root/bin"
mkdir -p "$root/bin"
echo "[ Building Jabara ]"

"$root/src/jbc/build.sh"
"$root/src/orgasm/build.sh"
"$root/src/jc/build.sh"
