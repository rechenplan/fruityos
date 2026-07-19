# Verified FruityOS Sol checkpoint

This archive contains the tested JUS-only, Haruka heap-constructor,
Mars heap-constructor, RIP-relative, silent-backend tree with Mars parser
message and item/pending location metadata removed.

Verified compressed FAP sizes:

- haruka.fap: 11,794 bytes
- mars.fap: 11,981 bytes
- jus.fap: 2,076 bytes in the completed build

Verification performed on the exact source tree before packaging:

- normal persistent full self-hosted build completed with exit code 0;
- Haruka semantic suite passed;
- Haruka invalid-program rejection passed;
- standalone Sol parser suite passed after removal of the obsolete location-metadata assertion;
- Mars two-way link/semantic tests passed;
- QEMU/OVMF boot reached FruityOS 0.8.1 and the `/>` shell prompt on the preceding 12,157-byte checkpoint; the 11,981-byte checkpoint completed the full build successfully and was frozen before the next lexer-location pass.

Haruka diagnostics remain intact. Mars is a silent black-box backend: success/failure
is reported through its exit status rather than human-readable diagnostics.

No Haruka or Sol language changes were made, and no new FAP files were introduced.
