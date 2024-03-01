gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ lexer.c -o lexer.o
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ parser.c -o parser.o
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ emitter.c -o emitter.o
gcc -fno-stack-protector -Wno-builtin-declaration-mismatch -Wno-int-conversion -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ byc.c -o byc.o
echo "extern main" > _.asm
cat ../../lib/_start.elf ../../lib/libpith.asm >> _.asm
nasm _.asm -felf64 -o _.o
ld -s -n lexer.o parser.o emitter.o byc.o _.o -o ../../bin/byc
rm _.asm *.o
