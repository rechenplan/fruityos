# Gaia assembly language

Gaia assembly is Jabara's canonical compiler output. The language is shared by
both backends:

- Orgasm lowers it to x86-64 machine code and host executable containers;
- the Gaia assembler encodes it into native Gaia parcels.

The syntax is intentionally small and does not expose x86 register widths,
addressing prefixes, condition flags, or implicit operands.

## Registers

```text
z  a  b  c  d  fp  sp  ip
```

Register names are case insensitive in source, but generated output uses lower
case.

## Instructions

Three-operand arithmetic is written directly:

```text
add a, b, c
sub d, a, 1
mul a, a, b
lt  c, a, 0
```

Loads and stores make the access width explicit:

```text
ld  a, [fp + 16]
st  [a + 8], d
ldb b, [a + c]
stb [a], b
```

The omitted offset is zero. The omitted base in a relative symbol reference is
`ip`:

```text
ld   a, [rel global_value]
st   [rel global_value], a
call worker
jmp  loop
bz   a, done
bnz  b, again
```

Indirect control flow names a register:

```text
call a
jmp  d
```

Stack and frame operations are:

```text
push a
push 16
pop  b
enter 32
ret  16
```

## Labels and symbols

```text
global add_one

add_one:
    enter 0
    ld  a, [fp + 16]
    add a, a, 1
    ret 8
```

A symbol used as a value denotes its address. The preferred readable form is the
`addr` pseudo-instruction:

```text
addr a, message
```

It expands to an `add` using `ip` and a relocated displacement. A backend may
select any equivalent native sequence.

## Pseudo-instructions

Pseudo-instructions improve generated and handwritten source without extending
the processor.

| Pseudo | Expansion |
| --- | --- |
| `addr r, symbol` | `add r, ip, rel symbol` |
| `neg r, x` | `sub r, z, x` |
| `not r, x` | `xor r, x, -1` |
| `bool r, x` | `ne r, x, z` |
| `nop` | `mov z, z` |

`call symbol`, `jmp symbol`, `bz r, symbol`, and `bnz r, symbol` are assembly
forms of the architectural base-plus-offset control instructions.

## Data and layout directives

The common source language retains assembler directives needed by Jabara and
the runtime sources:

```text
global name
extern name
align boundary
db byte, byte, ...
dw halfword, ...
dd word, ...
dq doubleword, ...
```

`db`, `dw`, `dd`, and `dq` emit 8-, 16-, 32-, and 64-bit little-endian values.
They are layout directives, not processor instructions.

Orgasm's include and conditional-definition facilities remain source-processing
features. Jabara may continue to emit definitions such as `PITH_name` to select
runtime fragments, but those definitions do not become Gaia opcodes.

## Example translation

Current Jabara x86-like output:

```text
    db 200
    dw 16
    db 0
    mov rax, [rbp + 16]
    add rax, 1
    cmp rax, 10
    jge done
    movzx eax, byte [rax]
done:
    db 201
    db 194
    dw 8
```

Canonical Gaia output:

```text
    enter 16
    ld    a, [fp + 16]
    add   a, a, 1
    ge    b, a, 10
    bnz   b, done
    ldb   a, [a]
done:
    ret   8
```

The Gaia form states the program's dataflow directly. It contains no raw x86
opcode bytes, partial registers, flags dependency, or hidden frame teardown.

## Source restrictions

Canonical Gaia assembly does not permit:

- x86 register names;
- implicit operand sizes such as `qword` or `byte` attached to `mov`;
- raw instruction bytes used to smuggle in `enter`, `leave`, or `ret n`;
- `cmp`, `test`, `setcc`, or condition-code branches;
- x86-only instructions;
- assumptions about ELF, PE32+, FAP, BIOS, UEFI, Linux, or Windows.

Container and platform layout may still use data directives and backend scripts,
but executable code in ordinary `.asm` files should be Gaia code.
