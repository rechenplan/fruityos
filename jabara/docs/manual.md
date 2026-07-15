# Programming in Jabara

Jabara is a compact systems programming language with 64-bit values,
subroutines, loops, direct memory access, records, and lexical closures. Its
compiler emits NASM-compatible module assembly and is itself written in Jabara.

## Build the toolchain

From `jabara/`:

```sh
./build.sh
```

The build creates:

- `bin/jbc`, the C compiler implementation;
- `bin/jc`, the Jabara compiler implementation;
- `bin/jc-self`, `jc` compiled by `jc`;
- `bin/orgasm`, the assembler used by the repository.

Both compilers accept:

```text
jc input.jabara [input.jabara ...] output.asm
```

They emit only assembly. Executable headers, origins, platform services, and
compression are separate build inputs.

## First program

```jabara
sub main()
  return 0
end
```

Generate assembly:

```sh
bin/jc first.jabara first.asm
```

Build a Linux executable:

```sh
bin/orgasm lib/elf-header.asm first.asm lib/elf-runtime.asm first
chmod +x first
./first
```

Build a FruityOS FAP:

```sh
bin/jc first.jabara first-fap.asm
bin/orgasm \
  lib/fap-stack-runtime.asm \
  lib/fap-runtime.asm \
  first-fap.asm \
  first.raw
../peel/bin/juicer.elf c first.raw first.fap
```

A source set may omit `main` when surrounding assembly calls its subroutines.
ELF and FAP startup runtimes call `main`, so programs linked with those runtimes
must define it.

Records and closures require `__jabara_alloc`, supplied by the selected runtime.

## Comments and whitespace

A semicolon starts a comment:

```jabara
sub main()
  ; whole-line comment
  return 0 ; end-of-line comment
end
```

Spaces, tabs, and newlines are separators, not statement terminators.
Indentation is optional.

## Values and locals

Every value is one 64-bit word. A word may be used as an integer or address.

```jabara
sub main()
  local width = 6, height = 7, area
  area = width * height
  return area
end
```

Uninitialized locals begin at zero. Assignment stores and returns its value.
Locals belong to their containing subroutine or closure, including declarations
inside `if` and `while` bodies.

## Operators

| Purpose | Operators |
| --- | --- |
| Arithmetic | `+`, `-`, `*`, `/`, `%` |
| Comparison | `==`, `!=`, `<`, `<=`, `>`, `>=` |
| Bitwise | `&`, `|`, `^`, `<<`, `>>` |
| Boolean | `&&`, `||` |

Unary operators are `-`, `~`, and `!`.

All binary operators have equal precedence and associate left to right. Use
parentheses when mixing operators:

```jabara
local adjusted = area + (padding * 2)
```

`&&` and `||` evaluate both operands. Use nested `if` statements when an
operation must be guarded.

Zero is false. Every nonzero word is true.

## Conditionals

```jabara
sub absolute(value)
  if value < 0 then
    return -value
  else
    return value
  end
end
```

There is no separate `else if` form; nest an `if` inside `else`.

## Loops

```jabara
sub sum_to(limit)
  local number = 1, total = 0
  while number <= limit do
    total = total + number
    number = number + 1
  end
  return total
end
```

Jabara has no `for`, `break`, or `continue` statements.

## Subroutines

A direct subroutine may take up to six parameters:

```jabara
sub add(left, right)
  return left + right
end
```

Arguments follow the x86-64 System V register convention. Reaching the end of a
subroutine returns zero.

A named subroutine is not a first-class value. Wrap a call in `fn` when a
callable value is required.

## Strings and bytes

A string literal points to zero-terminated bytes. Supported escapes are `\n`,
`\r`, `\t`, `\\`, and `\"`.

```jabara
extern sub putch(character)

sub print(text)
  while byte [text] != 0 do
    putch(byte [text])
    text = text + 1
  end
end
```

`byte [address]` loads or stores one byte:

```jabara
local first = byte [message]
byte [buffer + index] = 65
```

## Word memory

Square brackets without `byte` load or store a 64-bit word:

```jabara
local value = [address]
[address + 8] = value
```

Memory access is unchecked. Pointer arithmetic is ordinary integer arithmetic.

## Records

A record declaration lists word-sized fields:

```jabara
record Point x, y
```

Calling the record name allocates a zero-initialized object. A compile-time tag
selects the field layout:

```jabara
sub main()
  local point:Point = Point()
  point.x = 20
  point.y = 22
  return point.x + point.y
end
```

Tags may appear on locals, parameters, and record fields:

```jabara
record Node value, next:Node

sub read_next(node:Node)
  if node.next == 0 then
    return 0
  end
  return node.next.value
end
```

Tags do not add runtime checks. Records are heap allocated and are not reclaimed.

## Closures

A closure combines an anonymous function with captured locations:

```jabara
sub main()
  local add_five
  add_five = fn value do
    return value + 5
  end
  return add_five(37)
end
```

Each `fn` declares one parameter. Calls with several arguments apply a chain of
one-argument closures.

```jabara
sub main()
  local make_adder, add_five
  make_adder = fn amount do
    return fn value do
      return value + amount
    end
  end
  add_five = make_adder(5)
  return add_five(37)
end
```

Captured variables are shared locations. A closure that captures a stack local
from an ordinary subroutine must not outlive that subroutine. Environments
created by a closure and captured by another closure are heap allocated.

## External subroutines

An external declaration names a routine supplied by linked assembly:

```jabara
extern sub write(fd, buffer, count)
```

`lib/pith.jabara` contains the service declarations used by FruityOS programs.
`elf-runtime.asm` implements them with Linux system calls.
`fap-runtime.asm` implements them with FruityOS interrupt `0x84`.

## Program scope

Program-scope locals become global words:

```jabara
local calls

sub increment_calls()
  calls = calls + 1
  return calls
end
```

Program-scope executable statements are inserted at the beginning of an
explicit `main`. Headerless modules that omit `main` should place initialization
in a subroutine called by their surrounding assembly.

## Compact syntax reference

Reserved words:

```text
local if then else end while do sub return byte fn record extern
```

Identifiers begin with a letter or underscore and continue with letters, digits,
or underscores. Integer literals are decimal; unary `-` forms negative values.
Assignable expressions are variables, record members, `[address]`, and
`byte [address]`.

Jabara has no managed strings, arrays, floating-point values, exceptions, or
garbage collector.

## Tests

From `jabara/`:

```sh
./test.sh
./src/orgasm/test.sh
```

The suites check compiler agreement, self-compilation, records, closures,
arguments, expected diagnostics, ELF and FAP generation, Yuzu integration,
Juicer round trips, Orgasm, Pulp assembly, and every Peel program.

Small examples are under `tests/`. The compiler under `src/jc/` demonstrates
lexing, parsing, records, closures, and x86-64 assembly generation in Jabara.
