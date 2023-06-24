bits 64

global write

write:	push	byte 1
	pop	rax
	syscall
	ret
