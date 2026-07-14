# Jabara

Jabara is a compact 64-bit systems language designed to be self-hosting. It
has word-sized values, direct memory access, subroutines, records, and lexical
closures. The compiler produces one NASM source file; it never invokes NASM or
Juicer itself.

## Compilers

Jabara has two compilers with the same command-line interface:

- `bin/jbc` is the small ANSI C bootstrap compiler in `src/jbc`.
- `bin/jc` is the compiler written in Jabara in `src/jc`.
- `bin/jc-self` is a second build of `jc`, compiled by `jc` itself.

Build all three from this directory:

```sh
./build.sh
```

The compiler interface is:

```text
jc elf|fap|module input.jabara output.asm
```

The output is assembly, not an assembled executable. Choose a format according
to where the result will be loaded:

| Format | Origin | Generated prefix | Runtime | `main` required |
| --- | ---: | --- | --- | --- |
| `elf` | `0x400000` | Minimal ELF64 header | `lib/elf-runtime.asm` | Yes |
| `fap` | `0x801000` | FruityOS entry jump | `lib/fap-runtime.asm` | Yes |
| `module` | Set by surrounding assembly | Headerless | Supplied by platform | No |

For example, build a Linux executable like this:

```sh
bin/jc elf program.jabara program-generated.asm
cat program-generated.asm lib/elf-runtime.asm > program.asm
nasm -f bin program.asm -o program
chmod +x program
```

Build an uncompressed FruityOS application image like this:

```sh
bin/jc fap program.jabara program-generated.asm
cat program-generated.asm lib/fap-runtime.asm > program.asm
nasm -f bin program.asm -o program.raw
```

`program.raw` has the correct FruityOS origin and ABI. Juicer can turn it into
a normal compressed FAP file:

```sh
../peel/bin/juicer.elf c program.raw program.fap
```

The runtimes are ordinary assembly sources intentionally kept outside the
compiler. The selected format changes the generated origin and prefix; it does
not make the compiler call an assembler or embed a target runtime.

`module` is for code incorporated into a larger assembly program, such as the
FruityOS kernel. It uses stack-backed subroutine environments and emits neither
a header nor a runtime. Records and closures still call `__jabara_alloc`, so a
module using either feature must receive that symbol from its platform.
Because ordinary module subroutines keep their environments on the stack, a
closure that captures one of their locals must not outlive that subroutine.

## Language at a glance

All ordinary values are 64-bit words. An untagged variable is always a word;
there is no dynamic descriptor or runtime type path.

```jabara
record Node value, next:Node

sub total(node:Node)
  local result = 0
  while node != 0 do
    result = result + node.value
    node = node.next
  end
  return result
end
```

A record declaration is a comma-separated list with no closing `end` and no
newline terminator. `Node()` allocates a zero-filled record. A `:Node` tag on a
local, parameter, global, or record field supplies compile-time field-layout
information. Tags do not add runtime checks or change a word's representation.

Closures use `fn` and capture lexical variables:

```jabara
local make_adder
make_adder = fn amount do
  return fn value do
    return value + amount
  end
end
```

Other important rules:

- Declare variables with `local`; the removed `var` spelling is an error.
- Create closures with `fn`; the removed `lambda` spelling is an error.
- Named `sub` routines are direct-call only. Wrap a call in `fn` to make a
  callable value.
- Direct subroutines and calls accept at most six arguments. Each `fn` accepts
  one; a multi-argument closure call applies a chain of closures.
- All binary operators have equal precedence and associate left to right.
- `&&` and `||` evaluate both sides.
- `extern sub name(parameters)` declares an implementation supplied by linked
  assembly. `lib/pith.jabara` contains the standard Pith declarations.
- Program-scope locals are global words. Program-scope executable statements
  run at the start of `main` in executable targets.

The complete, beginner-oriented language guide is in
[`docs/manual.md`](docs/manual.md).

## Repository layout

```text
jabara/
  src/jbc/             ANSI C bootstrap compiler
  src/jc/              self-hosted Jabara compiler
  lib/pith.jabara      standard external declarations
  lib/elf-runtime.asm  Linux startup and Pith system calls
  lib/fap-runtime.asm  FruityOS startup and Pith system calls
  tests/               language and diagnostic tests
  docs/manual.md       programming tutorial and reference
```

## Testing

Run the complete suite with:

```sh
./test.sh
```

It checks the bootstrap and self-hosted compilers, records, closures,
diagnostics, ELF and FAP generation, Juicer round-tripping when available, and
the retained Yuzu compatibility path. It also compiles every Peel program with
the self-hosted compiler and leaves the Linux executables in the repository's
top-level `bin/` directory.

A C compiler and NASM are needed to build Jabara. The complete compatibility
tests also use the repository's Yuzu and Peel tools.
