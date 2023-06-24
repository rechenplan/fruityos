bits 64
global getch
extern read
getch:	push	rax
	push	byte 0		; stdin
	pop	rdi
	push	rsp
	pop	rsi
	push	byte 1		; 1 byte
	pop	rdx
	call	read
	pop	rax
	ret
