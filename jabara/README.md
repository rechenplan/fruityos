# Jabara

This directory follows Yuzu's bootstrap layout. The small ANSI C bootstrap
compiler lives in `src/jbc` and builds as `bin/jbc`; the self-hosted compiler
lives in `src/jc` and builds as `bin/jc` and `bin/jc-self`. The bootstrap
compiler
keeps yuzu's x86-64 NASM output and SysV `sub` ABI, and adds initialized local
declarations plus anonymous lexical closures.

Language features:

* `fn argument do ... end` creates a closure.
* `local x = expression` initializes a local; comma-separated declarations may
  each have an initializer.
* `record Name field, field:Tag` declares a heap-allocated record with
  comma-separated, word-sized fields. The declaration ends with the last CSV
  field, independent of whitespace or line breaks. `Name()` constructs a
  zero-initialized record. A variable or record field tagged as `name:Name`
  supports `value.field` reads and assignments. Tags exist only at compile
  time; untagged variables and fields are words.
* A call through a local or captured name dispatches its two-word closure
  (`code`, `context`). Named `sub` routines are direct-call only; wrap a call
  in `fn` when a routine must be used as a value.
* `extern sub name(parameters)` declares a direct SysV routine supplied by the
  runtime or linked assembly. `lib/pith.jabara` declares the standard Pith
  routines.
* Every program must declare `sub main`. Program-scope statements, when
  present, run at the start of that explicit `main`.

Closures use heap-backed lexical environments, so an escaping closure retains
its captured variables and sibling closures observe subsequent assignments.

For example:

    record Pair left, right

    local pair:Pair = Pair()
    pair.left = 20
    pair.right = 22

Build and test with:

    cd jabara
    ./build.sh
    ./test.sh

The build first produces `jbc`, uses it to compile `jc`, and then uses `jc` to
compile itself again. The test target exercises both Jabara compilers and the
Yuzu compatibility path.
