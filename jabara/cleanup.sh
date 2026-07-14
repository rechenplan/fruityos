#!/bin/sh
set -eu

cd src
cd jbc
./clean.sh
cd ../jc
./clean.sh
cd ../orgasm
./clean.sh
cd ../../
rm -rf bin
