#!/bin/sh

mkdir bin

../yuzu/bin/yuzu src/pish/pish.yuzu
mv a.out bin/pish

../yuzu/bin/yuzu src/type/type.yuzu
mv a.out bin/type

../yuzu/bin/yuzu src/dir/dir.yuzu
mv a.out bin/dir

../yuzu/bin/yuzu src/del/del.yuzu
mv a.out bin/del

../yuzu/bin/yuzu src/move/move.yuzu
mv a.out bin/move

../yuzu/bin/yuzu src/mkdir/mkdir.yuzu
mv a.out bin/mkdir

../yuzu/bin/yuzu src/rmdir/rmdir.yuzu
mv a.out bin/rmdir

../yuzu/bin/yuzu src/copy/copy.yuzu
mv a.out bin/copy

../yuzu/bin/yuzu src/echo/echo.yuzu
mv a.out bin/echo

../yuzu/bin/yuzu src/ed/edlist.yuzu
mv a.out bin/edlist

../yuzu/bin/yuzu src/ed/eddel.yuzu
mv a.out bin/eddel

../yuzu/bin/yuzu src/ed/edins.yuzu
mv a.out bin/edins
