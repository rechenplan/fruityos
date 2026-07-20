# Frozen Phobos snapshot

Phobos preserves the Mars backend delivered as the radical threaded-control
result on 2026-07-19.

Rules for maintenance:

- Keep Phobos behavior stable unless a Phobos-specific change is requested.
- Do not automatically merge later Mars backend experiments into Phobos.
- Keep the Haruka source implementation independently buildable.
- Do not add Phobos to the normal FruityOS image or `.fap` inventory.
- Internal `mars_*` names remain unchanged to make source comparison exact.
