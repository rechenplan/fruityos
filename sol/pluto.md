# Pluto

Pluto is a processor instruction set designed to execute Sol semantics directly.

Sol is the IR; Pluto is one concrete machine realization. This separation is
important: Sol remains width-neutral and encoding-neutral, while Pluto chooses a
register width, instruction encoding, reset behavior, memory interface, and
fault model.

## Architectural correspondence

The first Pluto profile retains Sol's eight visible registers:

```text
z  a  b  c  d  fp  sp  ip
```

`z` is hardwired to zero. `ip` is an ordinary visible register whose
fall-through value is established before execution. Comparisons write `0` or
`1`; there is no condition-code register.

The initial reference profile is expected to use 64-bit words, but that is a
Pluto profile decision, not a property of Sol.

## Core operations

Pluto should directly support the Sol core where doing so keeps the machine
regular:

- word and byte load/store;
- three-operand arithmetic and logic;
- canonical comparisons;
- Boolean branches;
- direct/indirect jump and call;
- stack and frame operations;
- explicit readable/writable `ip`.

Pseudo-operations such as `neg`, `not`, `bool`, `addr`, and `nop` do not require
separate architectural opcodes.

## Implementation direction

The first FPGA implementation should prioritize observability and correctness:

- a small register file;
- a simple ALU and comparator;
- iterative multiply/divide if appropriate;
- a byte-addressed memory interface;
- a multi-cycle single-issue controller;
- deterministic reset state;
- a visible fault/debug state;
- a reference interpreter used as the architectural oracle.

A possible controller begins with:

```text
FETCH_HEADER
FETCH_EXTENSION
READ_OPERANDS
EXECUTE
MEMORY
WRITEBACK
```

The exact stages are not architectural.

## Memory and devices

The reference profile may use one shared code/data address space and
memory-mapped devices. Console, timer, block storage, and debug exit can begin as
simple polling registers.

Ordinary Sol programs should call runtime symbols rather than hard-code device
addresses. That keeps source portable between Pluto and the x86 backends.

## Faults

The first profile may stop in a visible fault state on:

- reserved encodings;
- malformed extension parcels;
- divide by zero;
- memory bus faults.

A later trap profile may make faults software-visible. Sol does not require a
particular trap mechanism.

## Reference validation

The interpreter and RTL should commit state in this order:

1. save the current instruction address;
2. fetch and decode the complete instruction;
3. establish fall-through `ip`;
4. capture explicit source operands;
5. execute the operation;
6. perform memory effects;
7. commit the destination, discarding writes to `z` and honoring writes to
   `ip`.

The same Pluto binary should run under the reference interpreter and FPGA
simulation with matching committed state.
