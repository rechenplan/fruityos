# Sol backend contract

A Sol backend realizes the abstract operations in [ir.md](ir.md) for one target
profile. It is responsible for target selection, layout, lowering, relocation,
and final binary emission.

## Required target parameters

A backend must define:

| Parameter | Meaning |
| --- | --- |
| `word_bits` | width of a Sol word on this target |
| `word_bytes` | storage size of a Sol word |
| `address_bits` | target address width |
| `byte_order` | layout of word loads, stores, and `word` data |
| `stack_alignment` | alignment required at externally visible boundaries |
| `register realization` | mapping or storage strategy for Sol registers |
| `image model` | origin, relocation limits, and output container |
| `fault model` | divide-by-zero, bad memory, and unsupported operations |

Sol itself does not choose these values.

## Semantic preservation

A correct backend must preserve:

- target-width wraparound;
- signed comparison and unsigned division semantics;
- canonical Boolean results;
- source-register capture before destination writes;
- `z` reads and discarded writes;
- exact byte access;
- word-width stack movement;
- next-Sol-instruction `ip` semantics;
- direct and indirect control flow;
- label and data addresses after final layout.

Backend-private instructions, flags, registers, and temporary stack locations
must not become observable Sol state.

## Lowering one operation to many

A backend may lower one Sol operation to any target sequence. The sequence must
behave atomically at the Sol semantic boundary with respect to register
aliasing.

For example, an x86 backend may need private registers to lower:

```text
add d, b, c
```

or to preserve visible operands around x86's implicit divide registers. It must
also synthesize a stable value for reads of `ip`: that value is the address of
the next Sol operation, not merely the next native instruction in the sequence.

## Layout and relocation

A flat backend normally performs at least two logical passes:

1. determine the target size and address of every item;
2. emit bytes and resolve references using the completed layout.

A backend may parse lazily, reparse source, memoize items, or use another
strategy. These are implementation choices. The observable requirements are
stable layout and deterministic output.

A backend must diagnose a reference that cannot be represented in the target
form rather than silently truncate it.

## Data

`word` is target-sized. `db`, `dw`, `dd`, and `dq` are explicit-width layout
operations. A backend may reject an explicit width that its image model cannot
represent, but must not silently reinterpret it as a target word.

Alignment is expressed in bytes unless a future syntax explicitly introduces a
word-alignment form.

## Containers and linking

Sol does not require a particular executable container.

A backend may emit:

- a raw flat image;
- a target-native object;
- an executable container;
- a ROM image;
- an in-memory image for immediate execution.

Mars emits a raw flat image. Container construction, if desired, is a separate
step.

## Platform boundary

System calls, firmware calls, descriptor-table operations, interrupt returns,
and device-specific operations are not portable Sol operations. A complete
program reaches them through target runtime symbols or backend-specific boundary
modules.

A backend must not enlarge Sol's core merely to mirror incidental features of
its target architecture.

## Conformance testing

Each backend should run a shared semantic suite covering:

- every arithmetic and logical operation;
- all six comparisons;
- aliasing between every destination and source position;
- large, negative, and boundary immediates;
- direct and indirect calls and jumps;
- `ip` reads and writes;
- stack operations involving `sp` and `fp`;
- byte and word memory access;
- origin-sensitive labels and data;
- divide and remainder edge cases;
- multi-file symbol resolution.

Tests should compare observable Sol state, memory effects, and output bytes where
backend encoding is part of the contract.
