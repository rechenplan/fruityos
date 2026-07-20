# Phobos x86-64 backend

Phobos is the production x86-64 flat-binary backend for Sol. It is implemented
in Haruka under [`phobos/`](phobos/README.md) and is invoked by every normal
Haruka-language native and cross-target build.

Mars remains a separate reference backend under `sol/mars`. Both backends obey
the same command and map-file contract, but each is compiled from its own
source and installed independently. The FruityOS initrd contains both
`phobos.fap` and `mars.fap`; compiler linker scripts select Phobos.
