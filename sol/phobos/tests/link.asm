org 0x10000
bits 64

entry:
    call sol_entry
    ret

asm_helper:
    mov rax, 42
    ret
