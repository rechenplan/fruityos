# Sol parser

This directory contains the target-independent textual Sol parser written in
Jabara. It performs no layout, relocation, word-width selection, or machine-code
emission.

## Interface

Create one or more source descriptors:

```jabara
local source:SolSource = new SolSource
source.name = "input.sol"
source.text = text
```

Link multiple sources through `source.next`, then create a parser:

```jabara
local parser:SolParser = sol_parser_new(source)
```

`sol_next(parser)` parses one item on demand. The returned `SolItem` and its
three operand records are owned by the parser and reused by the next call. A
consumer that needs to retain an item must copy the relevant scalar values and
source slices.

```jabara
local item:SolItem
while 1 do
  item = sol_next(parser)
  if item.kind == SOL_ITEM_EOF() then return 0 end
  if item.kind == SOL_ITEM_ERROR() then return 1 end
  consume(item)
end
```

`sol_each(parser, callback)` provides a callback-oriented adapter over the same
lazy pull interface.

Data lists are streamed one value at a time. For example, `db 1, 2, 3` produces
three `SOL_ITEM_DATA` items. `item.more` reports whether another value belongs
to the same directive.

Identifiers and string contents are slices into the original source buffers.
They are represented by a pointer and length and are not copied or terminated.
Strings remain escaped; `sol_escape_value` defines the accepted escape mapping.

## Parsed language

The parser recognizes Sol version 1, labels, `org`, `global`, `extern`, `align`,
`db`, `dw`, `dd`, `dq`, `word`, and every Sol version 1 operation. Keywords,
operations, and register names are case insensitive. Symbols retain their
original spelling.

Memory operands have the form:

```text
[register]
[register + register]
[register + immediate]
[register + symbol]
[register - immediate]
```

A semicolon begins a line comment.
EOF between linked `SolSource` records acts as a newline, so files cannot merge
lexically.

## Linux regression suite

After building a Jabara compiler, run:

```text
sol/parser/tests/test-linux.sh /path/to/jc /path/to/repository
```

The suite covers structural parsing, errors and overflow, every operation,
word-scaled literals, callback traversal, and 100,000 streamed instructions.
