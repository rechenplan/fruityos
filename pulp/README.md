# Pulp

Pulp is the FruityOS monolithic x86-64 kernel. It is written primarily in
Jabara, with assembly for the dispatch table, entry sequence, interrupt stubs,
descriptor loading, and privilege transitions.

## Build

The root Pish build runs `pulp/build.psh fruityos-x86_64`. It compiles the
kernel as one Jabara module, assembles it with the entry and interrupt assembly,
and writes:

- `pulp/out/fruityos-x86_64/pulp.bin`, the flat kernel image;
- `pulp/out/fruityos-x86_64/pulp.sys`, the Juicer-compressed image loaded by Seed.

`pulp.sys` must fit within 8 KiB. Seed loads the flat kernel at physical
`0x10000`; execution begins at `0x10100`.

See [Kernel architecture](../docs/kernel.md) and
[System-call ABI](../docs/system-calls.md).
