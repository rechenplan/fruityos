# citrusos

## intro

this is the begining of a smol OS called citrusos. the plan is to first develop a programming language called yuzu and write a bootstrap compiler. then I'm going to write userland stuff in yuzu. finally, i'll write the kernel in yuzu. this document is a roadmap of the things that need to be done.

## requirements

* gcc
* nasm
* a 64 bit linux kernel

## phase 1: userland environment using linux kernel

### peel (userland)

1. by: program to compile yuzu to assembly (nasm) - bootstrap compiler (C)
2. bergamot: shell (yuzu)
3. olio: a line editor (yuzu)
4. yuzu: final compiler frontend (yuzu)
5. zest: final compiler backend (produces object files) (yuzu)

Notes: zest will support multiple output formats and will perform linking of zest files. We will start with
an elf64 object file output format and binary format for testing and ultimately move to a custom executable format
for phase 2. bz only need support elf64 object file output.

### pith (standard library)

1. execv: needed for shell
2. argv: needed for shell
3. env: needed for shell

## phase 2: pulp (kernel)

this is so far down the road i can't imagine getting here yet. it will be unix like and will basically support the syscalls used by pith.
