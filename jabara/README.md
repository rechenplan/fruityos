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

Jabara owns the legacy bootstrap boundary. Bootstrap Orgasm lives under
`bin/bootstrap/$platform/`, and the repository checks in `src/jbc/jbc.asm`, but
no compiler executable. The compiler source build:

1. links `src/jbc/jbc.asm` with the preserved Jabara platform linker;
2. installs the first compiler as `bin/jabara.<host-extension>`;
3. builds one current Jabara compiler generation through `bin/jb.psh`;
4. rebuilds and installs host Orgasm;
5. cross-builds Jabara, Orgasm, and the Jabara FAP module for FruityOS.

Host outputs use the active platform suffix:

```text
jabara/out/linux-x86_64/jc.elf
jabara/out/linux-x86_64/orgasm.elf

jabara/out/windows-x86_64/jc.exe
jabara/out/windows-x86_64/orgasm.exe

jabara/out/fruityos-x86_64/jc.fap
jabara/out/fruityos-x86_64/orgasm.fap
```

The FruityOS target build also publishes:

```text
jabara/out/fruityos-x86_64/jc.asm
```

The installed compiler interface is:

```text
jabara input.jabara [input.jabara ...] output.asm
```

The executable-building legacy driver is:

```text
bin/jb.psh PLATFORM OUTPUT SOURCE.jabara...
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
