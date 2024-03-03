mkdir bin
../peel/bin/yc.fap src/kmain.yuzu kmain.asm
cat src/entry.s kmain.asm > _.asm
nasm -f bin _.asm -o bin/kernel.bin
rm kmain.asm _.asm
../peel/bin/juicer.fap c bin/kernel.bin bin/kernel.sys
cat ../seed/bin/fdseed.bin bin/kernel.sys ../peel/peel.jar > bin/fruityos.img
truncate -s 252K bin/fruityos.img
gdb --command=debug.gdb
