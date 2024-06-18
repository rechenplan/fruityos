bits 64

global _start

_start:
	pop	rdi
	pop	rsi
	mov	rax, main
	call	rax
	push	rax
	pop	rdi
	mov	rax, exit
	call	rax

