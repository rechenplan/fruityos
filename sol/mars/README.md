# Mars

Mars is the x86-64 flat-binary backend for Sol. It is written in Haruka and
consumes the shared parser in `../parser`.

```text
mars input.sol [input.sol ...] output.bin
```

Mars repeatedly lays out the same lazy parser stream until compact relative
branches and address encodings stabilize, then performs one emission pass.
Raw x86-64 bytes are written directly; no assembly-language intermediate is
produced.

Mars selects a 64-bit little-endian Sol profile. Sol registers are realized as:

```text
a = rax   b = rbx   c = rcx   d = rdx
fp = rbp  sp = rsp
```

`z` is synthesized as zero and discarded on write. `ip` is synthesized as the
address of the next lowered Sol operation. Backend-private work uses `r8`
through `r11`. Mars retains a private zero value across uninterrupted runs of
zero stores, but invalidates that knowledge at labels and control-flow edges.

The output is a flat image. `org` assigns target addresses but does not pad the
file to that address. Unresolved externals are rejected because Mars does not
produce an object file or relocation table.
