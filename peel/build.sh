#!/bin/sh

rm -rf bin tmp
mkdir bin tmp

echo "[ Building FruityOS userland ]"

echo Building jar for Linux...
../yuzu/bin/yc src/jar/jar.yuzu tmp/jar.s
cat ../yuzu/lib/_start.asm tmp/jar.s ../yuzu/lib/libpith.asm > tmp/a.s
../yuzu/bin/zest e tmp/a.s bin/jar.elf

echo Building juicer for Linux...
../yuzu/bin/yc src/juicer/juicer.yuzu tmp/juicer.s
cat ../yuzu/lib/_start.asm tmp/juicer.s ../yuzu/lib/libpith.asm > tmp/a.s
../yuzu/bin/zest e tmp/a.s bin/juicer.elf

echo Building concat...
../yuzu/bin/yc src/concat/concat.yuzu tmp/concat.asm
cat lib/_start.asm tmp/concat.asm lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/concat.fap

echo Building echo...
../yuzu/bin/yc src/echo/echo.yuzu tmp/echo.s
cat lib/_start.asm tmp/echo.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/echo.fap

echo Building del...
../yuzu/bin/yc src/del/del.yuzu tmp/del.s
cat lib/_start.asm tmp/del.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/del.fap

echo Building type...
../yuzu/bin/yc src/type/type.yuzu tmp/type.s
cat lib/_start.asm tmp/type.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/type.fap

echo Building write...
../yuzu/bin/yc src/write/write.yuzu tmp/write.s
cat lib/_start.asm tmp/write.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/write.fap

echo Building dir...
../yuzu/bin/yc src/dir/dir.yuzu tmp/dir.s
cat lib/_start.asm tmp/dir.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/dir.fap

echo Building mkdir...
../yuzu/bin/yc src/mkdir/mkdir.yuzu tmp/mkdir.s
cat lib/_start.asm tmp/mkdir.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/mkdir.fap

echo Building rmdir...
../yuzu/bin/yc src/rmdir/rmdir.yuzu tmp/rmdir.s
cat lib/_start.asm tmp/rmdir.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/rmdir.fap

echo Building copy...
../yuzu/bin/yc src/copy/copy.yuzu tmp/copy.s
cat lib/_start.asm tmp/copy.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/copy.fap

echo Building move...
../yuzu/bin/yc src/move/move.yuzu tmp/move.s
cat lib/_start.asm tmp/move.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/move.fap

echo Building juicer...
../yuzu/bin/yc src/juicer/juicer.yuzu tmp/juicer.s
cat lib/_start.asm tmp/juicer.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/juicer.fap

echo Building jar...
../yuzu/bin/yc src/jar/jar.yuzu tmp/juicer.s
cat lib/_start.asm tmp/juicer.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/jar.fap

echo Building fred...
../yuzu/bin/yc src/fred/fred.yuzu tmp/fred.s
cat lib/_start.asm tmp/fred.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/fred.fap

echo Building inode...
../yuzu/bin/yc src/inode/inode.yuzu tmp/inode.s
cat lib/_start.asm tmp/inode.s lib/libpith.asm > tmp/a.s
../yuzu/bin/zest f tmp/a.s tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/inode.fap

echo Building yc...
cp -rp ../yuzu/src/yc .
echo Compiling yc.yuzu...
../yuzu/bin/yc yc/yc.yuzu tmp/yc.asm
echo Compiling parser.yuzu...
../yuzu/bin/yc yc/parser.yuzu tmp/parser.asm
echo Compiling lexer.yuzu...
../yuzu/bin/yc yc/lexer.yuzu tmp/lexer.asm
echo Compiling emitter.yuzu...
../yuzu/bin/yc yc/emitter.yuzu tmp/emitter.asm
cat lib/_start.asm tmp/yc.asm tmp/parser.asm tmp/lexer.asm tmp/emitter.asm lib/libpith.asm > tmp/a.asm
echo Assembling...
../yuzu/bin/zest f tmp/a.asm tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/yc.fap

echo Building zest...
cp -rp ../yuzu/src/zest .
echo Compiling main.yuzu...
../yuzu/bin/yc zest/main.yuzu tmp/main.asm
echo Compiling parse.yuzu...
../yuzu/bin/yc zest/parse.yuzu tmp/parser.asm
echo Compiling lex.yuzu...
../yuzu/bin/yc zest/lex.yuzu tmp/lexer.asm
echo Compiling emit.yuzu...
../yuzu/bin/yc zest/emit.yuzu tmp/emitter.asm
echo Compiling elf.yuzu...
../yuzu/bin/yc zest/elf.yuzu tmp/elf.asm
cat lib/_start.asm tmp/main.asm tmp/parser.asm tmp/lexer.asm tmp/emitter.asm tmp/elf.asm lib/libpith.asm > tmp/a.asm
echo Assembling...
../yuzu/bin/zest f tmp/a.asm tmp/a.bin
bin/juicer.elf c tmp/a.bin bin/zest.fap

rm -rf tmp
