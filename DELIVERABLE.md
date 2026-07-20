# FruityOS with preserved Phobos backend

This archive contains the complete radical threaded-control FruityOS tree and
an independently maintained copy of that Mars implementation under
`sol/phobos/`.

Phobos:

- preserves the retained Mars Haruka sources byte-for-byte;
- builds independently with `bin/pish build-phobos.psh`;
- installs the Linux host executable as `bin/phobos.elf`;
- is not part of the normal FruityOS build or initrd;
- introduces no new `.fap` files.

The normal FruityOS build continues to use `sol/mars/` and retains the same 69
`.fap` paths.
