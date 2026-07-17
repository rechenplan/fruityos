# Gaia

Gaia is the future canonical machine language of Jabara and the proposed native
processor architecture for FruityOS on FPGA.

Gaia is not an x86-64 compatibility layer. It is the small, regular machine that
remains after removing the x86 accidents from the code Jabara currently emits:
partial registers, condition flags, implicit operands, REX prefixes, ModR/M,
variable instruction forms, and a hidden instruction pointer.

The intended toolchain is:

```text
Jabara source
    |
    v
Jabara compiler
    |
    v
Gaia assembly
    |-----------------------------|
    v                             v
Orgasm                         Gaia assembler
Gaia -> x86-64                Gaia -> native Gaia code
    |                             |
    v                             v
ELF / PE32+ / FAP             FPGA image / Gaia executable
```

Jabara will emit Gaia assembly directly. Orgasm will cease to be an x86
assembler at its source-language boundary; it will become a Gaia-to-x86-64
backend. A separate Gaia assembler will encode the same source into the compact
native instruction stream executed by the FPGA.

## Design rules

Gaia begins with the operations required by Jabara-generated programs. It does
not absorb every x86 instruction currently present in handwritten assembly.
Instead, handwritten Orgasm sources will be rewritten in Gaia, platform
services will be called through runtime symbols, and native Gaia devices will be
memory mapped.

The architectural rules are:

- exactly eight 64-bit registers;
- `z` is hardwired to zero;
- `ip` is an ordinary readable and writable architectural register;
- no condition-code register;
- comparisons write `0` or `1` to a register;
- byte-addressed, little-endian memory;
- explicit byte and 64-bit loads and stores;
- three-operand arithmetic and logic;
- a downward-growing stack compatible with the current Jabara ABI;
- compact 16-bit base instructions with immediate extension parcels;
- no floating point, SIMD, atomics, string engine, segmentation, or x86
  privilege machinery in the core ISA.

## Documents

- [Architecture and instruction semantics](isa.md)
- [Assembly language](assembly.md)
- [Native encoding](encoding.md)
- [Jabara ABI](abi.md)
- [Jabara emitter conversion](jabara.md)
- [Orgasm x86-64 backend](orgasm.md)
- [Repository migration](migration.md)
- [FPGA implementation profile](fpga.md)

## Status

This directory is a design draft. The architectural direction is intentional,
but opcode assignments, exceptional behavior, and the executable container are
not frozen. We should change them aggressively while the first assembler and
FPGA core are being developed.
