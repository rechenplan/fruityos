../../yuzu/bin/yc kmain.yuzu kmain.asm
cat entry.s kmain.asm > kernel.asm
nasm -f bin kernel.asm -o ../bin/kernel.bin
rm kmain.asm kernel.asm
cat ../../seed/bin/fdseed.bin ../bin/kernel.bin > ../bin/kernel.img
