# Verification

## Phobos preservation

- `sol/phobos/*.hr` matches the retained `sol/mars/*.hr` source files byte for
  byte.
- Phobos-specific changes are limited to project naming, output names,
  documentation, and copied test expectations.
- Linux host build command: `bin/pish build-phobos.psh`.
- Produced executable: `bin/phobos.elf`.

## Phobos tests

Passed:

- Sol arithmetic and semantic execution fixtures;
- word-width fixture;
- compact threaded fixture;
- multi-file equivalence;
- external symbol resolution and unresolved-symbol rejection;
- data layout;
- deterministic repeat assembly;
- 100,000-operation streaming stress fixture;
- mixed Orgasm/Phobos map and image link test.

## FruityOS build

- Normal persistent command: `bin/pish build.psh`.
- Exit status: 0.
- `.fap` paths before Phobos preservation: 69.
- `.fap` paths after Phobos preservation: 69.
- New `.fap` paths: 0.
- Removed `.fap` paths: 0.

## Boot test

QEMU boot was not run because `qemu-system-x86_64` and OVMF firmware are not
installed in this environment.
