bits 64

global _start

_start:
	push	rdi
	push	rsi
	call	main
	push	rax
	call	exit
