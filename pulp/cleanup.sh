#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")" && pwd)
rm -rf "$root/bin" "$root/_.asm" "$root/pulp.asm" "$root/pulp.jabara"
