# Petit

Petit is FruityOS's irreducible stage-0 assembler. It is a 254-byte DOS
`.COM` program whose only job is to turn human-editable `.pm` text into an
exact byte stream.

Petit is deliberately ignorant of executable formats, instruction sets,
operating systems, and FruityOS. It does not know ELF, PE, FAP, x86, Linux,
Windows, or FruityOS. Those meanings live entirely in the source being
assembled. The same `petit.com` processes every `.pm` file.

The checked-in binary is:

```text
stage0/petit.com   254 bytes
```

Its readable source is:

```text
stage0/petit.pm
```

Running Petit on its own source reproduces the binary byte-for-byte.

## Invocation

Petit reads source from DOS standard input and writes the assembled image to
DOS standard output:

```bat
petit.com < input.pm > output.bin
```

It has no command-line parser, filenames, platform switches, include paths, or
configuration. DOS redirection supplies all file handling.

The explicit `!` directive ends the source. Petit does not wait for an EOF
condition, which saves code and makes the accepted input independent of DOS's
text-file EOF conventions.

## Lexical rules

Petit is a streaming, single-pass assembler. It consumes one byte at a time.

- Bytes below ASCII `!` are whitespace and are ignored.
- `;` begins a comment extending through line feed.
- `!` ends assembly and writes the output.
- Recognized directive characters introduce the forms below.
- Other printable characters emit themselves directly.

This last rule is useful for byte-oriented sizecoding: printable x86 opcodes,
header signatures, punctuation, and short ASCII fragments need no directive.
Quoted strings are generally clearer for text longer than one character.

## Language reference

### Continuous hexadecimal bytes

```text
#31C0B440CD21#
```

Each pair of uppercase hexadecimal digits emits one byte. The terminating `#`
is mandatory. Hexadecimal digits are `0`-`9` and `A`-`F`; lowercase digits are
not accepted.

The number of digits must be even. Petit performs no validation, so malformed
hexadecimal source produces malformed output rather than a diagnostic.

### Quoted literal bytes

```text
'Hello, world!'
```

Every byte between the apostrophes is emitted literally, including spaces and
characters that would otherwise be directives. There are no escapes and no
way to place an apostrophe inside a quoted run; use hexadecimal `27` for that
byte.

### Repetition

```text
*1000
```

The syntax is `*CCVV`:

- `CC` is an 8-bit hexadecimal count.
- `VV` is the byte to repeat.

The example emits sixteen zero bytes. Counts range from `00` through `FF`;
`00` emits nothing. Longer runs are written as several repetition directives.

### Absolute symbols

Uppercase one-character symbols are absolute COM-address symbols:

```text
#BA#@M
#B409CD21CD20#
:M 'Hello$'
```

`:M` defines `M` at the current output position. `@M` emits a 16-bit little-
endian address suitable for a DOS `.COM` image loaded at offset `0100h`.

The emitted value is:

```text
label output offset + 0100h
```

### Relative symbols

Lowercase one-character symbols are signed 16-bit PC-relative symbols:

```text
#E9#@done
...
:done
```

Because symbols are exactly one character, the actual form is `@d` and `:d`.
The longer name above is explanatory only.

For a lowercase reference at output position `P`, Petit emits:

```text
target - (P + 2)
```

This is the displacement used by a near relative x86 branch or call whose
16-bit displacement follows the opcode.

### Comments

```text
#31C0# ; xor ax, ax
```

A semicolon discards input through the next line-feed byte. Carriage returns
are ordinary ignored whitespace, so DOS CRLF files work naturally.

### End of source

```text
!
```

`!` patches no symbols and performs no validation. It writes all bytes emitted
so far to standard output and terminates through DOS.

## Symbol implementation

Petit reserves a 512-byte table at offset `7E00h`: one 16-bit entry for every
possible one-byte symbol. Symbol names therefore require no hashing, string
storage, comparison loop, or allocation.

Each table entry has two states:

- **Resolved:** bit 15 is set and the remaining bits contain the label's output
  address.
- **Unresolved:** the value is the head of a forward-reference chain.

Forward-reference chains are stored inside the output buffer itself. When an
undefined symbol is referenced, Petit writes the previous chain head into the
new two-byte fixup and makes that fixup the new head. When the symbol is later
defined, Petit walks the chain, reading the next link before replacing each
link word with its final absolute or relative value.

This is the central size trick: the output bytes temporarily serve as linker
metadata, so Petit needs neither a second pass nor a separate fixup array.
Backward references are patched immediately from the resolved table entry.

## Memory model and limits

DOS loads `petit.com` at offset `0100h` in its program segment.

Petit uses fixed offsets in the same segment:

```text
0100h..01FDh   Petit code
0200h..7DFFh   assembled output and unresolved-fixup chains
7E00h..7FFFh   256-entry symbol table
```

The maximum output size is therefore:

```text
7E00h - 0200h = 7C00h = 31,744 bytes
```

The current uncompressed Orgasm bootstrap images fit within that limit:

- Linux raw ELF: 22,872 bytes
- Windows raw PE32+: 24,576 bytes

Source size is not bounded by this buffer because source is streamed through
DOS one byte at a time.

## Deliberately omitted behavior

Petit is stage-0 code, not a defensive general-purpose assembler. To remain at
254 bytes it intentionally omits:

- syntax diagnostics;
- undefined-symbol checks at `!`;
- duplicate-symbol diagnostics;
- output-overflow checks;
- DOS I/O error handling;
- lowercase hexadecimal;
- multi-character symbol names;
- arithmetic expressions;
- variable-width fixups;
- includes or macros;
- platform detection.

The checked-in `.pm` sources are generated and verified, so these omissions
reduce the trusted binary surface without weakening later Orgasm stages.

## Self-reproduction

From `stage0/` under DOS:

```bat
rebuild-petit.bat
```

That script performs:

```bat
petit.com < petit.pm > petit.next.com
fc /b petit.com petit.next.com
```

The files must compare equal and both must be exactly 254 bytes.

## Building Orgasm bootstraps

From `stage0/` under DOS:

```bat
build.bat
```

The script assembles the two platform-specific, uncompressed Orgasm sources:

```text
orgasm-linux-x86_64.pm
    -> ../bin/bootstrap/linux-x86_64/orgasm.elf

orgasm-windows-x86_64.pm
    -> ../bin/bootstrap/windows-x86_64/orgasm.exe
```

Petit remains platform-blind. The batch file selects a source by filename, and
the source itself contains the complete executable image.

A FruityOS `.pm` source is intentionally not included yet.

## Source readability conventions

The large Orgasm `.pm` files follow conventions intended to keep byte-level
source review practical:

- executable bytes are grouped by instruction;
- addresses and disassembly appear in comments;
- recognizable strings use quoted literals;
- headers and tables are grouped by structure;
- zero padding uses repetition directives;
- no compressed executable wrapper is embedded;
- the Linux and Windows files describe the raw, uncompressed inner binaries.

Petit ignores all comments, so explanatory detail has no cost in the generated
binary.
