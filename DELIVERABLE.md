# FruityOS `sol` best tested state

Base commit: `79485a25c94a0d252fe1791438f6a4b20035201f`

This tree combines:

1. checked-in `jus` bootstrap binaries for Linux, Windows, and FruityOS;
2. removal of checked-in Juicer executables and all active Juicer build/install steps;
3. canonical 11/5 JUS decoder selection in Jabara bootstrap links;
4. Haruka internal heap-backed constructors implemented as ordinary private subroutines.

Haruka and Sol language syntax/semantics are unchanged. No FAP file was added to the system tool set; `jus` replaces the legacy `juicer` bootstrap FAP.

## Verified compressed FAP sizes

- Haruka: 12,150 bytes (baseline 13,246; reduction 1,096)
- Mars: 14,890 bytes (unchanged)
- JUS: 2,082 bytes

## Verification

- clean full Linux-hosted build: passed
- Haruka semantic execution suite: 9/9 passed
- Sol parser suite: passed
- Mars link suite: passed
- QEMU 10.0.11 + OVMF UEFI boot: passed
- observed boot log:

```
U12345EHBooting...
Welcome to FruityOS 0.8.1!
/>
```

The legacy Mars test script remains nonzero after printing `result=42` because its compact-output assertion expects 41 bytes while the unchanged compiler emits 47 bytes. This discrepancy exists independently of these changes.

Juicer source and decoder filenames remain for historical/reference and stream-format implementation purposes, but no active build path invokes or installs a Juicer executable.
