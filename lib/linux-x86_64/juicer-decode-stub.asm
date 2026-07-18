%define PITH_juicer_decode64
%define JUICER_FREESTANDING
; Linux x86-64 Juicer executable stub.
;
; The ELF loader maps this stub at 0x600000. The compressed executable is
; appended after __stub_end and is read back through /proc/self/exe. The
; decoded ELF image is written into an executable MAP_FIXED mapping at
; 0x400000, matching the origin used by the normal Linux runtime.

bits 64
org 0x600000

__elf_header:
	db 127,69,76,70,2,1,1,0,0,0,0,0,0,0,0,0
	dw 2,62
	dd 1
	dq _start
	dq __elf_program_header - 0x600000
	dq 0
	dd 0
	dw 64,56,1,0,0,0
__elf_program_header:
	dd 1,7
	dq 0
	dq 0x600000
	dq 0x600000
	dq __stub_end - 0x600000
	dq __stub_end - 0x600000
	dq 4096

_start:
	; Open the executable itself.
	mov rax, 2
	lea rdi, [rel self_path]
	xor rsi, rsi
	xor rdx, rdx
	syscall
	test rax, rax
	jl .fail
	push rax

	; Seek to the compressed data appended after the mapped stub.
	pop rdi
	push rdi
	mov rsi, __stub_end - 0x600000
	xor rdx, rdx
	mov rax, 8
	syscall
	test rax, rax
	jl .fail

	; Allocate a read/write input region for the compressed stream.
	xor rdi, rdi
	mov rsi, 0x200000
	mov rdx, 3
	mov r10, 0x22
	mov r8, -1
	xor r9, r9
	mov rax, 9
	syscall
	test rax, rax
	jl .fail
	mov rbp, rax

	; Read the compressed stream into that mapping.
	pop rdi
	push rdi
	mov rsi, rbp
	mov rdx, 0x200000
	xor rax, rax
	syscall
	test rax, rax
	jl .fail

	; Close /proc/self/exe before replacing the payload address space.
	pop rdi
	mov rax, 3
	syscall

	; Map the decoded ELF at its linked address with execute permission.
	mov rdi, 0x400000
	mov rsi, 0x200000
	mov rdx, 7
	mov r10, 0x32
	mov r8, -1
	xor r9, r9
	mov rax, 9
	syscall
	cmp rax, rdi
	jne .fail

	; Decode directly into the executable mapping.
	mov rsi, rbp
	; RDI still points at 0x400000.
	call juicer_decode64

	; The decoded file is a one-segment ELF whose file image is its memory
	; image. Transfer control to its e_entry value while preserving the
	; original process stack for argc/argv.
	mov rax, 0x400000
	mov rax, [rax + 24]
	push rax
	ret

.fail:
	mov rdi, 127
	mov rax, 60
	syscall
	hlt

self_path: db "/proc/self/exe", 0


