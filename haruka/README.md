# Haruka

Haruka is a separate implementation of the Jabara language. It accepts the
same source language and emits width-neutral textual Sol instead of x86-64
Orgasm input.

```text
haruka input.jabara [input.jabara ...] output.sol
```

Haruka's `model.jabara`, `lexer.jabara`, and `parser.jabara` are kept
byte-identical to Jabara's corresponding frontend sources. Only the emitter and
runtime boundary differ.

## Object lifetime

Record construction uses:

```jabara
local point:Point = new Point
```

Records and closures are allocated in the current function frame. A value that
must survive the current `fn` is promoted explicitly:

```jabara
return lift point
```

`lift`:

- accepts only a variable name;
- is valid only inside `fn`;
- requires the variable to have been declared in that same `fn` scope;
- shallow-copies the complete top-level record into the closure's lexical owner
  frame;
- returns the promoted copy without rebinding the original variable.

Closures are ordinary variable-sized records containing their code pointer and
inline captured environment. They use the same allocation header and the same
shallow lift operation as declared records.

The shared width-neutral runtime is [`runtime.sol`](runtime.sol). It implements
local stack insertion and lexical-owner promotion using Sol word-scaled
operations, so Mars, Luna, Terra, and Pluto can share the language lifetime
model.

## Validation

The test pipeline is:

```text
Jabara-language source -> Haruka -> Sol -> Mars -> raw x86-64 -> host harness
```

Tests cover locals, tagged records, field mutation, shallow pointer
preservation, one- and two-boundary lifts, captured mutable closure state,
nested lifted-closure creation, and two- and three-argument currying. Negative
tests reject lift in `sub`, lifting a captured binding, and legacy `Record()`
construction.

Flat images containing absolute addresses must be loaded at the address declared
by `org`. Haruka does not choose that origin; the image composition step does.
