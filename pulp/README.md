# Pulp

Pulp is the FruityOS monolithic x86-64 kernel. It is written primarily in
Jabara, with assembly for the dispatch table, entry sequence, interrupt stubs,
descriptor loading, and privilege transitions.

## Build

```sh
./build.sh
```

The script compiles every `src/*.jabara` file as one module, assembles it with
`src/entry.asm`, `src/idt.asm`, and Jabara's Juicer runtime, then writes:

- `bin/pulp.bin`, the flat kernel image;
- `bin/pulp.sys`, the Juicer-compressed image loaded by Seed.

`pulp.sys` must fit within 8 KiB. Seed loads the flat kernel at physical
`0x10000`. The first 256 bytes are the system-call dispatch table, and execution
begins at `0x10100`.

Pulp provides paging, ring-3 FAP execution, GDT/TSS/IDT setup, fixed-block
allocation, volatile RAMFS, VGA text output, PS/2 input, and the `int 0x84`
system-call interface.

See [Kernel architecture](../docs/kernel.md) and
[System-call ABI](../docs/system-calls.md).
