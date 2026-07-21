%define PITH_exit
bits 64
org 0x400000
orgone_image_base:

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
	dq __haruka_file_end - 0x400000
	dq __haruka_file_end - 0x400000
	dq 4096

platform: db "linux-x86_64", 0

_start:
	lea	rax, [rel platform]
	mov	[rel __haruka_global_platform], rax
	cmp	ebx, 1330073137
	je	.orgone
	mov rax, [rsp]
	mov rdx, [rsp + 8]
	jmp	.call_main
.orgone:
	mov	rax, rcx
.call_main:
	push rax
	push rdx
	call main
	push rax
	call exit
