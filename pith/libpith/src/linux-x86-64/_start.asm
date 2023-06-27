bits 64

global _start
extern main
extern exit

_start:	call	main
	push	rax
	pop	rdi
	call	exit
