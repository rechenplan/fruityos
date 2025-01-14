echo "[ Building FruityOS kernel ]"

rm -rf bin tmp
mkdir bin
mkdir tmp

echo Compiling kmain.yuzu...
../yuzu/bin/yc src/kmain.yuzu tmp/kmain.asm

echo Compiling sys.yuzu...
../yuzu/bin/yc src/sys.yuzu tmp/sys.asm

echo Compiling x86.yuzu...
../yuzu/bin/yc src/x86.yuzu tmp/x86.asm

echo Compiling utils.yuzu...
../yuzu/bin/yc src/utils.yuzu tmp/utils.asm

echo Compiling ramfs.yuzu...
../yuzu/bin/yc src/ramfs.yuzu tmp/ramfs.asm

echo Compiling fba.yuzu...
../yuzu/bin/yc src/fba.yuzu tmp/fba.asm

echo Compiling list.yuzu...
../yuzu/bin/yc src/list.yuzu tmp/list.asm

echo Compiling inode.yuzu...
../yuzu/bin/yc src/inode.yuzu tmp/inode.asm

echo Compiling heap.yuzu...
../yuzu/bin/yc src/heap.yuzu tmp/heap.asm

echo Compiling global.yuzu...
../yuzu/bin/yc src/global.yuzu tmp/global.asm

echo Compiling scr.yuzu...
../yuzu/bin/yc src/scr.yuzu tmp/scr.asm

echo Compiling kb.yuzu...
../yuzu/bin/yc src/kb.yuzu tmp/kb.asm

echo Compiling fd.yuzu...
../yuzu/bin/yc src/fd.yuzu tmp/fd.asm

echo Compiling page.yuzu...
../yuzu/bin/yc src/page.yuzu tmp/page.asm

echo Compiling idt.yuzu...
../yuzu/bin/yc src/idt.yuzu tmp/idt.asm

cat src/entry.asm src/idt.asm tmp/kmain.asm tmp/idt.asm tmp/sys.asm tmp/x86.asm tmp/utils.asm tmp/ramfs.asm tmp/fba.asm tmp/list.asm tmp/inode.asm tmp/heap.asm tmp/global.asm tmp/scr.asm tmp/kb.asm tmp/fd.asm tmp/page.asm > tmp/pulp.asm

echo Assembling...
nasm -f bin tmp/pulp.asm -o bin/pulp.bin
../peel/bin/juicer.elf c bin/pulp.bin bin/pulp.sys


rm -rf tmp
