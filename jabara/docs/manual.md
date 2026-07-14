# Programming in Jabara

Jabara is a small systems programming language. It gives you integers,
subroutines, loops, direct access to memory, records, and lexical closures while
keeping the language compact enough for its compiler to be written in Jabara
itself.

This guide assumes that you have never seen Jabara before. We will begin with a
program that does nothing, and introduce one idea at a time.

## Building Jabara

From the `jabara` directory, build the bootstrap and self-hosted compilers:

```sh
./build.sh
```

This creates three programs in `bin/`: `jbc`, the ANSI C bootstrap compiler;
`jc`, the compiler written in Jabara; and `jc-self`, the same Jabara compiler
compiled by itself. A C compiler and NASM must be installed.

Both compilers accept the same interface:

```text
jc input.jabara [input.jabara ...] output.asm
```

They only generate assembly. They do not invoke NASM, link a runtime, compress
a FAP file, or run the result.

## Your first program

An executable Jabara program needs a subroutine named `main`:

```jabara
sub main()
  return 0
end
```

A subroutine begins with `sub`, has a name and a parenthesized parameter list,
and finishes with `end`. Here the parameter list is empty. Returning zero tells
the surrounding system that the program completed successfully.

Save the example as `first.jabara`. From the `jabara` directory, generate its
Linux NASM source with either compiler:

```sh
bin/jc first.jabara first.asm
```

`jc` is the compiler written in Jabara. The smaller bootstrap compiler is
available as `bin/jbc` and accepts the same command-line arguments.

The compiler output does not select a loading environment. For Linux, prepend
the manual ELF header, append the Linux runtime, and assemble the combined
source as a flat binary:

```sh
cat lib/elf-header.asm first.asm lib/elf-runtime.asm > first-linked.asm
nasm -f bin first-linked.asm -o first
chmod +x first
./first
echo $?
```

The final command should print `0`. To target FruityOS, choose the FAP startup
and runtime assembly instead:

```sh
bin/jc first.jabara first-fap.asm
cat lib/fap-stack-runtime.asm lib/fap-runtime.asm first-fap.asm \
  > first-fap-linked.asm
nasm -f bin first-fap-linked.asm -o first.raw
../peel/bin/juicer.elf c first.raw first.fap
```

`fap-stack-runtime.asm` supplies FruityOS's origin, entry point, and allocator;
`fap-runtime.asm` supplies its system-call interface. Jabara does not run NASM
or Juicer itself. Juicer
compression is optional while inspecting the raw image, but a normal FruityOS
`.fap` file is the juiced form.

All Jabara compilation is implicit module compilation: headerless assembly with
stack-based subroutine environments and no target runtime. A source set does
not need `main`; its subroutines may instead be called by surrounding assembly.
Pass multiple sources before the output path to compile them as one program.

Records and closure objects need the symbol `__jabara_alloc`, supplied by the
chosen runtime or surrounding platform. A program containing only ordinary
subroutines does not need it. Because an ordinary
subroutine keeps its environment on the stack, a closure that captures one of
its locals must not outlive that subroutine.

The compiler has no ELF, FAP, or part modes. Origins and executable headers are
always explicit assembly inputs at the assembly stage.

## Comments and whitespace

A semicolon begins a comment. The comment continues to the end of the line:

```jabara
sub main()
  ; This line is ignored by the compiler.
  return 0 ; This part is ignored too.
end
```

Spaces, tabs, and newlines normally have no syntactic meaning. Indentation is
not required, but consistent two-space indentation makes nested code easier to
read.

Newlines are not statement terminators. The grammar tells the compiler when a
construct is complete. This is particularly visible in record declarations,
whose comma-separated field list may continue across any number of lines and
ends after the last field without `end` or a newline terminator.

## Values and local variables

Jabara's basic value is a machine word: a 64-bit integer that may also be used
as an address. Decimal integer literals can be written directly:

```jabara
sub main()
  local answer = 42
  return answer
end
```

Declare a local variable with `local`. An initializer after `=` is optional.
Uninitialized locals begin at zero:

```jabara
sub main()
  local count
  return count ; returns 0
end
```

Several locals may be declared together. Each one may have its own initializer:

```jabara
sub main()
  local width = 6, height = 7, area
  area = width * height
  return area
end
```

Assignment is an expression. It stores the value and also produces that value:

```jabara
local result
result = 40 + 2
```

Locals are visible throughout their containing subroutine or closure. A local
written inside an `if` or `while` is still part of that containing scope.

## Arithmetic and comparisons

Jabara provides these binary operators:

| Purpose | Operators |
| --- | --- |
| Arithmetic | `+`, `-`, `*`, `/`, `%` |
| Comparison | `==`, `!=`, `<`, `<=`, `>`, `>=` |
| Bitwise | `&`, `|`, `^`, `<<`, `>>` |
| Boolean | `&&`, `||` |

