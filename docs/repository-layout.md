# Repository layout

FruityOS keeps each subsystem in its own directory. Components build locally
beneath `out/<platform>/`; the repository root coordinates them and produces the
final boot images.

## Source tree

| Path | Contents |
| --- | --- |
| `stage0/` | Petit, the seed Orgasm byte sources, `jbc.asm`, and the complete bootstrap reconstruction scripts. |
| `bin/` | Checked-in Pish entrypoints, compiler drivers, and launchers for the populated host bootstrap tools. |
| `lib/<platform>/` | Pith declarations, executable headers, startup code, runtime assembly, and platform linker scripts. |
| `jabara/` | The Jabara compiler, Orgasm assembler, tests, and Jabara language manual. |
| `yuzu/` | The Yuzu compiler, bytecode compiler, and Zest assembler. |
| `peel/` | Pish and the Jabara-written host and FruityOS userland. |
| `seed/` | BIOS and x86-64 UEFI bootloaders. |
| `pulp/` | The FruityOS kernel. |
| `scripts/` | Files copied to the root of the initial RAM filesystem. |
| `docs/` | Integrated build, kernel, firmware, ABI, and development documentation. |

## Bootstrap files

The irreducible executable is `stage0/petit.com`. The larger files under
`bin/bootstrap/<platform>/` are generated bootstrap artifacts retained so the
normal build can start directly on each supported host.

The launchers in `bin/` resolve the bootstrap tool for the active platform:

```text
bin/orgasm.psh
bin/jus.psh
bin/concat.psh
```

The common compiler driver and its thin platform selectors are:

```text
bin/jb.psh
bin/jc.psh
bin/jc-linux-x86_64.psh
bin/jc-windows-x86_64.psh
bin/jc-fruityos-x86_64.psh
```

See [Stage 0](../stage0/README.md) for the exact trust chain and
[Toolchains](toolchain.md) for the compiler interfaces.

## Component outputs

Each component writes only beneath its own `out/<platform>/` directory. Native
program suffixes identify their target:

| Platform | Suffix |
| --- | --- |
| Linux x86-64 | `.elf` |
| Windows x86-64 | `.exe` |
| FruityOS x86-64 | `.fap` |

Important generated paths include:

| Path | Contents |
| --- | --- |
| `jabara/out/<platform>/` | Published Jabara compiler and Orgasm artifacts. |
| `peel/out/<platform>/` | Pish and Peel tools for the selected platform. |
| `yuzu/out/<platform>/` | `byc`, `yc`, and `zest`. |
| `pulp/out/fruityos-x86_64/pulp.sys` | Juicer-compressed Pulp kernel. |
| `initrd/` | Temporary initial-RAM-filesystem staging tree. |

## Final images

The root build writes:

| Path | Description |
| --- | --- |
| `out/fruityos_hdd.img` | 1 MiB BIOS hard-disk image. |
| `out/fruityos_floppy.img` | 1.44 MiB BIOS floppy image. |
| `out/fruityos_uefi.img` | UEFI disk image with a FAT16 EFI system partition. |
| `out/fruityos.efi` | Standalone x86-64 PE32+ EFI application. |

The root `out/` directory contains final distributable images. Component-local
`out/` directories contain intermediate and published tools.
