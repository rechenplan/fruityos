#!/bin/sh

mkdir bin tmp lib

cp ../yuzu/bin/zest ./bin/zest
cp ../yuzu/bin/yc ./bin/yc
cp ../yuzu/lib/libpith.asm ./lib/libpith.asm
cp ../yuzu/lib/_start.asm ./lib/_start.asm

bin/yc src/pish/pish.yuzu tmp/pish.asm
cat lib/_start.asm tmp/pish.asm lib/libpith.asm > tmp/a.s
bin/zest tmp/a.s bin/pish

bin/yc src/concat/concat.yuzu tmp/concat.asm
cat lib/_start.asm tmp/concat.asm lib/libpith.asm > tmp/a.s
bin/zest tmp/a.s bin/concat

sudo chroot . bin/pish
