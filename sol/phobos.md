# Phobos

Phobos is the preserved hybrid threaded-native x86-64 backend snapshot derived
from Mars. Its implementation lives in [`phobos/`](phobos/README.md).

It is intentionally outside the normal FruityOS build and initrd. This keeps
Phobos available for comparison and reuse without introducing another `.fap`
into the operating-system image.
