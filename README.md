# CitrusOS

## intro

This is the begining of a smol OS called CitrusOS. The plan is to first develop a programming language called yuzu and write a bootstrap compiler. Then I'm going to write userland stuff in yuzu. Finally, I'll write the kernel in yuzu. This document is a roadmap of the things that need to be done immediately.

## requirements

  gcc
  nasm
  linux kernel x86-64

## peel (userland)

1. by: program to compile yuzu to bytecode (zest) - bootstrap compiler frontend (C)
2. bz: program to compile bytecode (zest) - bootstrap compiler backend (produces object files) (C)
3. bergamot: shell (yuzu)
4. olio: a line editor (yuzu)
5. yuzu: final compiler frontend (yuzu)
6. zest: final compiler backend (produces object files) (yuzu)

Notes: zest will support multiple output formats and will perform linking of zest files. We will start with
an elf64 object file output format and binary format for testing and ultimately move to a custom executable format
for our OS. bz only need support elf64 object file output.

## pith (standard library)

1. execv: needed for shell
2. argv: needed for shell
3. env: needed for shell

## pulp (kernel)

This is so far down the road I can't imagine getting here yet. It will be unix like.
