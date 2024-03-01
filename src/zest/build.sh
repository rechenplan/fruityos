cat main.yuzu lex.yuzu parse.yuzu emit.yuzu elf.yuzu > _.yuzu
../../bin/byc _.yuzu _.asm
cat ../../lib/_start.elf _.asm ../../lib/libpith.asm > elf.asm
cat ../../lib/_start.fap _.asm ../../lib/libpith.asm > fap.asm
nasm elf.asm -felf64 -o zest.o
ld -n -s zest.o -o ../../bin/zest
nasm fap.asm -fbin -p org.s -o ../../bin/zest.fap
chmod +x ../../bin/zest.fap
rm _.* zest.* elf.asm fap.asm
