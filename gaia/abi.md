# Gaia Jabara ABI

The first Gaia ABI preserves the current Jabara stack and object conventions so
that the compiler can change target language without simultaneously changing
language semantics.

## Register convention

| Register | ABI meaning | Call preservation |
| --- | --- | --- |
| `z` | zero | immutable |
| `a` | return value and expression result | caller-saved |
| `b` | temporary | caller-saved |
| `c` | temporary / closure environment | caller-saved |
| `d` | temporary | caller-saved |
| `fp` | current frame | restored by `ret` |
| `sp` | current stack | restored according to call convention |
| `ip` | control flow | saved by `call` |

There are no callee-saved general registers in v0. Jabara already treats its
working registers as ephemeral, and the small register file should not carry an
unnecessary preservation protocol.

## Stack direction

The stack grows toward lower addresses. `sp` points at the most recently pushed
64-bit word.

Arguments are pushed left to right. The callee removes its arguments with
`ret argument_bytes`.

For:

```text
sub f(x, y, z)
```

and a 24-byte argument area, the established frame is:

```text
higher addresses

fp + 32    x
fp + 24    y
fp + 16    z
fp +  8    return address
fp +  0    previous fp
fp -  8    first local / environment pointer
...        additional locals
sp         bottom of allocated local area

lower addresses
```

More generally, for parameter slot `i` numbered from one in a function with
`n` parameters:

```text
offset = (n - i + 2) * 8
```

This is the same layout used by the current Jabara emitter.

## Function entry and return

A function begins with:

```text
enter local_bytes
```

`local_bytes` is rounded as required by the compiler. Uninitialized locals are
explicitly zeroed by generated code; `enter` does not clear memory.

A normal return value is placed in `a` and the function ends with:

```text
ret parameter_count * 8
```

A function that falls off its body returns zero in `a`.

## Direct calls

For a direct call, Jabara evaluates and pushes arguments from left to right,
then executes `call symbol`. The callee cleans the argument words.

Large immediate arguments are ordinary 64-bit values. The native Gaia encoder
may need an extension parcel; the x86 backend may need a scratch register when
x86 `push imm32` cannot represent the value.

## Globals

Global variables are 64-bit zero-initialized cells aligned to eight bytes.
Generated code addresses them relative to `ip`, preserving position-independent
source semantics for both backends.

## Records

A record is a contiguous allocation of 64-bit fields in declaration order. A
zero-field record still allocates one word. Constructors zero every field.

A byte-qualified lvalue uses `ldb` or `stb`; ordinary fields use `ld` or `st`.
The type tag is compile-time information and is not stored in the object.

## Closures

A closure value is two words:

```text
+0  code address
+8  environment pointer
```

Closure bodies receive two arguments:

```text
fp + 16    applied value
fp + 24    parent environment
```

The body allocates a new environment. Slot zero stores the parent environment;
slot one stores the applied value. Additional captured or local bindings follow.
A closure body returns with `ret 16`.

Multi-argument closure application remains curried: each argument is applied in
sequence, and the returned value becomes the callee for the next argument.

## Allocation and platform services

Jabara calls `__jabara_alloc` and Pith runtime symbols as ordinary Gaia calls.
The ISA does not know about heaps, files, consoles, system calls, BIOS, UEFI, or
FruityOS interrupt numbers.

Each backend/runtime pair provides those symbols:

- Orgasm lowers Gaia to x86-64 and links an x86 host runtime;
- native Gaia links a Gaia runtime that uses memory-mapped FPGA devices.
