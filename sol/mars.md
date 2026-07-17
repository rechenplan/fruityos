# Mars

Mars is the Sol backend for x86-64.

It is a flat assembler written in Jabara. Mars reads textual Sol, lays out the
program, lowers each operation directly to x86-64 machine code, resolves
symbols, and writes a raw binary file.

Mars does not emit x86 assembly. It does not invoke Orgasm. It does not build an
ELF, PE32+, FAP, or other executable container.

## Command shape

The command-line forms are:

```text
mars input.sol [...] output
mars -o ORIGIN input.sol [...] output
mars -o ORIGIN -M output.map input.sol [...]
```

Input files form one logical Sol stream in command-line order. The output is one
flat binary image. `org` normally supplies the target address assigned to its
first byte; `-o` provides an implicit origin for streams intended to be placed
by an image builder. `-M` performs layout only and writes exported symbols as
`name equ address`. Layout-only mode permits declared externals to remain
unresolved so another flat region can be assembled before the final Mars pass.

## Target profile

Mars selects:

```text
word_bits      = 64
word_bytes     = 8
address_bits   = 64
byte_order     = little endian
instruction set = x86-64
output         = raw flat binary
```

## Visible register realization

The intended visible mapping is:

| Sol | x86-64 realization |
| --- | --- |
| `a` | `rax` |
| `b` | `rbx` |
| `c` | `rcx` |
| `d` | `rdx` |
| `fp` | `rbp` |
| `sp` | `rsp` |
| `ip` | synthesized from target addresses / RIP |
| `z` | immediate zero or discarded destination |

Mars may use `r8` through `r11` and other unavailable x86 state as
backend-private temporaries. Sol code cannot name or observe them.

## Correct lowering requirements

Mars must handle x86 irregularities internally:

- x86 flags may implement comparisons, but a Sol comparison immediately
  materializes `0` or `1`;
- x86's implicit divide registers must not corrupt visible Sol operands;
- large immediates may require private registers;
- three-operand Sol operations may require moves and alias-safe sequencing;
- a write to `z` discards the result without suppressing required effects;
- a read of `ip` yields the target address of the next Sol operation;
- a write to `ip` becomes a control transfer;
- `ldb` zero-extends exactly once;
- direct branches and calls must diagnose unrepresentable displacements.

## Flat-image behavior

Mars emits only the bytes described by Sol instructions and data directives.
It does not choose an entry point, initialize a process, or provide a stack.
The surrounding loader or image builder is responsible for placing the bytes at
the declared origin and transferring control appropriately.

An `extern` is a declaration across the logical input set. A definition in a
later input file satisfies it. Any external still unresolved after layout
cannot be represented in the final flat image, so Mars rejects it rather than
emitting a silent placeholder.

## Implementation structure

Mars is implemented in Jabara using records and closures. The preferred style
is callback-oriented and lazy:

- input files are cached once so both passes see identical bytes;
- parsing produces one logical item at a time;
- layout and emission are separate logical passes;
- source may be reparsed rather than retaining every parsed instruction;
- only source buffers, symbols, and other truly persistent state need survive a
  whole assembly;
- encoder callbacks write bytes directly to the output stream.

This avoids constructing a permanent AST for a flat assembler while retaining
clear record-based parser and encoder state.

## Current semantic test target

Mars should be considered usable only after executable or model-based tests
cover:

- arithmetic and Boolean comparisons;
- unsigned divide and remainder;
- shifts;
- direct and indirect control flow;
- `ip` reads and writes;
- stack and frame operations;
- word and byte memory access;
- register aliasing;
- origin-sensitive labels;
- multi-file input;
- large sources without allocation proportional to instruction count.

## Relationship to Orgasm and Peel

Mars does not invoke Orgasm and does not emit assembly. They remain separate
flat-image tools.

Pulp uses both: Haruka/Mars produce the generated region, Orgasm produces the
handwritten region, and textual absolute-symbol maps resolve calls in both
directions. Peel continues to use Orgasm through its existing build path and is
not modified by the Sol project.

## Word-scaled constants

Mars resolves a Sol word-scaled literal `nw` as `n * 8` before lowering. For
example, `2w` has the value `16` under the Mars target profile.
