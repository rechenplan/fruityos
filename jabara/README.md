# Jabara

Jabara is FruityOS's compact, self-hosted 64-bit systems language. The compiler
translates one or more source files into headerless module assembly. Orgasm
combines that output with the selected header and runtime.

## Build

From the repository root, run the complete build with:

```text
bin/pish build.psh
```

The repository checks in Orgasm and the generated compiler module
`src/jbc/jbc.asm`, but no Jabara compiler executable. Orgasm assembles the
module into a temporary bootstrap compiler, which writes:

- `jabara/out/$platform/orgasm`, the rebuilt assembler;
- `jabara/out/$platform/jc`, the rebuilt Jabara compiler;
- `jabara/out/$platform/jc-self`, the self-compiled consistency build.

The compiler interface is:

```text
jc input.jabara [input.jabara ...] output.asm
```

The build does not invoke a C bootstrap compiler, GCC, NASM, or Make. The
repository-level Peel bootstrap uses a POSIX shell.

## Layout

```text
jabara/
├── src/jbc/jbc.asm      generated bootstrap compiler module
├── src/jc/              Jabara compiler sources
├── src/orgasm/          assembler sources
├── lib/pith.jabara      platform service declarations
├── lib/elf-header.asm   ELF64 header and startup
├── lib/elf-runtime.asm  Linux services and allocator
├── lib/fap-runtime.asm  FruityOS startup and services
├── tests/               compiler regression inputs
└── docs/manual.md       language tutorial and reference
```

See the [language manual](docs/manual.md) and the integrated
[toolchain guide](../docs/toolchain.md).
