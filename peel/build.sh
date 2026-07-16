#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
    echo "usage: peel/build.sh platform" >&2
    exit 1
fi

platform=$1
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$root"

if [ ! -f "lib/$platform/bootstrap.asm" ]; then
    echo "peel/build.sh: unsupported host platform: $platform" >&2
    exit 1
fi

out="peel/out/$platform"
mkdir -p "$out"

# Keep the bootstrap compiler with the rest of the host environment. The
# top-level Pish build installs it into bin/ after this script returns.
bin/orgasm "lib/$platform/bootstrap.asm" jabara/src/jbc/jbc.asm \
    "lib/$platform/runtime.asm" "$out/jc"

build() {
    output=$1
    shift
    "$out/jc" "lib/$platform/pith.jabara" "$@" .jc-generated.asm
    bin/pish "lib/$platform/link.psh" "lib/$platform" \
        "$out/$output" .jc-generated.asm
    rm -f .jc-generated.asm .jc-raw
}

build concat peel/src/concat/concat.jabara
build copy peel/src/copy/copy.jabara
build del peel/src/del/del.jabara
build dir peel/src/dir/dir.jabara
build echo peel/src/echo/echo.jabara
build fill peel/src/fill/fill.jabara
build fred peel/src/fred/fred.jabara
build inode peel/src/inode/inode.jabara
build jar peel/src/jar/jar.jabara
build juicer peel/src/juicer/juicer.jabara
build mkdir peel/src/mkdir/mkdir.jabara
build move peel/src/move/move.jabara
build pad peel/src/pad/pad.jabara
build pish peel/src/pish/pish.jabara
build rmdir peel/src/rmdir/rmdir.jabara
build type peel/src/type/type.jabara
build uefi peel/src/uefi/uefi.jabara
build write peel/src/write/write.jabara

echo "Peel host environment built in $out."
