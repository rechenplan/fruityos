# Toolchain status

The current tree contains:

- Jabara and Orgasm as the preserved bootstrap compiler/assembler pair;
- Haruka as the default `.hr` frontend;
- the generic streaming Sol parser written in Haruka;
- Mars, the Haruka-written x86-64 flat-binary backend;
- shared Haruka runtime support in `lib/haruka-runtime.sol`;
- Sol, Pluto, Mars, Luna/Terra, Haruka, and migration documentation.

The default `bin/jc.psh` path is:

```text
.hr source -> Haruka -> Sol -> Mars + Orgasm platform prefix -> executable
```

The separate `bin/jb.psh` path is retained only for `.jabara` bootstrap inputs.
JBC creates the first Jabara compiler; one current Jabara generation then builds
Orgasm and the bootstrap Haruka/Mars tools. Haruka and Mars subsequently rebuild
themselves and the rest of the tree through the default path.

Validated on Linux x86-64:

- clean legacy bootstrap through JBC, Jabara, and Orgasm;
- Haruka and Mars bootstrap, self-build, and repeated self-host execution;
- Haruka locals, records, lift, closures, nested lifted closures, and currying;
- Mars semantic, deterministic-output, stress, extern, data, and compactness tests;
- two-way Mars/Orgasm symbol-map linking;
- canonical 11/5 Juicer encode/decode round trips and JUS hash-chain compression;
- all 18 Peel host and FruityOS applications through Haruka/Mars;
- Linux ELF, FruityOS FAP, and Windows PE32+ default linker outputs;
- complete BIOS HDD, BIOS floppy, EFI application, and UEFI image production;
- QEMU boots of the standard HDD and floppy images to the FruityOS prompt.

OS build integration:

- Pulp compiles through Haruka and Mars while retaining Orgasm for its handwritten
  x86-64 prefix;
- Mars and Orgasm exchange absolute `equ` maps for two-way references;
- the Orgasm prefix is capped at 4,608 bytes and Mars begins at `0x11200`;
- the Juicer-compressed `pulp.sys` remains below its 8 KiB limit;
- FruityOS Jabara, Haruka, Mars, drivers, runtimes, and both `.hr` and legacy
  Pith surfaces are installed in the initrd;
- the floppy loader reads 19 cylinders into `0x40000`-`0x957ff`, retaining the
  known-good BIOS load geometry and a 1.44 MiB image.

Size constraints:

- Haruka FruityOS FAP: 13,558 bytes;
- Mars FruityOS FAP: 15,167 bytes;
- the root build rejects either compiler FAP above 16,384 bytes;
- the reduction comes from selecting direct or closure frames per function, so
  ordinary functions no longer pay closure-environment overhead merely because
  another function in the program creates a closure.
