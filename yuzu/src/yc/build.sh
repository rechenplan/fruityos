cat *.yuzu > _yc.yuzu
../../bin/byc _yc.yuzu _yc.asm
cat ../../lib/_start.asm _yc.asm ../../lib/libpith.asm > yc.asm
nasm yc.asm -felf64 -o yc.o
ld -s -n yc.o -o ../../bin/yc
rm _yc.yuzu yc.o yc.asm _yc.asm
