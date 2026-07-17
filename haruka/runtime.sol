; Haruka stack-region runtime for Sol.
;
; Every allocated object has this hidden header:
;
;   object[-2w] = lexical owner frame
;   object[-1w] = payload size in words
;
; __haruka_alloc inserts a local object at the current frame frontier.
; __haruka_lift shallow-copies an object into its lexical owner's frontier.

extern __haruka_alloc
global __haruka_alloc
__haruka_alloc:
    ; [sp]      return ip
    ; [sp + 1w] payload size in words
    ld a, [sp + 1w]
    add a, a, 2
    mul a, a, 1w
    mov b, sp
    sub sp, sp, a
    mov c, sp
    ld a, [fp - 3w]
__haruka_alloc_move:
    eq d, b, a
    bnz d, __haruka_alloc_moved
    ld d, [b]
    st [c], d
    add b, b, 1w
    add c, c, 1w
    jmp __haruka_alloc_move
__haruka_alloc_moved:
    st [fp - 3w], c
    st [c], fp
    ld d, [sp + 1w]
    st [c + 1w], d
    add a, c, 2w
    pop d
    add sp, sp, 1w
    jmp d

extern __haruka_lift
global __haruka_lift
__haruka_lift:
    ; Save fp inside the segment that will be moved. This frees fp for use as
    ; the copy scratch register while its old frame is being overwritten.
    push fp

    ; [sp]      saved fp
    ; [sp + 1w] return ip
    ; [sp + 2w] source object
    ld a, [sp + 2w]
    ld a, [a - 1w]
    add a, a, 2
    mul a, a, 1w

    ; Capture the old owner frontier once, before the overlapping move.
    ld d, [fp - 2w]
    ld d, [d - 3w]
    mov b, sp
    sub sp, sp, a
    mov c, sp
__haruka_lift_move:
    eq fp, b, d
    bnz fp, __haruka_lift_moved
    ld fp, [b]
    st [c], fp
    add b, b, 1w
    add c, c, 1w
    jmp __haruka_lift_move

__haruka_lift_moved:
    ; Recover the old fp from its moved stack word, then select the relocated
    ; frame. c is the new owner frontier.
    ld fp, [sp]
    sub fp, fp, a
    ld d, [fp - 2w]
    st [d - 3w], c

    ; Relocate every stack word that points into the moved old segment.
    mov c, sp
__haruka_lift_relocate:
    ld d, [fp - 2w]
    ld d, [d - 3w]
    eq d, c, d
    bnz d, __haruka_lift_relocated

    ld b, [c]
    add d, sp, a
    lt d, b, d
    bnz d, __haruka_lift_next

    ld d, [fp - 2w]
    ld d, [d - 3w]
    add d, d, a
    ge d, b, d
    bnz d, __haruka_lift_next

    sub b, b, a
    st [c], b
__haruka_lift_next:
    add c, c, 1w
    jmp __haruka_lift_relocate

__haruka_lift_relocated:
    ; Create the destination header at the owner's new frontier.
    ld c, [fp - 2w]
    ld d, [c - 3w]
    st [d], c
    ld b, [sp + 2w]
    ld c, [b - 1w]
    st [d + 1w], c
    add d, d, 2w

    ; Shallow-copy the payload only.
__haruka_lift_copy:
    bz c, __haruka_lift_copied
    ld a, [b]
    st [d], a
    add b, b, 1w
    add d, d, 1w
    sub c, c, 1
    jmp __haruka_lift_copy

__haruka_lift_copied:
    ld a, [fp - 2w]
    ld a, [a - 3w]
    add a, a, 2w
    add sp, sp, 1w
    pop d
    add sp, sp, 1w
    jmp d
