# Programming in Jabara

Jabara is a compact systems programming language with 64-bit values,
subroutines, loops, direct memory access, records, and lexical closures. Its
compiler emits NASM-compatible module assembly and is itself written in Jabara.

## Build the toolchain

From the repository root:

```text
bin/pish build.psh
```

Orgasm assembles the checked-in generated `src/jbc/jbc.asm` module, and the resulting temporary compiler rebuilds the Jabara toolchain into:

- `jabara/out/linux-x86_64/orgasm.elf`;
- `jabara/out/linux-x86_64/jc.elf`;
- corresponding `.fap` target outputs under `jabara/out/fruityos-x86_64/`.

The installed compiler accepts:

```text
jabara input.jabara [input.jabara ...] output.asm
```

It emits only assembly. Executable headers, origins, platform services, and
compression are separate build inputs.

## First program

```jabara
sub main(argc, argv)
  return 0
end
```

Build a native application from the repository root:

```text
bin/jb.psh $platform first first.jabara
```

Build a FruityOS FAP explicitly:

```text
bin/jb.psh fruityos-x86_64 first.fap first.jabara
```

`jb.psh` selects `lib/<platform>/pith.jabara`, `start-jabara.asm`, and
`runtime-jabara.asm`. The default `jc.psh` driver is reserved for the
Haruka/Mars `.hr` chain.

A source set may omit `main` when surrounding assembly calls its subroutines.
ELF and FAP startup runtimes call `main`, so programs linked with those runtimes
must define it.

Records and closures require `__jabara_alloc`, supplied by the selected runtime.

## Comments and whitespace

A semicolon starts a comment:

```jabara
sub main(argc, argv)
  ; whole-line comment
  return 0 ; end-of-line comment
end
```

Spaces, tabs, and newlines are separators, not statement terminators.
Indentation is optional.

## Values and locals

Every value is one 64-bit word. A word may be used as an integer or address.

```jabara
sub main(argc, argv)
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

A subroutine may take up to 8191 parameters:

```jabara
sub add(left, right)
  return left + right
end
```

Arguments are evaluated and pushed from left to right. The last argument is
nearest the return address, and the callee removes its arguments before
returning. The same stack convention applies to declared `extern` subroutines.
Reaching the end of a subroutine returns zero. Executable programs define
`main(argc, argv)`; the platform startup code supplies both arguments.

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

Construction is explicit with `new`:

```jabara
sub main(argc, argv)
  local point:Point = new Point
  point.x = 20
  point.y = 22
  return point.x + point.y
end
```

A compile-time tag selects the field layout. Tags may appear on locals,
parameters, and record fields:

```jabara
record Node value, next:Node

sub read_next(node:Node)
  if node.next == 0 then return 0 end
  return node.next.value
end
```

Tags do not add runtime checks. `new Record` allocates a zero-initialized object
in the current function frame. The object is reclaimed when that frame returns
unless it is explicitly lifted.

The old `Record()` constructor spelling is invalid.

## Closures

A closure is an anonymous `fn` together with an inline snapshot of its current
lexical environment:

```jabara
sub main(argc, argv)
  local add_five = fn value do
    return value + 5
  end
  return add_five(37)
end
```

Closures are ordinary allocated records. Their payload begins with a code
pointer and continues with the captured environment words. Captured scalar
bindings are snapshot values; mutating one inside the closure changes the
closure's environment, not the original scalar binding in the creating frame.
Captured record pointers still refer to the same record objects.

Multi-argument syntax is sugar for nested one-argument closures:

```jabara
local add = fn left, right do
  return left + right
end
```

The compiler inserts the required lift for each synthesized intermediate
closure.

## Lift and function ownership

`lift var` explicitly promotes one allocated value across one lexical function
boundary:

```jabara
record Box value

sub main(argc, argv)
  local make = fn do
    local box:Box = new Box
    box.value = 42
    return lift box
  end
  local box:Box = make()
  return box.value
end
```

The rules are:

- `lift` accepts a variable name, not an arbitrary expression;
- it is legal only inside `fn`;
- the variable must have been declared in that current `fn` scope;
- the complete top-level record is copied into the frame that lexically owns
  the closure;
- the copy is shallow: record-valued fields remain unchanged pointers;
- the promoted copy is returned as the expression value;
- the original variable and object are not modified or rebound.

A named `sub` may be the lexical owner that receives a lifted value, but `lift`
is invalid inside the `sub` itself. A value that must cross another enclosing
`fn` boundary must be lifted again by a variable declared in that scope.

Because lift is shallow, referenced child records must be promoted separately
before they are stored into a parent that will outlive them:

```jabara
record Child value
record Parent child:Child

local child:Child = new Child
local lasting_child:Child = lift child
local parent:Parent = new Parent
parent.child = lasting_child
return lift parent
```

Every allocated record and closure carries a hidden owner-and-size header used
by the runtime. The header is not visible through tagged field access.

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
local if then else end while do sub return byte fn record extern new lift
```

Identifiers begin with a letter or underscore and continue with letters, digits,
or underscores. Integer literals are decimal; unary `-` forms negative values.
Assignable expressions are variables, record members, `[address]`, and
`byte [address]`.

Jabara has no managed strings, arrays, floating-point values, exceptions, or
garbage collector.

## Regression inputs

Small compiler regression programs are stored under `jabara/tests/`. The full
repository build exercises the self-hosting compiler, Orgasm, all Peel targets,
Seed, Pulp, Juicer compression, and image construction.
