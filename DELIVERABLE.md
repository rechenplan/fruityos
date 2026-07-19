# FruityOS Silent Mars Backend — Tested Deliverable

This source tree continues from the verified PC-relative Mars backend and removes Mars human-readable diagnostics. Mars is an opaque backend: it writes no diagnostics and reports success or failure through its process exit status. Haruka diagnostics remain unchanged.

Verified compressed FAP sizes:

- haruka.fap: 11,794 bytes
- mars.fap: 12,973 bytes
- jus.fap: 2,082 bytes

Verification completed on the exact source state packaged here:

- normal clean/full self-hosted build: passed (exit 0)
- Haruka semantic suite: 9/9 passed
- Haruka invalid-program rejection tests: passed
- standalone Sol parser suite: passed
- Mars two-way link suite: passed
- QEMU/OVMF UEFI boot: passed
- boot reached `Welcome to FruityOS 0.8.1!` and the `/>` prompt

The legacy Mars compactness assertion remains the known stale 47-byte output versus 41-byte expectation.

Constraints preserved:

- no new FAP files
- Haruka language frozen
- Sol language frozen
- checked-in JUS is the active compressor
- Juicer remains legacy and is not in the active build path
