bits 64

global brk

brk:
	push	byte 12
	pop	rax
	syscall
	ret
