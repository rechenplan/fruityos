bits 64

global exit

exit:	push	byte 60
	pop	rax
	syscall
	hlt
