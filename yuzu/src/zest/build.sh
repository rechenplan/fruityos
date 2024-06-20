cat main.yuzu lex.yuzu parse.yuzu emit.yuzu elf.yuzu > _.yuzu
../../bin/byc _.yuzu _.asm
cat ../../lib/_start.elf _.asm ../../lib/libpith.elf > elf.asm
cat ../../lib/_start.fap _.asm ../../lib/libpith.fap > fap.asm
nasm elf.asm -felf64 -o zest.o
ld -n -s zest.o -o ../../bin/zest
../../bin/zest f fap.asm ../../bin/zest.bin
rm _.* zest.* elf.asm fap.asm
