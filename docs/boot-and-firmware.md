# Boot and firmware

FruityOS has BIOS hard-disk, BIOS floppy, and x86-64 UEFI entry paths. Every
path decompresses Pulp at physical `0x10000`, enters it at `0x10100`, disables
interrupts before handoff, and places the initrd Jar pointer in `RSI`.

## BIOS hard-disk image

`out/fruityos_hdd.img` has no conventional filesystem.

| Image offset | Contents |
| --- | --- |
| `0x00000` | 512-byte `hdseed` sector with the boot signature. |
| `0x00200` | Initrd Jar containing `/pulp.sys`. |
| through `0xfffff` | Zero padding to 1 MiB. |

`hdseed` reads the padded payload through the primary ATA controller. The host
build rejects an unpadded image larger than 1 MiB.

Firmware loads sector zero at `0x7c00`. The loader then:

1. relocates the boot sector to physical `0x40000`;
2. enables A20;
3. creates temporary four-level page tables beginning at `0x1000`;
4. loads a temporary GDT and enters 64-bit mode;
5. reads the disk payload to physical `0x300000` with LBA28 PIO;
6. scans the Jar entries for `./pulp.sys`;
7. expands the Juicer stream at `0x10000`;
8. restores `RSI` to the Jar start and jumps to `0x10100`.

The first 256 kernel bytes are the system-call dispatch table, so executable
entry is `kernel + 0x100`.

## BIOS floppy image

`out/fruityos_floppy.img` is a 1.44 MiB image containing `fdseed`, the same
initrd Jar, and zero padding. The loader reads the first 22 cylinders into physical `0x20000` through
`0x82fff`, scans the archive for `/pulp.sys`, decompresses it, and hands the
archive to Pulp. Its stack begins at `0x90000`; the host build limits the boot
payload to 405,504 bytes.

## Standalone EFI application

`seed/src/uefiseed/uefiseed.asm` defines the dependency-free x86-64 PE32+ EFI
application. The Pish build assembles the checked-in Orgasm byte source
`uefiseed-prefix.bytes.asm`, then the Peel `uefi` command inserts the current
initrd and writes the final section sizes, offsets, and relocation block. The
image contains DOS, AMD64 COFF, PE32+ optional, `.text`, `.data`, and `.reloc`
headers with separate code and data permissions.

The application embeds the initrd Jar. `/pulp.sys` remains an ordinary archive
entry. The EFI entry uses the Microsoft x64 calling convention: `RCX` contains
the image handle and `RDX` contains the system table.

Before entering Pulp, UEFI Seed:

1. prints a loading message through `EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL`;
2. reserves the fixed kernel, paging, heap, and initrd ranges with
   `AllocatePages(AllocateAddress, EfiLoaderData, ...)`;
3. copies the initrd to `0x2000000`;
4. locates `/pulp.sys` and decompresses it to `0x10000`;
5. obtains a memory-map key and calls `ExitBootServices`, retrying when needed;
6. creates a temporary identity mapping for the first 4 GiB;
7. restores VGA text registers, font, and palette;
8. sets `RSP` to `0x40000`, sets `RSI` to `0x2000000`, and jumps to `0x10100`.

Progress characters are also written to I/O port `0xE9`.

## UEFI disk image

`out/fruityos_uefi.img` contains:

- an MBR partition entry of type `0xEF` beginning at LBA 2048;
- a 16 MiB FAT16 EFI system partition;
- two FAT copies and a fixed root directory;
- `EFI/BOOT/BOOTX64.EFI`.

The same application is written separately as `out/fruityos.efi`.

## Debug console

QEMU can expose UEFI and kernel progress output from port `0xE9`:

```sh
OVMF=/path/to/OVMF.fd
qemu-system-x86_64 \
  -m 512 \
  -bios "$OVMF" \
  -drive format=raw,file=out/fruityos_uefi.img \
  -display none \
  -serial none \
  -debugcon stdio \
  -no-reboot
```

## Hardware requirements

The EFI application is unsigned. Disable Secure Boot or sign it with a trusted
key. After firmware services end, FruityOS assumes VGA-compatible text output
and a PS/2-compatible keyboard controller.

The UEFI loader requests fixed physical ranges because Pulp is linked around
those addresses. It prints `fixed memory is unavailable` when firmware cannot
reserve a required range.
