cat *.yuzu > _yc.yuzu
../../bin/byc _yc.yuzu _yc.asm
cat ../../lib/_start.elf _yc.asm ../../lib/libpith.asm > elf.asm
cat ../../lib/_start.fap _yc.asm ../../lib/libpith.asm > fap.asm
../../bin/zest e elf.asm ../../bin/yc
../../bin/zest f fap.asm ../../bin/yc.bin
rm elf.asm fap.asm _yc.yuzu _yc.asm
