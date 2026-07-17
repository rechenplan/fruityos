# Textual Sol syntax

Textual Sol is the exchange form consumed by backends such as Mars. It is a
small assembler-like notation for Sol IR, not a target assembly language.

## Source header

A source begins with a version declaration:

```text
sol 1
```

A flat-image backend may also accept an origin:

```text
org 0x100000
```

`org` selects the target address assigned to the first emitted byte. It does not
emit data.

Keywords and register names are case insensitive. Generated source should use
lowercase.

## Registers

```text
z  a  b  c  d  fp  sp  ip
```

## Instructions

Examples:

```text
mov a, 42
add a, b, c
sub d, a, 1
mul a, a, b
lt  c, a, 0

ld  a, [fp + 2]
st  [a + 1], d
ldb b, [a + c]
stb [a], b

push a
pop  b
enter 4
ret  2

call worker
call a
jmp  loop
jmp  d
bz   a, done
bnz  b, again
```

Plain numeric displacements and immediates are exact byte/integer values. A
number suffixed with `w` is multiplied by the backend-selected word size:

```text
add a, fp, -2w
ld  b, [fp + 3w]
```

This is the canonical form for frame slots, record fields, and other
target-word-scaled addresses. `2w` is 16 bytes in Mars, 4 bytes in Luna, and 8
bytes in Terra. Word-scaled numbers are accepted by `align` so `align 1w` expresses target-word alignment. They are not accepted for `org`, `enter`, `ret`, or explicit-width data directives; those constructs already have defined units.

## Labels and symbols

A label is written with a trailing colon:

```text
worker:
    enter 0
    add a, a, 1
    ret 1
```

Direct control flow uses labels directly. A symbol used as an address may be
loaded with `addr`:

```text
addr a, message
```

Backends resolve symbols after layout. A reference to `ip` is relative to the
next Sol operation, even when the backend emits several target instructions for
the current operation.

## Declarations

```text
global name
extern name
```

`global` marks a defined symbol for export from the current input set. `extern`
marks a symbol whose address must be supplied by the surrounding image or a
future linker. A pure flat backend may reject unresolved externals.

## Data and layout

```text
align boundary

db  1, 2, 3
dw  0x1234
dd  0x12345678
dq  0x123456789abcdef0
word 0
```

The explicit data directives emit exactly 8, 16, 32, and 64 bits respectively.
They are always little endian in the currently planned x86 backends.

`word` emits one target word and is the preferred directive for target-width
values. Its emitted size is selected by the backend.

Strings may be accepted as data operands where supported:

```text
db "hello", 10, 0
```

Escaping and concatenation rules are part of the textual parser rather than Sol
semantics and remain subject to refinement.

## Pseudo-operations

```text
addr a, symbol
neg  a, b
not  a, b
bool a, b
nop
```

Their meanings are defined in [ir.md](ir.md). A backend may emit specialized
target code without exposing that choice in Sol.

## Multiple input files

A backend may treat several input files as one logical source stream:

```text
mars first.sol second.sol image.bin
```

Symbols are shared across the input set. Layout proceeds in input order. The
version declaration should appear at the beginning of the logical stream.

## Errors

A backend should reject at least:

- unknown operations or registers;
- malformed operands;
- duplicate symbol definitions;
- undefined non-external symbols;
- an origin that changes between layout and emission;
- values that cannot be represented by a required target relocation;
- unsupported target operations;
- data values too large for their explicit directive.
