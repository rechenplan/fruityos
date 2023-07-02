cat src/main.yuzu src/lex.yuzu src/parse.yuzu src/emit.yuzu src/elf.yuzu > src/_.yuzu
../../bin/byc src/_.yuzu > src/_.asm
cat ../../lib/_start.asm src/_.asm ../../lib/libpith.asm > src/zest.asm
nasm src/zest.asm -felf64 -o src/zest.o
ld -n -s src/zest.o -o ../../bin/zest
