# citrusos

## intro

this is the begining of a smol os called citrusos. the plan is to first develop a programming language called yuzu and write a bootstrap compiler. then I'm going to write userland stuff in yuzu. finally, i'll write the kernel in yuzu. this document is a roadmap of the things that need to be done.

## requirements

* gcc
* nasm
* a 64 bit linux kernel

## bootstrapping sequence

1. assemble libpith with nasm. link with ld.
2. compile byc with gcc and libpith. link with ld.
3. compile yuzu with byc and libpith. link with ld.
4. compile zest with byc and libpith. link with ld.
5. compile quat with byc and libpith. link with ld.

now we have a compiler frontend (yuzu), backend (zest), library (libpith) and linker (quat) that are togther capable of building themselves.

## phase 1: userland environment using linux kernel

### peel (userland)

1. byc: program to compile yuzu to assembly (nasm) - bootstrap yuzu compiler (C) DONE!
2. zest: final compiler backend (assembler - produces object files) (yuzu)
3. quat: final linker (yuzu)
4. yuzu: final compiler frontend (yuzu)
5. bergamot: shell (yuzu)
6. various utilities (yuzu)

notes: zest will support multiple output formats. We will start with an elf64 object file
output format and binary format for testing and ultimately move to a custom executable format
for phase 2. bz only need support elf64 object file output.

### pith (standard library)

1. execv: needed for shell
2. argv: needed for shell
3. env: needed for shell

## phase 2: pulp (kernel)

this is so far down the road i can't imagine getting here yet. it will be unix like and will basically support the syscalls used by pith.
