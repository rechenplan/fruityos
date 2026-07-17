# Jabara

Jabara is FruityOS's compact, self-hosted 64-bit systems language. The compiler
translates one or more source files into headerless module assembly. Orgasm
combines that output with the selected platform header and runtime.

## Build

The root invokes:

```text
cd jabara
build.psh $platform fruityos-x86_64
```

Jabara owns the complete compiler bootstrap. Bootstrap Orgasm lives under
`bin/bootstrap/$platform/`, and the repository checks in `src/jbc/jbc.asm`, but
no compiler executable. The compiler source build:

1. links `src/jbc/jbc.asm` with the ordinary host platform linker;
2. installs the resulting first compiler as `bin/jc.<host-extension>`;
3. rebuilds `jc` through the common compiler driver;
4. rebuilds and installs host Orgasm;
5. cross-builds `jc`, Orgasm, and `jc.asm` for FruityOS.

Host outputs use the active platform suffix:

```text
jabara/out/linux-x86_64/jc.elf
jabara/out/linux-x86_64/jc-self.elf
jabara/out/linux-x86_64/orgasm.elf

jabara/out/windows-x86_64/jc.exe
jabara/out/windows-x86_64/jc-self.exe
jabara/out/windows-x86_64/orgasm.exe

jabara/out/fruityos-x86_64/jc.fap
jabara/out/fruityos-x86_64/orgasm.fap
```

The FruityOS target build also publishes:

```text
jabara/out/fruityos-x86_64/jc.asm
```

The compiler interface is:

```text
jc input.jabara [input.jabara ...] output.asm
```

The current language uses `new Record` for record construction and `lift var`
for explicit shallow promotion from an `fn` into its lexical owner frame. See
the language manual for the scope and lifetime rules.

The build does not invoke a C compiler, GCC, NASM, Make, PowerShell, `cmd.exe`,
or a separate bootstrap script.

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
