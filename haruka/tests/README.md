# Haruka tests

The tests compile Jabara-language source through Haruka, assemble the generated
Sol through Mars, map the raw image at its declared origin, and execute it.

The positive suite covers:

- ordinary locals and arithmetic;
- `new Record` construction and tagged field access;
- shallow lift into an enclosing `sub`;
- pointer preservation within a shallow copy;
- repeated lift across nested `fn` boundaries;
- lifted closures with mutable captured state;
- a lifted closure that later creates and lifts another record;
- two- and three-argument currying.

The negative suite rejects lift in a named `sub`, lift of a captured outer
binding, and old `Record()` constructor syntax.

Tests use the production width-neutral runtime at `../runtime.sol`.
