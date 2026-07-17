# Sol intermediate representation

Sol describes machine-level dataflow and control flow without selecting a
physical instruction encoding or native word width.

A Sol backend chooses a target profile. The profile supplies at least:

```text
word_bits
word_bytes
address_bits
byte_order
stack_alignment
image_origin
```

Mars selects a 64-bit little-endian x86-64 profile. Luna will select a 16-bit
little-endian real-mode profile. Terra will select a 32-bit little-endian
protected-mode profile. Pluto defines its own concrete profile.

## Machine state

Sol exposes eight abstract registers:

| Name | Conventional role |
| --- | --- |
| `z` | constant zero and discarded destination |
| `a` | expression result and function return value |
| `b` | general temporary |
| `c` | general temporary / environment |
| `d` | general temporary / arithmetic scratch |
| `fp` | frame pointer |
| `sp` | stack pointer |
| `ip` | instruction pointer |

The roles of `a` through `d` are conventions. A backend may map them to native
registers, memory locations, or a mixture, but Sol code observes only their Sol
values.

Reading `z` returns zero. Writing `z` discards the result. An operation whose
destination is `z` still performs required memory accesses and target-defined
faults.

`ip` contains the target address corresponding to the next Sol instruction.
The address is defined after the complete current Sol operation, not after an
arbitrary target instruction used to lower it. Reading `ip` therefore provides
a stable relative-address base. Writing `ip` transfers control.

There is no flags register. Comparisons write exactly `0` or `1`.

## Words and arithmetic

A Sol word has the width selected by the backend profile. Let that width be
`W` bits.

- ordinary arithmetic wraps modulo `2^W`;
- signed comparisons interpret words as two's-complement `W`-bit integers;
- `div` and `rem` are unsigned;
- `mul` returns the low `W` bits;
- shifts use the low `log2(W)` count bits for power-of-two target widths;
- immediate values are reduced or sign-extended according to the operation and
  backend profile.

Sol source that depends on overflow, sign, or shifts is interpreted at the
selected target width. Width-polymorphic source must avoid constants and
algorithms whose meaning changes across the intended profiles.

Textual Sol provides word-scaled constants such as `2w`. A backend resolves
these as `2 * word_bytes`. They allow one Sol program to express frame slots
and record fields without fixing a byte width.

## Memory

Memory is byte-addressed. `ldb` and `stb` always access exactly one byte.
`ld` and `st` access exactly one target word.

The target profile defines byte order for word loads and stores. All currently
planned x86 backends are little endian. Portable Sol should not inspect the byte
representation of a word unless its target profile is known.

Every operation captures its explicit input register values and the
fall-through value of `ip` before committing a destination register write. This
makes aliasing deterministic. For example:

```text
add a, a, a
ld  ip, [ip]
pop sp
```

must not depend on the order in which the backend happens to use native
registers.

## Data movement

```text
mov destination, value
ld  destination, [base + offset]
ldb destination, [base + offset]
st  [base + offset], source
stb [base + offset], source
```

`value` and `offset` may be registers or immediates where the textual form
permits. `ld` and `st` use target-word width. `ldb` zero-extends. `stb` stores
the low eight bits.

## Arithmetic and logic

```text
add destination, left, right
sub destination, left, right
mul destination, left, right
div destination, left, right
rem destination, left, right
and destination, left, right
or  destination, left, right
xor destination, left, right
shl destination, left, right
shr destination, left, right
```

`shr` is logical. Arithmetic right shift is not part of Sol version 1.
Negation and complement are expressible without new semantic operations:

```text
sub result, z, value
xor result, value, -1
```

## Comparisons

```text
eq destination, left, right
ne destination, left, right
lt destination, left, right
le destination, left, right
gt destination, left, right
ge destination, left, right
```

`lt`, `le`, `gt`, and `ge` are signed comparisons. Every comparison writes a
canonical Boolean word.

## Control flow

```text
bz   condition, target
bnz  condition, target
jmp  target
call target
ret  argument_words
```

A direct target is a symbol. An indirect target is a register. A backend may
encode either form directly or synthesize it.

`bz` transfers when the condition is zero. `bnz` transfers when it is nonzero.

`call` saves the next Sol `ip` as a target word and transfers to the target.
`ret n` restores the caller's frame according to the selected Sol calling
convention and discards `n` argument words. The operand is a word count, not a
byte count.

## Stack and frames

The abstract stack grows toward lower addresses:

```text
push value
pop  destination
enter local_words
```

`push` decrements `sp` by `word_bytes`, then stores one word. `pop` loads one
word, then increments `sp` by `word_bytes`. Sources are captured before the
implicit stack update. The explicit destination of `pop` is committed after the
increment, so `pop sp` assigns the popped word to `sp`.

`enter n` pushes the previous `fp`, assigns the resulting `sp` to `fp`, and
reserves `n` words of local storage. It does not imply zero-initialization.

## Pseudo-operations

The textual form may provide these conveniences:

```text
addr destination, symbol
neg  destination, value
not  destination, value
bool destination, value
nop
```

They do not extend Sol semantics. A backend may lower them directly or expand
them into core operations.

## Deliberately absent

Sol version 1 has no semantic equivalent of:

- condition flags;
- partial general registers;
- implicit multiply or divide registers;
- floating point or vector state;
- atomics;
- privileged instructions;
- system calls or software interrupts;
- port I/O;
- descriptor tables;
- executable-container metadata;
- a hidden instruction pointer or hidden link register.

Platform services are ordinary symbols supplied at the boundary of a complete
image. Target-specific operations belong in explicit backend/runtime modules,
not in Sol's portable core.
