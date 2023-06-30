bits 64

global fputch
global putch
extern write

putch:	push	rdi
	pop	rsi
	push	byte 1		; stdout
	pop	rdi

fputch:	push	rsi
	push	rsp
	pop	rsi
	push	byte 1
	pop	rdx
	call	write
	pop	rax
	ret
