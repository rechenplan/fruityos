bits 64

global open

open:
	push	byte 2
	pop	rax
	syscall
	ret
