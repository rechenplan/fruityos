# Jabara

Jabara is FruityOS's compact, self-hosted 64-bit systems language. The compiler
translates one or more source files into headerless NASM-compatible module
assembly. Assembly headers and runtimes select the executable environment.

## Build

```sh
./build.sh
```

This creates:

- `bin/jbc`, the C bootstrap compiler;
- `bin/jc`, the compiler written in Jabara;
- `bin/jc-self`, the self-compiled consistency build;
- `bin/orgasm`, the Jabara-written assembler.

The compiler interface is:

```text
jc input.jabara [input.jabara ...] output.asm
```

Compiler output must be combined with an appropriate runtime and assembled.
The compiler does not invoke Orgasm, NASM, or Juicer.

## Layout

```text
jabara/
├── src/jbc/             C compiler
├── src/jc/              Jabara compiler
├── src/orgasm/          assembler
├── lib/pith.jabara      platform service declarations
├── lib/elf-header.asm   ELF64 header and startup
├── lib/elf-runtime.asm  Linux services and allocator
├── lib/fap-runtime.asm  FruityOS startup and services
├── tests/               compiler regression inputs
└── docs/manual.md       language tutorial and reference
```

## Test

```sh
./test.sh
./src/orgasm/test.sh
```

The suites cover compilation, self-compilation, diagnostics, records, closures,
ELF and FAP output, Orgasm, Juicer round trips, Yuzu integration, and every Peel
application.

See the [language manual](docs/manual.md) for Jabara syntax and the integrated
[toolchain guide](../docs/toolchain.md) for runtimes and executable targets.
