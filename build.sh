mkdir bin

../yuzu/bin/yuzu src/pish/pish.y
mv a.out bin/pish

../yuzu/bin/yuzu src/cat/cat.y
mv a.out bin/cat
