# zest

zest will be a nasm style assembler written in yuzu that assembles the subset of x86-64 assembly needed to assemble
yuzu/byc output and just enough to assemble libpith as well

## todos

1. Compile list of all x86-64 assembly instructions that need to be assembled currently.
2. Write flat assembler (no object code yet). Compare output with nasm for testing.
3. Write ELF64 object file wrapper.
