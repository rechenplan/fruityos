# yuzu

## intro

a smol system language

## requirements

* gcc
* nasm
* a 64 bit linux kernel

## components

this repository contains four pieces of software

1. byc: a bootstrapping compiler for yuzu written in c
2. zest: an assembler written in yuzu
3. yc: a yuzu compiler written in yuzu
4. libpith.asm: a standard library for x86-64 linux
5. yuzu: a script that uses all of these in conjunction to take yuzu code and produce native linux executables

## bootstrapping sequence

the build.sh script will bootstrap yuzu by performing the following operations:

1. compile byc with gcc and libpith with nasm. link with ld.
2. compile zest with byc (which will produce assembly output). assemble zest and libpith with nasm. link with ld
3. compile yc with byc and assemble yc and libpith with zest.

now we have a compiler frontend (yc), assembler (zest), library (libpith) that are togther capable of building themselves.
