mkdir bin
../../../bin/byc src/cat.yuzu > src/cat.asm
../../../bin/cat ../../../lib/_start.asm src/cat.asm ../../../lib/libpith.asm > _.asm
../../../bin/zest 1048576 _.asm bin/cat.bin
rm _.asm src/cat.asm
