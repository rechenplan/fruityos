# Jabara

Jabara is FruityOS's compact, self-hosted 64-bit systems language. The compiler
translates Jabara into NASM-compatible assembly for Linux ELF programs,
FruityOS FAP applications, or headerless modules.

## Build

```sh
./build.sh
```

This produces:

- `bin/jbc`, the C bootstrap compiler;
- `bin/jc`, the compiler written in Jabara;
- `bin/jc-self`, the self-compiled consistency build;
- `bin/orgasm`, the Jabara-written, Zest-compatible assembler.

The compiler interface is:

```text
jc elf|fap|module|part input.jabara output.asm
```

Compiler output must be combined with the appropriate runtime and assembled.
The compiler does not invoke NASM, Orgasm, or Juicer itself.

## Layout

```text
jabara/
├── src/jbc/             C bootstrap compiler
├── src/jc/              self-hosted compiler
├── src/orgasm/          FruityOS-focused assembler
├── lib/pith.jabara      platform service declarations
├── lib/elf-runtime.asm  Linux startup and services
├── lib/fap-runtime.asm  FruityOS startup and services
├── tests/               compiler regression inputs
└── docs/manual.md       language tutorial and reference
```

## Test

```sh
./test.sh
./src/orgasm/test.sh
```

The suites cover bootstrapping, self-hosting, diagnostics, generated formats,
Orgasm, Juicer round trips, compatibility tools, and every Peel application.

See the [language manual](docs/manual.md) for Jabara syntax and the integrated
[toolchain guide](../docs/toolchain.md) for targets, runtimes, Orgasm, and the
FruityOS build path.
