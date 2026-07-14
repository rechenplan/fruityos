# Jabara and Orgasm toolchain

FruityOS is built with Jabara, a compact 64-bit systems language. Jabara emits
NASM-compatible source and keeps platform runtimes outside the compiler. Orgasm
is the Jabara-written assembler used for native FAP builds and optionally for
the host Pulp build.

## Compiler implementations

| Program | Implementation | Role |
| --- | --- | --- |
| `jbc` | ANSI C | Bootstrap compiler. |
| `jc` | Jabara | Normal self-hosted compiler. |
| `jc-self` | Output of `jc` compiling itself | Bootstrap consistency artifact. |

All implement the same command shape:

```text
jc elf|fap|module input.jabara output.asm
```

The output is assembly. A separate runtime, assembler, and optional compression
step produces a runnable file.

## Output formats

| Format | Origin | Generated prefix | Runtime | Primary use |
| --- | ---: | --- | --- | --- |
| `elf` | `0x400000` | Minimal flat ELF64 header | `elf-runtime.asm` | Linux bootstrap tools and tests. |
| `fap` | `0x801000` | FruityOS entry trampoline | `fap-runtime.asm` | Peel applications. |
| `module` | Supplied externally | None | Platform-supplied | Pulp and embedded compiler modules. |

An ELF build looks like:

```sh
jabara/bin/jc elf program.jabara program-generated.asm
cat program-generated.asm jabara/lib/elf-runtime.asm > program.asm
nasm -f bin program.asm -o program
chmod +x program
```

A FruityOS application follows the same separation:

```sh
jabara/bin/jc fap program.jabara program-generated.asm
cat program-generated.asm jabara/lib/fap-runtime.asm > program.asm
nasm -f bin program.asm -o program.raw
peel/bin/juicer.elf c program.raw program.fap
```

Inside FruityOS, `orgasm f` replaces NASM for the raw FAP assembly step.

## Platform runtimes

`jabara/lib/pith.jabara` declares external Pith services used by applications.
The runtime assembly implements those services for a target:

- `elf-runtime.asm` translates calls to Linux system calls and supplies Linux
  process startup;
- `fap-runtime.asm` translates calls to FruityOS interrupt `0x84`, obtains
  startup arguments from the task page, and exits through Pulp.

The `module` output has no entry wrapper or Pith implementation. Its surrounding
platform must provide every referenced external symbol, including the allocator
when records or captured functions are used.

## Jabara model

All ordinary values occupy one 64-bit word. The language provides named
subroutines, lexical locals, globals, records with compile-time field tags,
captured functions, direct byte and word memory access, control flow, arithmetic,
bitwise operations, and external subroutine declarations.

Binary operators have equal precedence and associate left to right. The
compiler has no optimizer and emits straightforward NASM source intended to be
easy to inspect. See the complete [Jabara language manual](../jabara/docs/manual.md)
for syntax, examples, memory rules, records, and target interfaces.

## Orgasm

Orgasm lives in `jabara/src/orgasm` and is written entirely in Jabara. It is
backward-compatible with the Zest command modes used by FruityOS:

```text
orgasm f input.asm output.bin
orgasm e input.asm output.elf
```

Its lexer, parser, expression evaluator, emitter, and ELF writer support the
directives, registers, address expressions, descriptor data, and x86-64
instructions emitted by `jc` and used by Pulp. Regression tests assemble a FAP
fixture, build Orgasm through its own path, and compare Pulp assembly against
the expected output behavior.

Orgasm is intentionally scoped to FruityOS rather than being a general NASM
replacement. NASM remains necessary for bootstrap and the 16-bit/firmware
sources.

## Yuzu compatibility

Yuzu predates Jabara and remains in `yuzu/` for source and command compatibility.
The current host build produces `yc` and `zest` compatibility tools through the
Jabara build path. New FruityOS sources use `.jabara`; `.yuzu` is retained only
inside the compatibility component.

Orgasm is the maintained Jabara assembler. Zest remains available so existing
Yuzu workflows do not need to change immediately.
