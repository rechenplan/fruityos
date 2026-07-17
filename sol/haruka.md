# Haruka

Haruka is a separate compiler for the Jabara language that produces Sol IR.
Haruka and Jabara accept the same language; Haruka is not a rewrite or
replacement of Jabara.

```text
Jabara source -> Haruka -> Sol IR -> backend
```

## Shared frontend

Haruka's language model, lexer, parser, scope rules, and multi-argument `fn`
desugaring are kept synchronized with Jabara. The checked-in `model.jabara`,
`lexer.jabara`, and `parser.jabara` files are byte-identical between the two
compilers. Haruka differs only where target-independent Sol emission replaces
Jabara's native x86-64 emission.

## Width-sensitive lowering

Haruka expresses frame slots, arguments, record fields, closure fields, object
headers, and lexical-environment offsets with Sol word-scaled constants such as
`2w`. The selected backend resolves those constants using its target word
width. Haruka does not embed x86 instruction forms or Pluto encoding details.

## Records, closures, and lift

Record construction is explicit:

```jabara
local node:Node = new Node
```

Every allocated object has a hidden two-word header containing its lexical owner
frame and payload size. A closure is an ordinary variable-sized record: its
payload contains the code pointer followed by an inline snapshot of its current
lexical environment.

`lift var` implements explicit persistence across one lexical function
boundary:

- it is legal only inside `fn`;
- `var` must be a binding declared in that current `fn` scope;
- it shallow-copies the entire top-level record payload into the closure's
  lexical owner frame;
- it returns the promoted copy and does not modify `var`;
- referenced subrecords are not copied and must be lifted explicitly when their
  lifetime also needs extension.

A value must be lifted once at each additional function boundary it must cross.
An enclosing named `sub` may own the lifted copy, although `lift` itself is
invalid in the `sub` body.

The shared implementation is `../haruka/runtime.sol`. Sol itself does not make
`lift` an IR opcode; Haruka lowers it to the ordinary Sol routine
`__haruka_lift`.

## Current validation

Haruka programs execute end to end through Mars. The suite covers records,
shallow pointer identity, repeated lift, captured closure state, nested closure
creation after an outer activation has returned, and multi-argument currying.
The same language-level tests also run against Jabara's native emitter.
