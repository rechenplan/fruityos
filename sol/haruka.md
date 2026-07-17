# Haruka

Haruka is the future language frontend that will produce Sol IR.

Haruka is a new frontend, not a rewrite of Jabara. Jabara remains the existing
language/compiler and may continue to implement tools such as Mars.

The boundary is:

```text
Haruka source -> Haruka frontend -> Sol IR -> backend
```

## Frontend responsibilities

Haruka is responsible for:

- parsing and language semantics;
- lexical scope and closure construction;
- type/tag analysis;
- object and frame layout expressed in target-parametric terms;
- lowering high-level control flow to Sol branches;
- selecting runtime calls;
- emitting valid textual or in-memory Sol.

The selected backend is responsible for word width and target encoding. Haruka
must not embed x86 instruction forms or Pluto parcel details in Sol output.

## Width-sensitive lowering

Sol operations are word-polymorphic, but concrete layouts are not always
width-independent. Haruka should represent frame slots, arguments, record
fields, and target words in a way that backends can scale correctly.

Until Sol's target-parametric layout expressions are frozen, a Haruka build may
select a target profile before final Sol serialization. That is still different
from emitting target assembly: the output remains Sol operations and Sol data,
with the backend owning native lowering.

## Closures and records

Haruka may choose its own record and closure representation so long as it is
expressed in ordinary Sol memory operations and runtime conventions. Sol does
not define a garbage collector, heap, stack-region model, or boxing semantics.
Those belong to the frontend/runtime pair.

This separation is intentional. Jabara's manual boxing experiments and closure
representation do not automatically become Sol semantics or Haruka language
rules.

## Validation

The Haruka frontend should be tested by compiling the same Sol output through
multiple backends and comparing language-visible behavior. Backend-specific
runtime boundaries may differ, but pure computation and memory behavior should
agree at the selected word width.
