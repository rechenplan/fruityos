# Jabara

Jabara is FruityOS's compact, self-hosted 64-bit systems language. The compiler
translates one or more source files into headerless module assembly. Orgasm
combines that output with the selected header and runtime.

## Build

From the repository root, run the complete build with:

```text
bin/pish build.psh
```

The Jabara stage uses the checked-in bootstrap `jc` and `orgasm`, then writes:

- `jabara/out/orgasm`, the rebuilt assembler;
- `jabara/out/jc`, the rebuilt Jabara compiler;
- `jabara/out/jc-self`, the self-compiled consistency build.

The compiler interface is:

```text
jc input.jabara [input.jabara ...] output.asm
```

The build does not invoke the C bootstrap compiler, GCC, NASM, or shell file
utilities.

## Layout

```text
jabara/
├── src/jbc/             C compiler source retained as an implementation
├── src/jc/              Jabara compiler
├── src/orgasm/          assembler
├── lib/pith.jabara      platform service declarations
├── lib/elf-header.asm   ELF64 header and startup
├── lib/elf-runtime.asm  Linux services and allocator
├── lib/fap-runtime.asm  FruityOS startup and services
├── tests/               compiler regression inputs
└── docs/manual.md       language tutorial and reference
```

See the [language manual](docs/manual.md) and the integrated
[toolchain guide](../docs/toolchain.md).
