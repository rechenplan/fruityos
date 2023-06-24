bits 64

global close

close:	push	byte 3
	pop	rax
	syscall
	ret
