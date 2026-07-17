%define PITH_exit
bits 64
org 0x140000000
WIN_IMAGE_BASE equ 0x140000000

; Compact one-section PE32+ console executable. File and section alignment are
; both 512 bytes, so file offsets equal RVAs and a Juicer-decoded image can be
; copied directly to its preferred base.

dw 0x5a4d
dw 0,0,0,0,0,0,0,0,0,0
dw 0,0,0,0,0,0,0,0,0,0
dw 0,0,0,0,0,0,0,0,0
dd __win_pe_header - WIN_IMAGE_BASE
dd 0,0,0,0,0,0,0,0
dd 0,0,0,0,0,0,0,0

__win_pe_header:
	dd 0x00004550
	dw 0x8664
	dw 1
	dd 0
	dd 0,0
	dw __win_optional_end - __win_optional_header
	dw 0x0022

__win_optional_header:
	dw 0x20b
	db 0,0
	dd __win_section_raw_size
	dd 0,0
	dd _start - WIN_IMAGE_BASE
	dd 0x200
	dq WIN_IMAGE_BASE
	dd 0x200,0x200
	dw 6,0
	dw 0,0
	dw 6,0
	dd 0
	dd __win_image_size
	dd 0x200
	dd 0
	dw 3,0
	dq 0x100000,0x1000
	dq 0x100000,0x1000
	dd 0
	dd 16
	dd 0,0
	dd __win_imports - WIN_IMAGE_BASE, __win_imports_end - __win_imports
	dq 0,0,0,0,0,0,0,0,0,0
	dd __win_iat - WIN_IMAGE_BASE, __win_iat_end - __win_iat
	dq 0,0,0
__win_optional_end:

	db ".text",0,0,0
	dd __win_section_virtual_size
	dd 0x200
	dd __win_section_raw_size
	dd 0x200
	dd 0,0
	dw 0,0
	dd 0xe0000060

align 512
__win_section_start:

platform: db "windows-x86_64",0

_start:
	lea rax,[rel platform]
	mov [rel __jabara_global_platform],rax
	call __win_init_args
	push rax
	push rdx
	call main
	push rax
	call exit
