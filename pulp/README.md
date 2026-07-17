# Pulp

Pulp is the FruityOS monolithic x86-64 kernel. It is written primarily in
Jabara, with assembly for the dispatch table, entry sequence, interrupt stubs,
descriptor loading, and privilege transitions.

## Build

The root Pish build runs `pulp/build.psh fruityos-x86_64`. The build has two
flat regions:

- Haruka compiles the `.hr` kernel to Sol, and Mars emits the region
  beginning at `0x11200`.
- Orgasm assembles the syscall table, entry path, interrupt code, x86 helpers,
  and Juicer runtime into the 4,608-byte region beginning at `0x10000`.

Mars first exports generated symbols for Orgasm. Orgasm then exports handwritten
symbols for the final Mars pass. The assembly prefix is size-checked, padded to
exactly 4,608 bytes, and concatenated with the Mars output. The build writes:

- `pulp/out/fruityos-x86_64/pulp.bin`, the flat kernel image;
- `pulp/out/fruityos-x86_64/pulp.sys`, the Juicer-compressed image loaded by Seed.

`pulp.sys` must fit within 8 KiB. Seed loads the flat kernel at physical
`0x10000`; execution begins at `0x10100`. The generated Sol region begins at
`0x11200`.

See [Kernel architecture](../docs/kernel.md) and
[System-call ABI](../docs/system-calls.md).
