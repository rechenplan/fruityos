# Gaia migration plan

The migration must preserve the existing stage0 trust chain while changing the
canonical assembly language. It cannot be done by flipping Jabara's emitter
first: the current Orgasm and the current Petit-generated seed understand only
the x86-like source dialect.

## Assembly inventory

The repository currently contains 22 `.asm` paths.

### Generated compiler image

These two files are byte-for-byte identical generated Jabara output and will be
regenerated as Gaia assembly after the emitter changes:

```text
jabara/src/jbc/jbc.asm
stage0/jbc.asm
```

`stage0/jbc.asm` remains the one checked-in compiler assembly required by the
stage0 reconstruction, but its language becomes Gaia.

### Platform start and runtime sources

```text
lib/fruityos-x86_64/fap-module-runtime.asm
lib/fruityos-x86_64/juicer-runtime.asm
lib/fruityos-x86_64/peel-runtime.asm
lib/fruityos-x86_64/peel-start.asm
lib/fruityos-x86_64/runtime.asm
lib/fruityos-x86_64/start.asm
lib/linux-x86_64/juicer-decode-stub.asm
lib/linux-x86_64/runtime.asm
lib/linux-x86_64/start.asm
lib/linux-x86_64/yuzu-runtime.asm
lib/linux-x86_64/yuzu-start.asm
lib/windows-x86_64/juicer-decode-stub.asm
lib/windows-x86_64/runtime.asm
lib/windows-x86_64/start.asm
```

Their ordinary logic must be rewritten in Gaia. Irreducible host entry and
system-interface fragments move behind Orgasm's x86 backend/runtime boundary.

### Kernel entry sources

```text
pulp/src/entry.asm
pulp/src/idt.asm
```

Most data movement and setup logic can become Gaia. x86 privilege transitions,
GDT/IDT loading, and interrupt returns cannot become Gaia core instructions;
they require x86 backend primitives or generated stubs at the platform boundary.
Native Gaia will use its own boot and interrupt design later.

### Seed and image sources

```text
seed/src/fdseed/fdseed.bytes.asm
seed/src/hdseed/hdseed.bytes.asm
seed/src/uefiseed/uefiseed-prefix.bytes.asm
seed/src/uefiseed/uefiseed.asm
```

The `.bytes.asm` files are primarily data images and should migrate to neutral
binary-data sources or Gaia data directives. The UEFI source mixes executable
x86 code and image layout; its code must move behind the x86 firmware backend
while its FAT/PE data construction remains assembler-time layout work.

## Ordered transition

### Phase 1: freeze the semantic audit

- Add Gaia documentation and compiler-output tests.
- Record every instruction and directive emitted by Jabara.
- Add generated-code histograms for immediates, frame offsets, branches, and
  instruction frequencies.

### Phase 2: teach Orgasm Gaia

- Add a Gaia lexer/parser and an internal Gaia operation representation.
- Add Gaia-to-x86-64 lowering.
- Keep the old x86 source parser temporarily so the current tree can build the
  transitional backend.
- Validate Gaia snippets against equivalent current x86 snippets.

At the end of this phase, existing Jabara still emits x86, but the newly built
Orgasm can assemble Gaia.

### Phase 3: rewrite the Jabara emitter

- Change `jabara/src/jc/emitter.jabara` to emit Gaia.
- Build that compiler with the old compiler and transitional Orgasm.
- Self-host Jabara once, then again, and require identical second-generation
  Gaia output.
- Regenerate `jabara/src/jbc/jbc.asm` and `stage0/jbc.asm` in Gaia syntax.

### Phase 4: rewrite handwritten assembly

Convert every ordinary `.asm` source in the inventory to Gaia. Move unavoidable
x86 boundary operations into explicit Orgasm backend/runtime facilities. Do not
solve migration failures by adding x86-shaped instructions to Gaia.

Validation should proceed component by component:

1. JBC and Orgasm;
2. Juicer and Concat;
3. Pish and Peel;
4. Yuzu;
5. Pulp user/kernel boundary;
6. BIOS and UEFI images.

### Phase 5: repair stage0

The old Petit-generated Orgasm seeds cannot assemble Gaia `jbc.asm`. Therefore:

1. build a Gaia-aware x86 Orgasm using the transitional trusted chain;
2. regenerate the readable `orglin.pm` and `orgwin.pm` seed images from those
   exact uncompressed binaries;
3. verify Petit reproduces both seeds exactly;
4. let the new seeds assemble Gaia `stage0/jbc.asm`;
5. retain the existing dependency order: seed Orgasm -> JBC -> current Orgasm ->
   everything else.

No second checked-in compiler assembly is introduced.

### Phase 6: implement the native Gaia assembler

- Parse the same Gaia source language.
- Resolve labels and choose the shortest immediate form.
- Emit native 16-bit parcels.
- Produce instruction and relocation histograms.
- Build JBC, Orgasm, Pish, and small tests for a software Gaia emulator before
  the FPGA core is required.

### Phase 7: FPGA execution

- Implement the v0 single-issue core.
- Boot a memory image containing a minimal Gaia runtime and Pish.
- Add memory-mapped console, timer, and storage one at a time.
- Add asynchronous interrupts only after polling execution is correct.

## Bootstrap invariant

At every commit there must be a complete path from the previous trusted binary
surface to the next one. We should never require a Gaia assembler to build the
first Gaia assembler, nor require a Gaia-speaking seed before one has been
produced and represented in Petit source.

## Completion criteria

The migration is complete when:

- Jabara emits no x86 syntax or raw instruction bytes;
- ordinary Orgasm source files contain Gaia code only;
- Orgasm and the Gaia assembler accept the same canonical source;
- Orgasm builds Linux, Windows, and FruityOS x86-64 binaries;
- the Gaia assembler builds semantically equivalent native images;
- stage0 reconstructs the host toolchain from `petit.com` and Gaia `jbc.asm`;
- second-generation Jabara and Orgasm builds are reproducible;
- the FPGA and a reference emulator agree instruction by instruction.
