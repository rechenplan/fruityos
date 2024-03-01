#!/bin/sh

mkdir bin tmp lib

cp ../yuzu/bin/zest.fap ./bin/zest.fap
cp ../yuzu/bin/yc.fap ./bin/yc.fap
cp ../yuzu/lib/libpith.asm ./lib/libpith.asm
cp ../yuzu/lib/_start.fap ./lib/_start.fap

echo Building pish...
bin/yc.fap src/pish/pish.yuzu tmp/pish.asm
cat lib/_start.fap tmp/pish.asm lib/libpith.asm > tmp/a.s
bin/zest.fap f tmp/a.s bin/pish.fap

echo Building concat...
bin/yc.fap src/concat/concat.yuzu tmp/concat.asm
cat lib/_start.fap tmp/concat.asm lib/libpith.asm > tmp/a.s
bin/zest.fap f tmp/a.s bin/concat.fap

echo Building echo...
bin/yc.fap src/echo/echo.yuzu tmp/echo.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/echo.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/echo.fap

echo Building del...
bin/yc.fap src/del/del.yuzu tmp/del.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/del.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/del.fap

echo Building read...
bin/yc.fap src/read/read.yuzu tmp/read.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/read.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/read.fap

echo Building write... 
bin/yc.fap src/write/write.yuzu tmp/write.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/write.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/write.fap

echo Building dir...
bin/yc.fap src/dir/dir.yuzu tmp/dir.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/dir.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/dir.fap

echo Building mkdir...
bin/yc.fap src/mkdir/mkdir.yuzu tmp/mkdir.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/mkdir.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/mkdir.fap

echo Building rmdir...
bin/yc.fap src/rmdir/rmdir.yuzu tmp/rmdir.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/rmdir.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/rmdir.fap

echo Building copy...
bin/yc.fap src/copy/copy.yuzu tmp/copy.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/copy.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/copy.fap

echo Building move...
bin/yc.fap src/move/move.yuzu tmp/move.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/move.s lib/libpith.asm 
bin/zest.fap f tmp/a.s bin/move.fap

echo Building juicer...
bin/yc.fap src/juicer/juicer.yuzu tmp/juicer.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/juicer.s lib/libpith.asm
bin/zest.fap f tmp/a.s bin/juicer.fap

echo Building jar...
bin/yc.fap src/jar/jar.yuzu tmp/juicer.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/juicer.s lib/libpith.asm
bin/zest.fap f tmp/a.s bin/jar.fap

echo Building fred...
bin/yc.fap src/fred/fred.yuzu tmp/fred.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/fred.s lib/libpith.asm
bin/zest.fap f tmp/a.s bin/fred.fap

echo Building init...
bin/yc.fap src/init/init.yuzu tmp/init.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/init.s lib/libpith.asm
bin/zest.fap f tmp/a.s init.fap

echo Creating peel.jz...
cd bin
./jar.fap c peel.jar
./juicer.fap c peel.jar ../peel.jz
./del.fap peel.jar
cd ..
