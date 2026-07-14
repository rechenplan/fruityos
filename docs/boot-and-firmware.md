# Boot and firmware

FruityOS has independent legacy BIOS and x86-64 UEFI entry paths. Both paths
produce the same handoff to Pulp: the kernel is decompressed at physical
`0x10000`, execution begins at `0x10100`, and `RSI` points to the initrd Jar.

## BIOS image layout

`fruityos_hdd.img` has no conventional filesystem.

| Image offset | Contents |
| --- | --- |
| `0x00000` | 512-byte `hdseed` sector with boot signature. |
| `0x00200` | Juicer-compressed kernel, `pulp.sys`. |
| after `pulp.sys` | Uncompressed Jar archive containing the initrd. |
| through `0xfffff` | Zero padding to the fixed 1 MiB image size. |

The padding is functional: `hdseed` reads 2047 payload sectors through the
primary ATA controller. The host build reports the unpadded size, rejects a
payload larger than 1 MiB, and pads valid images to exactly 1 MiB.

## BIOS startup

Firmware loads sector zero at `0x7c00`. `hdseed` then:

1. copies the boot sector to physical `0x40000` using an extended disk-address
   packet so its temporary GDT remains available;
2. enables A20;
3. creates temporary four-level page tables beginning at `0x1000`;
4. loads a temporary GDT, enables PAE and long mode, and performs a far jump to
   64-bit code;
5. reads the complete padded disk payload to physical `0x300000` with LBA28
   PIO through the primary ATA controller;
6. remaps the legacy PIC;
7. expands the Juicer kernel stream at `0x10000`;
8. leaves `RSI` at the following initrd Jar and jumps to `0x10100`.

The kernel's first 256 bytes are the system-call function-pointer table. That is
why the executable entry is exactly `kernel + 0x100` rather than the beginning
of the decompressed image.

## Standalone EFI application

`seed/src/uefiseed/uefiseed.asm` emits a dependency-free PE32+ EFI application.
The source defines its DOS header, PE signature, AMD64 COFF header, PE32+
optional header, `.text`, `.data`, and `.reloc` sections, and a real DIR64 base
relocation. Code and data use separate permissions, and the image declares the
EFI application subsystem.

The application embeds both `pulp.sys` and `initrd.jar`. Its EFI entry follows
the Microsoft x64 calling convention used by x86-64 UEFI: `RCX` contains the
image handle and `RDX` the system table. Calls reserve shadow space and preserve
the required nonvolatile registers.

Before leaving firmware services, UEFI Seed:

1. prints a loading message through `EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL`;
2. reserves FruityOS's fixed kernel, paging, heap, and initrd regions with
   `AllocatePages(AllocateAddress, EfiLoaderData, ...)`;
3. decompresses Pulp to `0x10000` and copies the initrd to `0x700000`;
4. obtains a current memory-map key and calls `ExitBootServices`, retrying when
   the key changes;
5. creates a temporary identity mapping for the first 4 GiB;
6. restores legacy PIC routing and VGA text registers, font, and palette;
7. sets `RSP` to `0x40000`, `RSI` to `0x700000`, and jumps to `0x10100`.

Progress characters are also written to debug port `0xE9`. QEMU can expose
those characters with `-debugcon stdio`, which distinguishes firmware loading,
allocation, boot-service exit, and kernel entry even when VGA is unavailable.

## UEFI disk image

The same assembly source has a packaging mode that emits
`fruityos_uefi.img`. It contains:

- an MBR partition entry of type `0xEF` beginning at LBA 2048;
- a 16 MiB FAT16 EFI system partition;
- two FAT copies and a fixed root directory;
- `EFI/BOOT/BOOTX64.EFI`, containing the standalone application.

The path is the standard x86-64 removable-media fallback. The application can
also be copied to an existing EFI system partition and registered with the
machine's boot manager.

## Physical-machine requirements

The generated application is not signed. Disable Secure Boot or sign it with a
trusted key. Once boot services have exited, FruityOS does not use GOP or UEFI
input protocols: it assumes VGA-compatible text hardware and a PS/2-compatible
keyboard controller. Many virtual machines emulate both; some modern physical
systems do not.

The loader requests fixed low physical ranges because Pulp is linked around
those addresses. Firmware that marks a required range unavailable will receive
the visible `fixed memory is unavailable` diagnostic rather than allowing the
kernel to overwrite firmware-owned memory.
