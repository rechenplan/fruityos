bits 64
org 0x400000

__elf_header:
	db 127,69,76,70,2,1,1,0,0,0,0,0,0,0,0,0
	dw 2,62
	dd 1
	dq _start
	dq __elf_program_header - 0x400000
	dq 0
	dd 0
	dw 64,56,1,0,0,0
__elf_program_header:
	dd 1,7
	dq 0
	dq 0x400000
	dq 0x400000
	dq __jabara_file_end - 0x400000
	dq __jabara_file_end - 0x400000
	dq 4096

_start:
	mov rax, [rsp]
	mov rdx, [rsp + 8]
	push rax
	push rdx
	call main
	push rax
	call exit
