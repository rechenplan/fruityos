# Jabara

Jabara is FruityOS's compact, self-hosted 64-bit systems language. The compiler
translates one or more source files into headerless module assembly. Orgasm
combines that output with the selected header and runtime.

## Build

The root invokes:

```text
cd jabara
build.psh $platform fruityos-x86_64
```

Jabara owns the complete compiler bootstrap. The repository checks in Orgasm
and `src/jbc/jbc.asm`, but no compiler executable. The compiler source build:

1. links `src/jbc/jbc.asm` with the ordinary host platform linker;
2. installs the resulting first compiler as root `bin/jc`;
3. rebuilds `jc` through the common compiler driver;
4. rebuilds and installs host Orgasm;
5. cross-builds `jc`, Orgasm, and `jc.asm` for FruityOS.

Published outputs are written to:

```text
jabara/out/$platform/jc
jabara/out/$platform/jc-self
jabara/out/$platform/orgasm
jabara/out/fruityos-x86_64/jc
jabara/out/fruityos-x86_64/jc.asm
jabara/out/fruityos-x86_64/orgasm
```

The compiler interface is:

```text
jc input.jabara [input.jabara ...] output.asm
```

The build does not invoke a C compiler, GCC, NASM, Make, or a separate bootstrap
script.

## Layout

```text
jabara/
├── src/jbc/jbc.asm      generated first-stage compiler module
├── src/jc/              Jabara compiler sources and build
├── src/orgasm/          assembler sources and build
├── lib/                 compiler configuration modules
├── tests/               compiler regression inputs
└── docs/manual.md       language tutorial and reference
```

See the [language manual](docs/manual.md) and the integrated
[toolchain guide](../docs/toolchain.md).
