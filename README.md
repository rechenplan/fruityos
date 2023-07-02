# yuzu

## intro

a smol system language for juicyos.

## requirements

* gcc
* nasm
* a 64 bit linux kernel

## components

yuzu transpiles to x86-64 assembly.

1. byc: a bootstrapping compiler for yuzu written in c
2. zest: an assembler written in yuzu
3. yc: a yuzu compiler written in yuzu
4. libpith.asm: a standard library for x86-64 linux

## bootstrapping sequence

1. compile byc with gcc and libpith with nasm. link with ld.
2. compile zest with byc (which will produce assembly output). assemble zest and libpith with nasm. link with ld
3. compile yuzu with byc and assemble yuzu and libpith with zest.

now we have a compiler frontend (yuzu), assembler (zest), library (libpith) that are togther capable of building themselves.
