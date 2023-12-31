org 0x7e00
bits 64

entry:
	mov rax, kmain
	call rax

spin:
	jmp spin
