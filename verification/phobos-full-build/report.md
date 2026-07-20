# Phobos full-build verification

Date: 2026-07-20
Host: Linux x86-64
QEMU: 10.0.11
Firmware: `/usr/share/qemu/OVMF.fd`

## Result

The normal FruityOS build now uses Phobos as the Sol backend for all
Haruka-language final builds. Pulp and all Peel/Yuzu userland links invoke
Phobos explicitly. Mars remains a separate backend compiled from `sol/mars` by
Phobos; it is not copied from, renamed from, or aliased to Phobos.

Both `phobos.fap` and `mars.fap` are installed in the initrd.

## Build pipeline

1. Jabara and Orgasm establish the bootstrap surface.
2. Jabara creates bootstrap Haruka and bootstrap Phobos.
3. Bootstrap Haruka and Phobos self-build Phobos.
4. Phobos rebuilds Haruka.
5. Final Haruka and Phobos rebuild Phobos for Linux and FruityOS.
6. Phobos compiles Mars from its independent source tree.
7. Phobos compiles Pulp, Peel, Yuzu, and other Haruka-language components.
8. The root build stages the initrd and creates BIOS and UEFI images.

## Backend identity

| Artifact | Bytes | SHA-256 |
|---|---:|---|
| `bin/mars.elf` | 10,858 | `417cacdc3784313828fb4b33bd645750cb12dc43d85f19356bc1dd5116626d14` |
| `bin/phobos.elf` | 10,858 | `0afff36fd60290271f8dfad9de17b718023d4528c1cad03e821bc2f464c7fa11` |
| `bin/mars.fap` | 10,632 | `2c80dacfbeea3bec2f080c3a94d58fa0f4eb1d410d30d6e4c87d85e0335c0f18` |
| `bin/phobos.fap` | 10,632 | `678a8b997472de809ddfce50d53a623f8d613dd28a18e7028721703ff77626dc` |

The equal lengths do not indicate aliasing. `cmp` reports different bytes and
the hashes are different. `sol/mars` has no source changes relative to HEAD.

## Principal outputs

| Artifact | Bytes |
|---|---:|
| `pulp/out/fruityos-x86_64/pulp.sys` | 7,672 |
| `bin/haruka.fap` | 10,225 |
| `bin/phobos.fap` | 10,632 |
| `bin/mars.fap` | 10,632 |
| `out/fruityos.efi` | 250,880 |
| `out/fruityos_uefi.img` | 17,825,792 |

The FAP inventory increased from 69 to 72 paths. The only additions are the
normal generated copies of `phobos.fap`:

- `bin/phobos.fap`
- `initrd/bin/phobos.fap`
- `sol/phobos/out/fruityos-x86_64/phobos.fap`

No existing FAP path was removed.

## Tests

Passed:

- clean full build and a repeat full build;
- Phobos semantic, data, multi-file, external-symbol, deterministic, and
  100,000-operation streaming tests;
- Phobos/Orgasm mixed map and executable link test;
- Haruka positive and rejection tests through Phobos;
- Sol parser tests through the normal `jc.psh` Phobos path;
- Mars executable semantic cases and Mars/Orgasm mixed link test;
- QEMU/OVMF boot to the FruityOS 0.8.1 shell;
- execution of rebuilt `echo.fap` in QEMU;
- execution and return of installed `phobos.fap` in QEMU.

Final QEMU debug console:

```text
U12345EHBooting...
Welcome to FruityOS 0.8.1!
/> ok
/> />
```

The final prompt is the return from invoking `phobos` without arguments. No
`phobos?` command-not-found message was produced.

## Mars test note

The unchanged Mars source emits 44 bytes for `sol/mars/tests/compact.sol`, while
the checked-in Mars test asserts 41 bytes. The executable semantic cases pass.
Mars source and its test expectation were not modified. Phobos's own compact
fixture expects and receives 44 bytes.

## Documentation cleanup

Obsolete one-off delivery/status/inventory files and the superseded QEMU report
were removed. The maintained documentation now describes Phobos as the active
backend, Mars as an independent reference backend, the actual bootstrap order,
and the installed `phobos.fap`.
