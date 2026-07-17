# Gaia FPGA implementation profile

The first FPGA implementation should optimize for obvious correctness and
observability, not pipeline depth. Gaia's small state and fixed header make a
multi-cycle single-issue core a good initial target.

## Datapath

The core needs:

- seven stored 64-bit registers (`z` has no storage);
- two register-file read ports and one write port;
- a 64-bit ALU;
- a comparator producing one bit, zero-extended on writeback;
- a shifter using the low six count bits;
- a multiply unit returning the low 64 bits;
- an iterative unsigned divide/remainder unit;
- a byte-addressed memory interface;
- a 16-bit instruction fetch path with extension-parcel collection.

`ip` is register 7 in the same architectural namespace. Fetch reads it, advances
it past the complete instruction, and writes that advanced value before execute.
An instruction targeting `ip` overwrites the fall-through value during
writeback.

## Suggested execution states

A small controller can begin with:

```text
FETCH_HEADER
FETCH_EXTENSION
READ_OPERANDS
EXECUTE
MEMORY
WRITEBACK
```

Register-only ALU instructions can complete without the MEMORY state. Loads,
stores, multiply, divide, unaligned accesses, and stack/frame operations may use
additional cycles.

## Memory bus

A minimal bus request contains:

```text
address[63:0]
write_data[63:0]
byte_enable[7:0]
read / write
valid
```

The response contains `read_data`, `ready`, and `fault`. Byte enables permit
`stb` without a read-modify-write cycle when the attached memory supports them.
Unaligned word accesses may be split into two aligned bus transactions.

Code and data share the bus in v0. A Harvard cache split can be added later
without changing architectural semantics.

## Memory-mapped devices

The native Gaia profile should begin with polling and memory-mapped devices:

- console output register;
- console input/status register;
- monotonic timer;
- block-device command/data window;
- optional debug-exit register for simulation.

Jabara programs still call Pith runtime functions. Those functions perform the
memory accesses, so device addresses do not leak into ordinary generated code.

## Reset

At reset:

- `z` reads zero;
- `ip` is loaded from an implementation parameter or reset-vector input;
- `a`, `b`, `c`, `d`, `fp`, and `sp` are zeroed in the reference profile;
- instruction fetch begins at `ip`.

A boot ROM may set `sp`, initialize RAM, and call the first Gaia program. The
reset behavior is intentionally deterministic for simulation and formal tests.

## Faults in v0

The first implementation may stop in a visible fault state on:

- reserved opcode or mode;
- divide by zero;
- memory bus fault;
- malformed instruction extension.

The fault state should expose the current instruction address, header parcel,
and operands to the testbench. A later trap profile can define software-visible
vectors. We should not reserve hidden architectural registers prematurely.

## Reference model

Before RTL, implement a tiny interpreter with exactly the documented sequence:

1. save the instruction address;
2. fetch the header and extensions;
3. set `ip` to the next instruction;
4. capture source operands;
5. execute the operation;
6. perform memory effects;
7. commit destination writes, with `z` discarded and `ip` controlling flow.

The emulator should emit an optional trace containing:

```text
cycle, old_ip, parcels, opcode, operands, memory effect, register write, new_ip
```

The RTL testbench can consume the same binaries and compare committed states.

## First milestones

1. `mov`, `add`, `sub`, `and`, `or`, `xor`, comparisons, and `jmp`.
2. `ld`, `st`, `ldb`, and `stb` against block RAM.
3. `push`, `pop`, `call`, `enter`, and `ret` running a recursive function.
4. shifts, multiply, divide, and remainder.
5. a Gaia-assembled Jabara hello-world program using a memory-mapped console.
6. JBC or Pish under the reference emulator.
7. the same binary on FPGA.

## Measurements to collect

The assembler and emulator should report:

- instruction frequency;
- parcels per instruction;
- immediate-width distribution;
- branch displacement distribution;
- load/store displacement distribution;
- cycles per opcode;
- code size compared with Orgasm x86-64 output.

Those measurements should drive any v1 compressed forms. The ISA should not gain
special cases based on intuition alone.
