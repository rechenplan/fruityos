cat main.yuzu lex.yuzu parse.yuzu emit.yuzu elf.yuzu > _.yuzu
../../bin/yc _.yuzu _.asm
cat ../../lib/_start.asm _.asm ../../lib/libpith.asm > zest.asm
nasm zest.asm -felf64 -o zest.o
ld -n -s zest.o -o ../../bin/zest
rm _.* zest.*

