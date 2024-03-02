mkdir bin
../peel/bin/yc.fap src/kmain.yuzu kmain.asm
cat src/entry.s kmain.asm > _.asm
nasm -f bin _.asm -o bin/kernel.bin
rm kmain.asm _.asm
../peel/bin/juicer.fap c bin/kernel.bin bin/kernel.zip
cat ../seed/bin/fdseed.bin bin/kernel.zip ../peel/peel.jar > bin/kernel.img
truncate -s 1440K bin/kernel.img
gdb --command=debug.gdb
