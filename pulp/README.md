# Pulp

Pulp is the FruityOS monolithic x86-64 kernel. It is written primarily in
Jabara, with assembly for the entry table, interrupt stubs, descriptor loading,
and privilege transitions.

The host build compiles Pulp as a headerless Jabara module, assembles
`bin/pulp.bin`, and compresses it to `bin/pulp.sys`. Seed loads the kernel at
physical `0x10000`; the first 256 bytes are the system-call dispatch table and
execution begins at `0x10100`.

Pulp provides paging, ring-3 FAP execution, GDT/TSS/IDT setup, fixed-block
allocation, a volatile hierarchical RAMFS, VGA text output, PS/2 input, and the
`int 0x84` system-call interface.

See [Kernel architecture](../docs/kernel.md) for initialization and memory
layout, and [System-call ABI](../docs/system-calls.md) for the application
interface.
