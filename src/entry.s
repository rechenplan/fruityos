org 0x10000

bits 64

entry:
	mov rax, kmain
	call rax

spin:
	jmp spin
