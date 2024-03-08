#!/bin/sh

mkdir bin tmp lib

cp ../yuzu/bin/zest bin/zest.elf
cp ../yuzu/bin/yc bin/yc.elf
cp ../yuzu/bin/zest.bin tmp/zest.bin
cp ../yuzu/bin/yc.bin tmp/yc.bin
cp ../yuzu/lib/libpith.elf ./lib/libpith.elf
cp ../yuzu/lib/libpith.fap ./lib/libpith.fap
cp ../yuzu/lib/_start.fap ./lib/_start.fap
cp ../yuzu/lib/_start.elf ./lib/_start.elf

echo Building juicer...
bin/yc.elf src/juicer/juicer.yuzu tmp/juicer.s
cat lib/_start.elf tmp/juicer.s lib/libpith.elf > tmp/a.s
bin/zest.elf e tmp/a.s bin/juicer.elf

echo Juicing yc...
bin/juicer.elf c tmp/yc.bin bin/yc.fap

echo Juicing zest...
bin/juicer.elf c tmp/zest.bin bin/zest.fap

echo Building pish...
bin/yc.fap src/pish/pish.yuzu tmp/pish.asm
cat lib/_start.fap tmp/pish.asm lib/libpith.fap > tmp/a.s
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/pish.fap

echo Building concat...
bin/yc.fap src/concat/concat.yuzu tmp/concat.asm
cat lib/_start.fap tmp/concat.asm lib/libpith.fap > tmp/a.s
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/concat.fap

echo Building echo...
bin/yc.fap src/echo/echo.yuzu tmp/echo.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/echo.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/echo.fap

echo Building del...
bin/yc.fap src/del/del.yuzu tmp/del.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/del.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/del.fap

echo Building read...
bin/yc.fap src/read/read.yuzu tmp/read.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/read.s lib/libpith.fap 
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/read.fap

echo Building write... 
bin/yc.fap src/write/write.yuzu tmp/write.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/write.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/write.fap

echo Building dir...
bin/yc.fap src/dir/dir.yuzu tmp/dir.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/dir.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/dir.fap

echo Building mkdir...
bin/yc.fap src/mkdir/mkdir.yuzu tmp/mkdir.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/mkdir.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/mkdir.fap

echo Building rmdir...
bin/yc.fap src/rmdir/rmdir.yuzu tmp/rmdir.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/rmdir.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/rmdir.fap

echo Building copy...
bin/yc.fap src/copy/copy.yuzu tmp/copy.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/copy.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/copy.fap

echo Building move...
bin/yc.fap src/move/move.yuzu tmp/move.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/move.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/move.fap

echo Building juicer...
bin/yc.fap src/juicer/juicer.yuzu tmp/juicer.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/juicer.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/juicer.fap

echo Building jar...
bin/yc.fap src/jar/jar.yuzu tmp/juicer.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/juicer.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/jar.fap

echo Building fred...
bin/yc.fap src/fred/fred.yuzu tmp/fred.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/fred.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/fred.fap

echo Building init...
bin/yc.fap src/init/init.yuzu tmp/init.s
bin/concat.fap tmp/a.s lib/_start.fap tmp/init.s lib/libpith.fap
bin/zest.fap f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/init.fap

rm bin/*.elf
