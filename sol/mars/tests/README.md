# Mars tests

`semantics.sol` is an executable x86-64 conformance image based at
`0x100000000`. The Linux-only `harness.c` maps the raw image at that address,
calls it, and expects a zero result.

`multiple-first.sol`, `multiple-second.sol`, and `multiple-combined.sol` verify
that a split source stream has byte-identical layout to the concatenated form.
`data.sol` checks origin-sensitive alignment and data widths. `words.sol`
checks Mars resolution of word-scaled Sol constants. `compact.sol` fixes the
expected size of compact constants, zero-store runs, address relaxation, and
short relative branches.


`extern-first.sol` and `extern-second.sol` verify that an `extern` declaration
may be satisfied by a definition in a later input file. An external still
undefined after all inputs have been laid out is rejected.

Run the complete Linux backend suite with:

```text
sol/mars/tests/test-linux.sh /path/to/mars
```

The script checks executable semantics, word scaling, data layout, deterministic
output, multi-file equivalence, extern resolution, and 100,000-operation
streaming assembly.
