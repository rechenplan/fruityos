# Gaia architecture

## Machine state

Gaia has exactly eight 64-bit registers.

| Number | Name | Conventional role |
| ---: | --- | --- |
| 0 | `z` | hardwired zero |
| 1 | `a` | expression result and function return value |
| 2 | `b` | general temporary |
| 3 | `c` | general temporary and closure environment |
| 4 | `d` | general temporary and division scratch |
| 5 | `fp` | frame pointer |
| 6 | `sp` | stack pointer |
| 7 | `ip` | instruction pointer |

The roles of `a` through `d` are conventions, not hardware restrictions. Every
instruction that accepts a register accepts any of the eight register numbers,
subject only to the special behavior of `z` and `ip`.

Reading `z` returns zero. Writing `z` discards the value. Operations targeting
`z` still perform architecturally visible memory accesses and faults.

`ip` is not hidden state. During execution it contains the address immediately
after the complete current instruction, including all immediate extension
parcels. Reading `ip` therefore yields the natural PC-relative base. Writing
`ip` transfers control. If an instruction does not write `ip`, execution
continues at the value already placed there by fetch.

There is no flags register. Arithmetic does not leave hidden condition state.
Comparisons produce canonical Boolean values: zero or one.

## Values and memory

A Gaia word is 64 bits. Integer arithmetic wraps modulo 2^64 unless otherwise
specified. Signed comparisons interpret words as two's-complement integers.
Division and remainder are unsigned, matching the operation currently emitted
by Jabara.

Memory is byte addressed and little endian. The architectural address space is
64 bits. Byte loads zero extend. Byte stores write the low eight bits of the
source. Unaligned 64-bit loads and stores are architecturally valid, although a
small FPGA implementation may execute them over multiple bus cycles.

Gaia has one memory space. Code, globals, heap objects, stacks, and memory-mapped
peripherals share it. The v0 core has no separate port-I/O instructions.

## Operand model

The regular three-operand form is:

```text
op destination, left, right
```

`left` is a register. `right` is a register or an immediate. The native encoding
has one register/immediate operand position, which keeps the common instruction
at one 16-bit parcel while preserving non-destructive three-operand operations.

Every instruction captures all explicit source registers and the fall-through
`ip` before committing any architectural register write. Register aliasing is
therefore deterministic: `add a, a, a`, `ld ip, [ip + 0]`, and operations whose
destination equals a source do not depend on implementation ordering.

Memory operations use:

```text
ld   destination, [base + offset]
ldb  destination, [base + offset]
st   [base + offset], source
stb  [base + offset], source
```

`base` is a register. `offset` is a register or immediate. A direct symbol is
represented as `ip` plus a linker-computed relative displacement.

## Instructions

### Data movement

| Instruction | Semantics |
| --- | --- |
| `mov r, x` | `r = x` |
| `ld r, [p + x]` | `r = mem64[p + x]` |
| `ldb r, [p + x]` | `r = zero_extend(mem8[p + x])` |
| `st [p + x], r` | `mem64[p + x] = r` |
| `stb [p + x], r` | `mem8[p + x] = low8(r)` |

`mov z, x` discards `x`. Loads to `z` still access memory. Stores read all source
registers before modifying memory.

### Arithmetic and logic

| Instruction | Semantics |
| --- | --- |
| `add r, x, y` | `r = x + y` |
| `sub r, x, y` | `r = x - y` |
| `mul r, x, y` | `r = low64(x * y)` |
| `div r, x, y` | `r = unsigned(x) / unsigned(y)` |
| `rem r, x, y` | `r = unsigned(x) % unsigned(y)` |
| `and r, x, y` | `r = x & y` |
| `or r, x, y` | `r = x | y` |
| `xor r, x, y` | `r = x ^ y` |
| `shl r, x, y` | `r = x << low6(y)` |
| `shr r, x, y` | `r = unsigned(x) >> low6(y)` |

Negation and complement do not need architectural opcodes:

```text
sub r, z, x       ; -x
xor r, x, -1      ; ~x
```

### Comparisons

| Instruction | Result |
| --- | --- |
| `eq r, x, y` | `x == y` |
| `ne r, x, y` | `x != y` |
| `lt r, x, y` | signed `x < y` |
| `le r, x, y` | signed `x <= y` |
| `gt r, x, y` | signed `x > y` |
| `ge r, x, y` | signed `x >= y` |

Every comparison writes exactly `0` or `1`. There is no later instruction that
consumes implicit comparison state.

### Branch and call

The encoded control-transfer target is always `base + offset`.

| Instruction | Semantics |
| --- | --- |
| `bz r, base + off` | if `r == 0`, set `ip = base + off` |
| `bnz r, base + off` | if `r != 0`, set `ip = base + off` |
| `jmp base + off` | set `ip = base + off` |
| `call base + off` | push current `ip`; set `ip = base + off` |
| `ret n` | restore the caller frame and discard `n` argument bytes |

For direct branches and calls, assembly normally uses a label. The assembler
encodes the target as `ip + relative_displacement`. For an indirect transfer it
uses a register base and zero offset.

`call` captures all operands before decrementing `sp`. Its exact operation is:

```text
next = ip
sp = sp - 8
mem64[sp] = next
ip = target
```

`ret n` combines the current Jabara `leave` and callee-cleaning return:

```text
sp = fp
fp = mem64[sp]
sp = sp + 8
ip = mem64[sp]
sp = sp + 8 + n
```

### Stack and frame

| Instruction | Semantics |
| --- | --- |
| `push x` | decrement `sp` by 8 and store `x` |
| `pop r` | load a word from `sp` and increment `sp` by 8 |
| `enter n` | push `fp`, set `fp = sp`, then subtract `n` from `sp` |

Sources are captured before implicit stack updates. The explicit destination of
`pop` is written after the implicit increment, so `pop sp` loads the popped
value into `sp`. `push sp` pushes the pre-decrement value.

## Deliberately absent

The v0 ISA has no architectural equivalent of:

- x86 condition flags or `setcc`;
- partial registers such as `al`, `eax`, or `cl`;
- `lea` as a separate arithmetic mechanism;
- implicit multiply or divide registers;
- system calls, software interrupts, port I/O, descriptor tables, or privilege
  instructions;
- floating point or vector registers;
- atomic read-modify-write instructions;
- string instructions;
- a hidden link register or hidden instruction pointer.

Platform services are ordinary callable runtime symbols. Native Gaia devices
are accessed through memory. An interrupt/trap profile may be designed later,
but it is not allowed to distort the compiler core before it is needed.
