mkdir bin
cat src/kmain.yuzu src/sys.yuzu src/x86.yuzu src/utils.yuzu > pulp.yuzu
../peel/bin/yc.fap pulp.yuzu pulp.asm
cat src/entry.s pulp.asm > _.asm
nasm -f bin _.asm -o bin/pulp.bin
../peel/bin/juicer.fap c bin/pulp.bin bin/pulp.sys
rm pulp.yuzu pulp.asm _.asm