Unary `-` negates a number, `~` flips its bits, and `!` turns zero into one and
a nonzero value into zero.

One rule is especially important: **all binary operators have the same
precedence and associate from left to right**. Use parentheses whenever an
expression combines different operators:

```jabara
local area = width * height
local adjusted = area + (padding * 2)
```

Without the parentheses, `area + padding * 2` is read as
`(area + padding) * 2`.

Boolean `&&` and `||` evaluate both operands. They do not short-circuit. Do not
use them to protect an operation that would be unsafe when the left operand is
false. Write a nested `if` instead:

```jabara
if pointer != 0 then
  if byte [pointer] != 0 then
    ; It is now safe to read through pointer.
  end
end
```

Zero is false. Any nonzero word is true.

## Decisions

Use `if`, `then`, and `end` to run code conditionally:

```jabara
sub absolute(value)
  if value < 0 then
    return -value
  end
  return value
end
```

An `else` branch is optional:

```jabara
sub smaller(left, right)
  if left < right then
    return left
  else
    return right
  end
end
```

There is no special `else if` construct. Put another complete `if` inside the
`else` branch when you need more cases.

## Loops

Jabara has a `while` loop:

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

There are no `for`, `break`, or `continue` statements. A loop can usually be
expressed with a counter or a separate `done` variable:

```jabara
local done = 0
while done == 0 do
  ; Do some work.
  if condition then done = 1 end
end
```

## Subroutines

Subroutines may take up to six parameters:

```jabara
sub add(left, right)
  return left + right
end

sub main()
  return add(20, 22)
end
```

Arguments are passed using the 64-bit System V calling convention. A direct
call names a `sub` explicitly. A named subroutine is not itself a first-class
value, so this is not allowed:

```jabara
; Not valid Jabara:
local operation = add
```

Use an explicit closure when you need a callable value. Closures are introduced
later in this guide.

Every control path conceptually returns a word. If execution reaches the end of
a subroutine without `return`, the compiler supplies zero.

## Strings and bytes

A string literal is a pointer to a zero-terminated sequence of bytes:

```jabara
local message = "Hello"
```

The supported escapes are `\n`, `\r`, `\t`, `\\`, and `\"`.

Use `byte [address]` to load one byte from memory:

```jabara
local first = byte [message] ; the byte for H
```

Byte locations are assignable too:

```jabara
byte [buffer + index] = 65 ; store an ASCII A
```

Here is a complete string-printing program. `putch` is supplied by the runtime,
so the source declares it as external:

```jabara
extern sub putch(character)

sub print(text)
  while byte [text] != 0 do
    putch(byte [text])
    text = text + 1
  end
end

sub main()
  print("Hello from Jabara!\n")
  return 0
end
```

## Words and raw memory

Square brackets without `byte` load or store an entire 64-bit word:

```jabara
local value = [address]
[address + 8] = value
```

Jabara does not automatically check an address before using it. Reading from
zero or from an invalid address can stop the program. This directness is useful
for systems programming, but it means pointer operations deserve care.

Pointer arithmetic is ordinary integer arithmetic. Adding eight advances by
one word; adding one advances by one byte.

## Records

Records give names to word-sized fields. A declaration is the word `record`, a
record name, and a comma-separated field list:

```jabara
record Point x, y
```

There is no closing `end` for a record declaration. The field list ends when
there is no comma introducing another field. Newlines do not terminate it, so
the following is also valid, though the one-line form is usually clearer:

```jabara
record Point x,
  y
```

Call the record name with no arguments to allocate a zero-initialized record.
Tag the variable with `:Point` so the compiler knows its field layout:

```jabara
record Point x, y

sub main()
  local point:Point = Point()
  point.x = 20
  point.y = 22
  return point.x + point.y
end
```

Tags are compile-time layout information, not runtime type information. An
untagged variable is simply a word. Jabara has no dynamic descriptor fallback,
and member access through an untagged word is rejected:

```jabara
local untagged = Point()
; untagged.x is not allowed because untagged has no :Point tag.
```

Tags may be placed on parameters and record fields as well as locals:

```jabara
record Node value, next:Node

sub read_next(node:Node)
  if node.next == 0 then return 0 end
  return node.next.value
end
```

The compiler trusts a tag. It does not insert a runtime check when a word is
assigned to a tagged variable. Assign only records of the promised layout.

Records are heap allocated and are not currently reclaimed.

## Closures

A closure is an anonymous function together with the surrounding variables it
captures. Create one with `fn parameter do ... end`:

```jabara
sub main()
  local add_five
  add_five = fn value do
    return value + 5
  end
  return add_five(37)
end
```

Each `fn` takes one parameter. A closure can return another closure, which is a
convenient way to build functions that remember a value:

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

