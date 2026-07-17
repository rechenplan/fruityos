# Sol project status

The current tree contains:

- the generic streaming Sol parser written in Jabara;
- Mars, the direct x86-64 flat-binary backend;
- Haruka, a separate compiler for the Jabara language that emits Sol;
- the shared stack-region allocation and `lift` model in Jabara and Haruka;
- Sol, Pluto, Mars, Luna/Terra, Haruka, and migration documentation.

Peel remains on its existing Orgasm build path and has not been modified for
Sol.

Validated on Linux x86-64:

- byte-identical two-generation Jabara self-host;
- Jabara compiler compressed below 16 KiB;
- native `new Record` and shallow `lift var` lifetime tests;
- parser structural, malformed-input, complete-operation, word-literal, and
  100,000-operation streaming tests;
- executable Mars semantic conformance image;
- byte-identical split/combined multi-file assembly;
- cross-file extern definition and unresolved-extern rejection;
- Haruka locals, records, lift, closures, nested lifted closures, and currying
  through Mars.

`lift var` is implemented in both Jabara and Haruka. It is valid only in an
`fn`, accepts only a variable declared in that `fn` scope, performs one shallow
promotion into the closure's lexical owner frame, returns the promoted copy,
and leaves the original binding unchanged.

OS build integration:

- Pulp now compiles through Haruka and Mars while retaining Orgasm for the
  handwritten x86-64 prefix.
- Mars and Orgasm exchange absolute `equ` maps for two-way references.
- The Orgasm prefix is capped at 4,608 bytes and Mars begins at `0x11200`.
- The resulting Juicer-compressed `pulp.sys` is 7,908 bytes in the current tree.
- FruityOS Haruka and Mars executables are installed in the initrd.
