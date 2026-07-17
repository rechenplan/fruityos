# Gaia native encoding

Gaia code is a stream of little-endian 16-bit parcels. Every instruction begins
with one header parcel. Register-only and tiny-immediate instructions occupy one
parcel. Larger immediates append one, two, or four parcels.

This is a compact fixed-header design rather than an x86-style byte grammar.
The first parcel identifies the entire operation and the length of any extension.

## Header

```text
15            11 10       8 7        5 4        2 1      0
+---------------+-----------+----------+----------+--------+
|    opcode     |     d     |    a     |    b     |  mode  |
+---------------+-----------+----------+----------+--------+
      5 bits        3 bits      3 bits     3 bits    2 bits
```

The eight register numbers are the architectural register numbers in
[isa.md](isa.md). `d`, `a`, and `b` retain their positions for every opcode.
Unused fields must be zero in canonical output.

## Right-operand modes

The `mode` field determines how the right operand is obtained.

| Mode | Meaning | Length |
| ---: | --- | ---: |
| `00` | `b` names a register | 16 bits |
| `01` | `b` is a signed three-bit immediate, -4 through 3 | 16 bits |
| `10` | next parcel is a signed 16-bit immediate | 32 bits |
| `11`, `b=0` | next two parcels are a signed 32-bit immediate | 48 bits |
| `11`, `b=1` | next four parcels are the full 64-bit immediate | 80 bits |
| `11`, other `b` | reserved | — |

Extension parcels are stored least-significant parcel first. Signed 3-, 16-, and
32-bit immediates are sign extended to 64 bits. The 64-bit form is not extended.

The assembler always chooses the shortest representation that preserves the
value after relocation. Small constants, zero-register operations, register
arithmetic, and most stack traffic therefore remain two bytes. Position-
independent calls and branches usually use a 16- or 32-bit displacement.

## Opcode map

| Code | Mnemonic | Fields |
| ---: | --- | --- |
| 0 | `mov` | `d = right` |
| 1 | `add` | `d = a + right` |
| 2 | `sub` | `d = a - right` |
| 3 | `mul` | `d = low64(a * right)` |
| 4 | `div` | `d = unsigned(a) / unsigned(right)` |
| 5 | `rem` | `d = unsigned(a) % unsigned(right)` |
| 6 | `and` | `d = a & right` |
| 7 | `or` | `d = a | right` |
| 8 | `xor` | `d = a ^ right` |
| 9 | `shl` | `d = a << low6(right)` |
| 10 | `shr` | `d = unsigned(a) >> low6(right)` |
| 11 | `eq` | `d = a == right` |
| 12 | `ne` | `d = a != right` |
| 13 | `lt` | `d = signed(a) < signed(right)` |
| 14 | `le` | `d = signed(a) <= signed(right)` |
| 15 | `gt` | `d = signed(a) > signed(right)` |
| 16 | `ge` | `d = signed(a) >= signed(right)` |
| 17 | `ld` | `d = mem64[a + right]` |
| 18 | `ldb` | `d = zero_extend(mem8[a + right])` |
| 19 | `st` | `mem64[a + right] = d` |
| 20 | `stb` | `mem8[a + right] = low8(d)` |
| 21 | `bz` | branch on `d == 0` to `a + right` |
| 22 | `bnz` | branch on `d != 0` to `a + right` |
| 23 | `jmp` | transfer to `a + right` |
| 24 | `call` | push `ip`, transfer to `a + right` |
| 25 | `ret` | return and discard `right` bytes |
| 26 | `push` | push `right` |
| 27 | `pop` | pop into `d` |
| 28 | `enter` | establish a frame with `right` local bytes |
| 29–30 | reserved | — |
| 31 | escape | reserved for a future extension parcel |

The opcode map is deliberately contiguous and boring. FPGA decode can use the
five-bit value directly without reproducing an x86 instruction classifier.

## Field use by class

```text
mov  d, right            d used; a ignored
alu  d, a, right         d, a, right used
ld   d, [a + right]      d, a, right used
st   [a + right], d      d, a, right used
bz   d, a + right        d is condition; a/right form target
jmp  a + right           a/right form target; d ignored
call a + right           a/right form target; d ignored
ret  right               only right used
push right               only right used
pop  d                   only d used
enter right              only right used
```

## Labels and `ip`

At execute time, `ip` already points after the entire instruction. A direct
label operand is therefore relocated as:

```text
displacement = symbol_address - next_instruction_address
```

For example:

```text
call worker
```

encodes the `call` opcode with `a = ip` and `right = displacement(worker)`.
An indirect call through `a` encodes `a = a` and `right = z`.

## Canonical no-op

Gaia needs no dedicated no-op opcode:

```text
mov z, z
```

is the canonical one-parcel no-op.

## Open encoding questions

Before freezing v1 we should measure real Jabara output and decide whether:

- the signed inline range should remain -4 through 3 or use a biased mapping
  optimized for 0, 1, 8, and -1;
- a scaled stack/frame displacement form would save enough code to justify a
  second memory encoding;
- calls and branches deserve a dedicated one-parcel short displacement;
- `enter` and `ret n` remain hardware instructions or become fused decoder
  micro-operations;
- the escape opcode should introduce multiplication-high, traps, interrupts, or
  debugging facilities.

The first Gaia assembler should collect instruction and immediate histograms so
these choices are driven by actual compiler output.
