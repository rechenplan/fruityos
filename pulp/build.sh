echo "[ Building FruityOS kernel ]"
rm -rf bin
mkdir bin
cat src/kmain.yuzu src/idt.yuzu src/pish.yuzu src/sys.yuzu src/x86.yuzu src/utils.yuzu src/ramfs.yuzu src/fba.yuzu src/list.yuzu src/inode.yuzu src/heap.yuzu src/global.yuzu src/scr.yuzu src/kb.yuzu src/fd.yuzu > pulp.yuzu src/page.yuzu
echo Compiling...
../yuzu/bin/yc pulp.yuzu pulp.asm
cat src/entry.asm src/idt.asm pulp.asm > _.asm
echo Assembling...
nasm -f bin _.asm -o bin/pulp.bin
../peel/bin/juicer.elf c bin/pulp.bin bin/pulp.sys
rm pulp.yuzu pulp.asm _.asm

