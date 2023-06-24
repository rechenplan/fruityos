bits 64

global creat

creat:	push	byte 85
	pop	rax
	mov	rsi, 511
	syscall
	ret