The inner closure captures `amount`. Its environment is stored on the heap, so
it remains valid after the outer closure returns. Captured variables are shared
locations: assigning to a captured variable changes what sibling closures see.

Calls with several arguments apply a chain of one-argument closures. For
example, `function(a, b)` first applies `a`, then applies `b` to the closure
returned by the first application.

To use a named subroutine as a callable value, wrap its call explicitly:

```jabara
sub add(left, right)
  return left + right
end

sub main()
  local operation
  operation = fn left do
    return fn right do
      return add(left, right)
    end
  end
  return operation(20, 22)
end
```

## External subroutines

An external declaration tells the compiler that a directly callable routine
will be supplied by assembly combined with the compiler's output:

```jabara
extern sub write(fd, buffer, count)
```

The declaration has no body and no closing `end`. Parameter names document the
expected arguments. Jabara's standard Pith declarations are collected in
`lib/pith.jabara`; they include file operations, process operations, and basic
memory-related system calls.

External declarations do not themselves provide an implementation. Jabara
does not embed the Pith routines. Select the ELF header and runtime for Linux,
or the FAP startup and runtime for FruityOS, as shown in the first-program
commands. The
Linux runtime implements Pith with Linux system calls; the FAP runtime uses the
FruityOS system-call interrupt. A module's surrounding platform must supply any
external symbols the generated assembly calls.

## Program-scope declarations and statements

Locals declared outside a subroutine become global words:

```jabara
local calls

sub increment_calls()
  calls = calls + 1
  return calls
end

sub main()
  return increment_calls()
end
```

Other program-scope statements are executed at the beginning of the explicit
`main` subroutine. An explicit `sub main` is required by the `elf` and `fap`
formats. The `module` format permits omitting `main`; when it is omitted, there
is no entry point at which program-scope executable statements can run, so keep
module initialization in a subroutine that the platform calls. Beginners will
usually find it clearest to keep executable statements inside `main` and use
program scope only for globals and declarations.

## A larger example

This example combines records, tagged parameters, a loop, and an external
output routine:

```jabara
extern sub putch(character)

record Counter value, limit

sub print_digit(value)
  putch(48 + value)
end

sub run(counter:Counter)
  while counter.value <= counter.limit do
    print_digit(counter.value)
    putch(10)
    counter.value = counter.value + 1
  end
end

sub main()
  local counter:Counter = Counter()
  counter.value = 1
  counter.limit = 5
  run(counter)
  return 0
end
```

## Common surprises

When a small Jabara program behaves unexpectedly, check these points first:

1. Binary operators all have the same precedence. Add parentheses.
2. `&&` and `||` evaluate both operands. Use nested `if` statements for guards.
3. Record member access requires a compile-time tag such as `value:Point`.
4. A named `sub` cannot be assigned as a value. Wrap it in `fn`.
5. A `fn` has exactly one parameter; multi-argument closure calls apply a chain
   of closures.
6. Strings are pointers to zero-terminated bytes, not managed string objects.
7. Memory access is unchecked, and allocated records are not reclaimed.
8. Every `elf` or `fap` program needs an explicit `sub main`; a `module` does
   not.

## Compact syntax reference

Identifiers begin with a letter or underscore and continue with letters,
digits, or underscores. Integer literals use decimal digits; write a negative
value with unary `-`. The language's reserved words are:

```text
local if then else end while do sub return byte fn record extern
```

`record`, `sub`, and `extern sub` declarations belong at program scope. A
direct subroutine and a direct call may have at most six parameters or
arguments. Assignable expressions are variables, record members, word memory
locations such as `[address]`, and byte locations such as `byte [address]`.

Strings recognize `\n`, `\r`, `\t`, `\\`, and `\"`. There are no implicit
managed strings, arrays, floating-point values, exceptions, or garbage
collector. These omissions are part of Jabara's deliberately small execution
model; raw words and memory operations remain available when a higher-level
abstraction is not built into the language.

## Running the tests

From the `jabara` directory:

```sh
./test.sh
```

The suite compares the bootstrap and self-hosted compilers, checks records,
closures, diagnostics, ELF and FAP output, and exercises the retained compiler
compatibility tests. When the repository's Juicer tool is available, it also
checks a FAP compression and decompression round trip. Finally, it compiles all
Peel programs with `jc` and leaves their Linux executables in the repository's
top-level `bin/` directory.

## Where to go next

The examples under `tests/` are small executable demonstrations of records,
closures, argument handling, and compatibility behavior. The self-hosted
compiler under `src/jc/` is a much larger Jabara program and shows how the
language can be used for lexing, parsing, data structures, and x86-64 code
generation.

Start with short programs, use parentheses generously, and introduce raw
memory only when you need it. Jabara is intentionally small; once its handful
of rules become familiar, the complete language remains manageable.
