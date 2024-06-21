cat *.yuzu > _yc.yuzu
../../bin/byc _yc.yuzu _yc.asm
cat ../../lib/_start.elf _yc.asm ../../lib/libpith.elf > elf.asm
../../bin/zest e elf.asm ../../bin/yc

../../bin/yc _yc.yuzu _yc.asm
cat ../../lib/_start.fap _yc.asm ../../lib/libpith.fap > fap.asm
../../bin/zest f fap.asm ../../bin/yc.bin
rm elf.asm fap.asm _yc.yuzu _yc.asm
