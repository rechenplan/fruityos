#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)

rm -rf "$root/bin"
mkdir -p "$root/bin"
echo "[ Building Yuzu compatibility tools with Jabara ]"

"$root/src/byc/build.sh"
"$root/src/yc/build.sh"
"$root/src/zest/build.sh"

echo "yuzu: Jabara compatibility build passed"
