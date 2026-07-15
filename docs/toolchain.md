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

Both compilers expose one implicit module compilation interface and accept one
or more source files:

```text
jc input.jabara [input.jabara ...] output.asm
```

Inputs are parsed in command-line order. The output is headerless, origin-free
assembly; selected assembly headers and runtimes determine the executable
format during assembly.

An ELF build looks like:

```sh
jabara/bin/jc program.jabara program-generated.asm
cat jabara/lib/elf-header.asm program-generated.asm \
    jabara/lib/elf-runtime.asm > program.asm
nasm -f bin program.asm -o program
chmod +x program
```

A FruityOS application follows the same separation:

```sh
jabara/bin/jc jabara/lib/pith.jabara program.jabara program-generated.asm
cat jabara/lib/fap-stack-runtime.asm jabara/lib/fap-runtime.asm \
    program-generated.asm > program.asm
nasm -f bin program.asm -o program.raw
peel/bin/juicer.elf c program.raw program.fap
```

Inside FruityOS, Orgasm accepts those assembly files directly, so no combined
temporary assembly file is needed.

## Platform runtimes

`jabara/lib/pith.jabara` declares external Pith services used by applications.
The runtime assembly implements those services for a target:

- `elf-header.asm` supplies the manual ELF64 header, origin, and entry point;
- `elf-runtime.asm` translates calls to Linux system calls and supplies the
  allocator and end marker;
- `fap-runtime.asm` translates calls to FruityOS interrupt `0x84`, obtains
  startup arguments from the task page, and exits through Pulp.

Compiler output has no entry wrapper, origin, or Pith implementation. Its surrounding
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

Orgasm lives in `jabara/src/orgasm` and is written entirely in Jabara. It has no
output modes and accepts one or more assembly inputs:

```text
orgasm input.asm [input.asm ...] output
```

Inputs share one symbol table and are assembled in command-line order. Only
`org` changes the address; ELF files require a manual assembly header such as
`elf-header.asm`. Its lexer, parser, expression evaluator, and emitter support
the directives, registers, address expressions, descriptor data, and x86-64
instructions emitted by `jc` and used by Pulp.

Orgasm is intentionally scoped to FruityOS rather than being a general NASM
replacement. NASM remains necessary only to bootstrap Orgasm and assemble the
Seed bootloader and firmware sources.

## Yuzu compatibility

Yuzu predates Jabara and remains in `yuzu/` for source and command compatibility.
The current host build produces `yc` and `zest` compatibility tools through the
Jabara build path. New FruityOS sources use `.jabara`; `.yuzu` is retained only
inside the compatibility component.

Orgasm is the maintained Jabara assembler. Zest remains available so existing
Yuzu workflows do not need to change immediately.
