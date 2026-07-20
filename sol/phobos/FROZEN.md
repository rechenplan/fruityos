# Phobos maintenance boundary

Phobos began as the preserved radical threaded-control backend and is now the
normal FruityOS Sol backend.

Maintenance rules:

- Keep Phobos independently buildable from `sol/phobos`.
- Keep Mars independently buildable from `sol/mars`.
- Never satisfy an executable name by copying or aliasing the other backend's
  binary.
- Changes intended only for Phobos must not be mirrored into Mars.
- Preserve the internal `mars_*` names unless a deliberate source-wide rename
  is requested; they make backend comparison straightforward.
- A backend change is not accepted until semantic tests, a clean full build,
  and QEMU boot verification pass.
