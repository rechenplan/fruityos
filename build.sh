mkdir bin
../peel/bin/yc.fap src/kmain.yuzu kmain.asm
cat src/entry.s kmain.asm > _.asm
nasm -f bin _.asm -o bin/pulp.bin
../peel/bin/juicer.fap c bin/pulp.bin bin/pulp.sys
rm kmain.asm _.asm
