# FruityOS Sol: JUS-aware PC-relative Mars backend

This tree continues from the verified JUS-only, Haruka heap-constructor, and Mars heap-constructor baseline.

## Changes

Mars now uses RIP-relative address materialization for internal labels and virtual instruction-pointer values where safe. Absolute materialization remains for externals and explicit absolute constants.

Haruka and Sol input languages are unchanged. No FAP files were added.

## Verified compressed sizes

- `haruka.fap`: 11,794 bytes
- `mars.fap`: 14,284 bytes
- `jus.fap`: 2,082 bytes

Relative to the preceding verified Mars-heap baseline:

- Haruka: -356 bytes
- Mars: -103 bytes

## Verification

- Normal repository clean/full build completed with exit code 0.
- Haruka semantic suite passed 9/9.
- Haruka invalid-program rejection tests passed.
- Standalone Sol parser suite passed.
- Mars two-way link suite passed.
- QEMU/OVMF boot of the exact generated image reached the FruityOS 0.8.1 shell prompt.

The legacy Mars compactness assertion remains the pre-existing 47-byte output versus stale 41-byte expectation.
