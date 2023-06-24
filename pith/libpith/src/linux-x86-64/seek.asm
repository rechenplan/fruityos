bits 64

global seek

seek:	push	byte 8
	pop	rax
	syscall
	ret
