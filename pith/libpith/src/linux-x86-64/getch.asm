bits 64

global fgetch
global getch
extern read

getch:  push	byte 0		; stdin
	pop	rdi

fgetch:	push	rax
	push	rsp
	pop	rsi
	push	byte 1		; 1 byte
	pop	rdx
	call	read
	pop	rdx
	test	rax, rax
	jle	bail
	push	rdx
	pop	rax
bail:	ret
