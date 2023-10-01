cat ../../lib/_start.asm > _.asm
cat *.yuzu > _.yuzu
../../bin/byc _.yuzu __.asm
cat __.asm >> _.asm
cat ../../lib/libpith.asm >> _.asm
../../bin/zest _.asm a.out
mv ./a.out ../../bin/yc
rm _.asm _.yuzu __.asm
