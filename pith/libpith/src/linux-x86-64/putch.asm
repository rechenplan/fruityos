bits 64

global putch
extern write

putch:	push	rdi
	push	byte 1		; stdout
	pop	rdi
	push	rsp
	pop	rsi
	push	byte 1		; 1 byte
	pop	rdx
	call	write
	pop	rax
	ret
