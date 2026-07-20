# Phobos

Phobos is FruityOS's active x86-64 flat-binary backend for Sol. It is derived
from Mars but maintained as an independent source tree and executable.

Phobos keeps the internal `mars_*` implementation identifiers so backend diffs
remain small and mechanically reviewable. This does not make the executables
aliases: `sol/phobos` and `sol/mars` are compiled separately from their own
sources and installed as `phobos` and `mars`.

```text
phobos input.sol [input.sol ...] output.bin
phobos -o ORIGIN input.sol [input.sol ...] output.bin
phobos -o ORIGIN -M output.map input.sol [input.sol ...]
```

The normal root build bootstraps Phobos with Jabara, immediately self-rebuilds
it through Haruka -> Sol -> Phobos, rebuilds Haruka, and then performs a final
Phobos self-build. All later Haruka-language components use Phobos through the
platform linker scripts.

Host and FruityOS outputs are published as:

```text
bin/phobos.elf
bin/phobos.fap
sol/phobos/out/<platform>/phobos.<suffix>
```

`phobos.fap` is copied into the initrd beside the independently built
`mars.fap`.

## Backend distinction

The retained Phobos-specific change initializes its shared semantic handlers
with compact RIP-relative `lea` instructions. Mars retains its own committed
absolute-address initialization. Further backend experiments must be made only
in the intended source tree; never copy one backend binary over the other.
