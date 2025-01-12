bits 64

global _start

_start:
	mov	rax, main
	call	rax
	mov	rax, exit
	call	rax
