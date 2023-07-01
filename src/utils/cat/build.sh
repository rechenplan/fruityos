mkdir bin
../../../bin/byc src/cat.yuzu > src/cat.asm
cat ../../../lib/_start.asm src/cat.asm ../../../lib/libpith.asm > src/_.asm
../../../bin/zest 1048576 src/_.asm bin/cat.bin
rm src/_.asm src/cat.asm
