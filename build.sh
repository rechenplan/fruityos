#!/bin/sh

mkdir bin

../yuzu/bin/yuzu src/pish/pish.yuzu
mv a.out bin/pish

../yuzu/bin/yuzu src/cat/cat.yuzu
mv a.out bin/cat

../yuzu/bin/yuzu src/dir/dir.yuzu
mv a.out bin/dir
