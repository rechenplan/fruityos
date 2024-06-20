#!/bin/sh

rm -rf bin lib tmp
mkdir bin tmp lib

cp ../yuzu/bin/zest bin/zest.elf
cp ../yuzu/bin/yc bin/yc.elf
cp ../yuzu/bin/zest.bin tmp/zest.bin
cp ../yuzu/bin/yc.bin tmp/yc.bin
cp ../yuzu/lib/libpith.elf ./lib/libpith.elf
cp ../yuzu/lib/libpith.fap ./lib/libpith.fap
cp ../yuzu/lib/_start.fap ./lib/_start.fap
cp ../yuzu/lib/_start.elf ./lib/_start.elf

echo Building jar for Linux...
bin/yc.elf src/jar/jar.yuzu tmp/jar.s
cat lib/_start.elf tmp/jar.s lib/libpith.elf > tmp/a.s
bin/zest.elf e tmp/a.s bin/jar.elf

echo Building juicer for Linux...
bin/yc.elf src/juicer/juicer.yuzu tmp/juicer.s
cat lib/_start.elf tmp/juicer.s lib/libpith.elf > tmp/a.s
bin/zest.elf e tmp/a.s bin/juicer.elf

echo Juicing yc...
bin/juicer.elf c tmp/yc.bin bin/yc.fap

echo Juicing zest...
bin/juicer.elf c tmp/zest.bin bin/zest.fap

echo Building concat...
bin/yc.elf src/concat/concat.yuzu tmp/concat.asm
cat lib/_start.fap tmp/concat.asm lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/concat.fap

echo Building echo...
bin/yc.elf src/echo/echo.yuzu tmp/echo.s
cat lib/_start.fap tmp/echo.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/echo.fap

echo Building del...
bin/yc.elf src/del/del.yuzu tmp/del.s
cat lib/_start.fap tmp/del.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/del.fap

echo Building type...
bin/yc.elf src/type/type.yuzu tmp/type.s
cat lib/_start.fap tmp/type.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/type.fap

echo Building write...
bin/yc.elf src/write/write.yuzu tmp/write.s
cat lib/_start.fap tmp/write.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/write.fap

echo Building dir...
bin/yc.elf src/dir/dir.yuzu tmp/dir.s
cat lib/_start.fap tmp/dir.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/dir.fap

echo Building mkdir...
bin/yc.elf src/mkdir/mkdir.yuzu tmp/mkdir.s
cat lib/_start.fap tmp/mkdir.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/mkdir.fap

echo Building rmdir...
bin/yc.elf src/rmdir/rmdir.yuzu tmp/rmdir.s
cat lib/_start.fap tmp/rmdir.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/rmdir.fap

echo Building copy...
bin/yc.elf src/copy/copy.yuzu tmp/copy.s
cat lib/_start.fap tmp/copy.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/copy.fap

echo Building move...
bin/yc.elf src/move/move.yuzu tmp/move.s
cat lib/_start.fap tmp/move.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/move.fap

echo Building juicer...
bin/yc.elf src/juicer/juicer.yuzu tmp/juicer.s
cat lib/_start.fap tmp/juicer.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/juicer.fap

echo Building jar...
bin/yc.elf src/jar/jar.yuzu tmp/juicer.s
cat lib/_start.fap tmp/juicer.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/jar.fap

echo Building fred...
bin/yc.elf src/fred/fred.yuzu tmp/fred.s
cat lib/_start.fap tmp/fred.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/fred.fap

echo Building inode...
bin/yc.elf src/inode/inode.yuzu tmp/inode.s
cat lib/_start.fap tmp/inode.s lib/libpith.fap > tmp/a.s
bin/zest.elf f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/inode.fap

rm -rf tmp
