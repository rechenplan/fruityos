# Jabara, Orgasm, and Yuzu toolchains

FruityOS builds its kernel and userland with Jabara and assembles generated
modules with Orgasm. Yuzu supplies the `byc`, `yc`, and `zest` command-line
tools built by `yuzu/build.sh`.

## Jabara compilers

| Program | Implementation | Role |
| --- | --- | --- |
| `jbc` | C | Bootstrap compiler. |
| `jc` | Jabara | Self-hosted compiler. |
| `jc-self` | Output of `jc` compiling its compiler sources | Consistency build. |

`jbc` and `jc` accept:

```text
jc input.jabara [input.jabara ...] output.asm
```

Inputs are parsed in command-line order. The output is headerless,
origin-independent NASM-compatible module assembly. The compiler does not add a
runtime or invoke an assembler.

## Platform assembly

A Linux executable can be built with:

```sh
jabara/bin/jc program.jabara program-generated.asm
jabara/bin/orgasm \
  jabara/lib/elf-header.asm \
  program-generated.asm \
  jabara/lib/elf-runtime.asm \
  program
chmod +x program
```

A FruityOS FAP can be built with:

```sh
jabara/bin/jc \
  jabara/lib/pith.jabara \
  program.jabara \
  program-generated.asm
jabara/bin/orgasm \
  jabara/lib/fap-stack-runtime.asm \
  jabara/lib/fap-runtime.asm \
  program-generated.asm \
  program.raw
peel/bin/juicer.elf c program.raw program.fap
```

The platform files provide:

- `elf-header.asm`: ELF64 header, origin, and entry point;
- `elf-runtime.asm`: Linux Pith services and allocator;
- `fap-stack-runtime.asm`: FruityOS origin, entry, stack environment, and
  allocator;
- `fap-runtime.asm`: FruityOS startup, arguments, system-call wrappers, and
  exit path;
- `pith.jabara`: external service declarations;
- `juicer-runtime.asm`: Juicer decoder used by kernel and applications;
- `fap-module-runtime.asm`: module wrapper used by the generated `jc.asm`.

The root build copies every `jabara/lib/*.asm` file into initrd `/lib`.

## Jabara language model

Every ordinary value occupies one 64-bit word. Jabara provides subroutines,
lexical locals, globals, records with compile-time field tags, captured
functions, byte and word memory access, control flow, arithmetic, bitwise
operations, and external subroutine declarations.

Binary operators have equal precedence and associate left to right. The
compiler emits direct, inspectable assembly and performs no optimization.

See the [Jabara language manual](../jabara/docs/manual.md).

## Orgasm

Orgasm is written in Jabara and accepts one or more input files followed by an
output path:

```text
orgasm input.asm [input.asm ...] output
```

All inputs share one symbol table and are assembled in command-line order. Only
an explicit `org` directive selects an origin. Executable headers are ordinary
assembly inputs.

Orgasm implements the directives, register forms, address expressions,
descriptor data, and x86-64 instructions emitted by Jabara and used by Pulp.
NASM is used to bootstrap the host tool and to assemble Seed.

## Yuzu

`yuzu/build.sh` creates a fresh `yuzu/bin/` and invokes:

```text
yuzu/src/byc/build.sh
yuzu/src/yc/build.sh
yuzu/src/zest/build.sh
```

The output includes the Yuzu compiler tools and Zest assembler. The sources use
`.yuzu`; the Jabara compiler accepts them through the shared language surface
used by this repository. Peel also emits `yc.fap` and `zest.fap` for FruityOS.

See [Yuzu](../yuzu/README.md) for component paths.
