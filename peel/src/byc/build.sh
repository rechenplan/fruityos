mkdir bin
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ src/lexer.c -o src/lexer.o
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ src/parser.c -o src/parser.o
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ src/emitter.c -o src/emitter.o
gcc -fno-stack-protector -Wno-builtin-declaration-mismatch -Wno-int-conversion -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../include/ src/byc.c -o src/byc.o
echo "extern main" > src/_.asm
cat ../../lib/_start.asm ../../lib/libpith.asm >> src/_.asm
nasm src/_.asm -felf64 -o src/_.o
ld -s -n src/lexer.o src/parser.o src/emitter.o src/byc.o src/_.o -o bin/byc
