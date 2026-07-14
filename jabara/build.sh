#!/bin/sh
set -eu

rm -rf bin
echo "[ Building jabara ]"
mkdir bin
cd src
cd jbc
./build.sh
cd ../
cd jc
./build.sh
cd ../
