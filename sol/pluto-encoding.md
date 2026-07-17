# Pluto native encoding draft

This document describes a candidate encoding for the first Pluto profile. It is
not part of Sol and is not frozen.

## Parcels

Pluto code is a stream of little-endian 16-bit parcels. Every instruction begins
with one header parcel. Register-only and tiny-immediate operations occupy one
parcel; larger immediates append extension parcels.

A candidate header is:

```text
15            11 10       8 7        5 4        2 1      0
+---------------+-----------+----------+----------+--------+
|    opcode     |     d     |    a     |    b     |  mode  |
+---------------+-----------+----------+----------+--------+
      5 bits        3 bits      3 bits     3 bits    2 bits
```

The three-bit register fields naturally name Pluto's eight visible registers.
Unused fields must be zero in canonical output.

## Candidate right-operand modes

| Mode | Meaning | Total length |
| ---: | --- | ---: |
| `00` | `b` names a register | 16 bits |
| `01` | signed three-bit immediate | 16 bits |
| `10` | signed 16-bit extension | 32 bits |
| `11`, `b=0` | signed 32-bit extension | 48 bits |
| `11`, `b=1` | full profile-word immediate | profile-dependent |
| `11`, other `b` | reserved | — |

Extension parcels are least-significant parcel first. The assembler chooses the
shortest representation that preserves the resolved value.

## Why this encoding belongs to Pluto

Parcel size, immediate lengths, opcode numbers, and profile-word width are
processor choices. They must not appear in Sol's semantic definition. Mars,
Luna, and Terra encode the same Sol operations using x86 instruction bytes
instead.

## Open questions

The first implementation must still settle:

- final opcode assignment;
- whether stack/frame operations deserve dedicated encodings;
- direct branch displacement forms;
- full-word immediate encoding in non-64-bit Pluto profiles;
- alignment requirements;
- malformed instruction behavior;
- whether any common operation merits a fused encoding after measurement.

No compressed form should be added solely by intuition. Code-frequency and
immediate-width measurements from Mars and Haruka-generated Sol should guide the
final choices.
