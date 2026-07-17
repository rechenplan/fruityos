# Orgasm as a Gaia-to-x86-64 backend

Orgasm currently parses x86-like assembly and emits x86-64 bytes. In the Gaia
toolchain, its public input language becomes Gaia assembly. Orgasm remains the
host backend used to build Linux ELF, Windows PE32+, and FruityOS FAP binaries.

```text
Gaia assembly -> parse -> Gaia operations -> x86-64 lowering -> container image
```

The native Gaia assembler shares the source language but replaces only the final
lowering and container stage.

## Visible register mapping

| Gaia | x86-64 |
| --- | --- |
| `a` | `rax` |
| `b` | `rdi` |
| `c` | `rcx` |
| `d` | `rdx` |
| `fp` | `rbp` |
| `sp` | `rsp` |
| `ip` | synthesized from RIP |
| `z` | immediate zero / discarded destination |

Orgasm may use `r8` through `r11` as backend-private temporaries. Gaia code can
never name or observe them. They allow correct lowering of three-operand
operations, arbitrary register aliases, division, large immediates, and writes
to `ip` without expanding Gaia's architectural register file.

## Required lowering behavior

- A read of `z` becomes immediate zero.
- A write to `z` is discarded after preserving required memory accesses or
  arithmetic faults.
- A read of `ip` uses a RIP-relative address of the next Gaia instruction.
- A write to `ip` becomes an x86 control transfer.
- Comparisons use x86 flags internally but immediately materialize `0` or `1`;
  flags are never part of Gaia state.
- `div` and `rem` preserve Gaia-visible operands even though x86 division uses
  `rax` and `rdx` implicitly.
- `ldb` zero extends exactly once.
- `push` of a full 64-bit immediate uses a private temporary when x86 cannot
  encode the value directly.
- `enter` and `ret n` may lower to x86 `enter`/`leave`/`ret n` or equivalent
  sequences, but their semantics are defined by Gaia.

## Example lowering

Gaia:

```text
add d, b, c
```

Possible x86 lowering when no visible operand aliases conflict:

```text
mov rdx, rdi
add rdx, rcx
```

Gaia:

```text
lt a, c, d
```

Possible x86 lowering:

```text
cmp rcx, rdx
setl al
movzx eax, al
```

The x86 sequence is an implementation detail. No x86 flags dependency escapes
the operation.

## Platform boundary

Gaia does not grow x86 opcodes for platform runtime work. Linux `syscall`,
FruityOS `int 0x84`, Windows PE entry details, BIOS operations, UEFI calls,
`lgdt`, `lidt`, `iretq`, and port I/O are not Gaia instructions.

The migration separates code into two classes:

1. ordinary compiler/runtime logic, rewritten as Gaia assembly;
2. irreducible host boundary fragments supplied by the x86 backend as built-in
   runtime primitives, binary templates, or narrowly scoped backend modules.

Gaia programs call a symbol such as `pish_fputch`; they do not know whether the
implementation eventually performs a Linux system call, a Windows ABI call, a
FruityOS interrupt, or a memory-mapped Gaia device write.

## Orgasm source implementation

Orgasm itself is written in Jabara. During transition, the old Jabara compiler
can compile a new Orgasm implementation to x86-64. That transitional Orgasm
must learn Gaia syntax before Jabara switches its emitter.

Once Jabara emits Gaia, the new Orgasm builds all host binaries from Gaia source,
including later versions of itself. The native Gaia assembler can then build the
same programs for the FPGA.
