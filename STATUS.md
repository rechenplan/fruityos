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
- literal Juicer encode/decode round trips;
- all 18 Peel host and FruityOS applications through Haruka/Mars;
- Linux ELF, FruityOS FAP, and Windows PE32+ default linker outputs;
- complete BIOS HDD, BIOS floppy, EFI application, and UEFI image production.

OS build integration:

- Pulp compiles through Haruka and Mars while retaining Orgasm for its handwritten
  x86-64 prefix;
- Mars and Orgasm exchange absolute `equ` maps for two-way references;
- the Orgasm prefix is capped at 4,608 bytes and Mars begins at `0x11200`;
- the Juicer-compressed `pulp.sys` remains below its 8 KiB limit;
- FruityOS Jabara, Haruka, Mars, drivers, runtimes, and both `.hr` and legacy
  Pith surfaces are installed in the initrd;
- the floppy loader reads 22 cylinders into `0x20000`-`0x82fff`, allowing the
  expanded toolchain initrd while retaining a 1.44 MiB image.
