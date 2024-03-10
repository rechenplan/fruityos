# pulp

a smol kernel. clone this repository along side yuzu, seed, and peel. follow compilation instructions for all other repositories, then run build.sh in this repository. this will create bin/kernel.img which is a bootable floppy image. under linux, burn to floppy with dd if=kernel.img of=/dev/fd0.

## ideas

instead of using interrupts for syscalls, run everything in ring 0 in the same memory space and provide a table at $7000 containing addresses of os functions that can be used by programs. this would be single tasking (currently running program loaded at $2000000). exit() loads the shell.
