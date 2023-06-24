bits 64

global _start
extern main
extern exit

_start:	call	main
	call	exit
