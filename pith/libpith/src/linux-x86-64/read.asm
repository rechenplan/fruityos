bits 64

global read

read:	push	byte 0
	pop	rax
	syscall
	ret
