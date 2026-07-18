# Verification

Source baseline: sol branch, commit 79485a2.

Change:
- Haruka compiler-internal persistent records are allocated from the existing monotonic heap.
- Constructor helpers are ordinary subroutines rather than lifted closure values.
- No Haruka input-language changes.
- No Sol language changes.
- No new FAP files.

Clean build:
- `bin/pish clean.psh`
- `bin/pish build.psh`
- Exit status: 0

Compressed FruityOS FAP sizes:
- Haruka: 12,150 bytes (baseline 13,246; reduction 1,096 bytes)
- Mars: 14,890 bytes (unchanged)

Haruka semantic tests:
- `haruka/tests/test-linux.sh haruka/out/linux-x86_64/haruka sol/mars/out/linux-x86_64/mars`
- Passed all execution and rejection cases.

QEMU UEFI boot:
- Image: `out/fruityos_uefi.img`
- Firmware: OVMF
- Port 0xE9 output:

```
U12345EHBooting...
Welcome to FruityOS 0.8.1!
/> 
```

Known baseline test issue:
- `sol/mars/tests/test-linux.sh` fails the compact.sol size assertion because Mars emits 47 bytes while the test expects 41.
- Mars is unchanged by this patch and its FruityOS FAP remains byte-for-byte the baseline size.
