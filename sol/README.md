# Sol

Sol is FruityOS's width-neutral intermediate representation.

Sol is not a processor architecture and does not have a native instruction
encoding. It defines a small machine-like semantic vocabulary that language
frontends can produce and multiple backends can realize.

The intended family is:

```text
Haruka source
    |
    v
Haruka frontend
    |
    v
Sol IR
    |-------------------|-------------------|-------------------|
    v                   v                   v                   v
Mars                Luna                Terra               Pluto
x86-64              x86 real mode       x86 protected mode  native ISA
flat binary         16-bit binary       32-bit binary       native binary
```

Mars is the first concrete Sol backend. It is a flat assembler written in
Jabara: it reads textual Sol and writes raw x86-64 machine code directly. It
does not emit assembly language and it does not invoke Orgasm.

Luna and Terra are planned backends for 16-bit real-mode x86 and 32-bit
protected-mode x86. Pluto is a processor ISA designed to execute Sol semantics
directly.

Jabara remains the existing language and compiler implementation. The future
frontend that targets Sol is a separate language named Haruka. Mars may be
implemented in Jabara without making Jabara itself a Sol frontend.

## Design rules

Sol follows these rules:

- the backend selects the native word width;
- the backend selects the target address width and concrete object layout;
- Sol has no condition flags or implicit comparison state;
- comparisons produce canonical `0` or `1` values;
- `ip` is explicit, readable, and writable;
- arithmetic and logic are expressed with explicit operands;
- byte access is explicit;
- stack and frame operations are defined in abstract target words;
- source-visible semantics may not depend on backend-private registers;
- target containers, firmware entry formats, and operating-system services are
  outside Sol;
- a backend must preserve Sol aliasing and next-instruction semantics even when
  one Sol operation expands to many target instructions.

## Documents

- [Sol semantics and operations](ir.md)
- [Textual Sol syntax](syntax.md)
- [Backend contract](backend-contract.md)
- [Pluto native ISA](pluto.md)
- [Pluto native encoding](pluto-encoding.md)
- [Mars x86-64 backend](mars.md)
- [Luna and Terra](luna-terra.md)
- [Haruka frontend boundary](haruka.md)
- [Migration and repository plan](migration.md)

## Status

Sol version 1 is under active development. The semantic core and the naming
split are intentional. Exact textual conveniences, exceptional behavior,
object-layout helpers, and Pluto opcode assignments are not frozen.

The current priority is to complete and test Mars before using Sol as the
output of a production frontend.
