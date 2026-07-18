%define PITH_juicer_decode64
%define JUICER_FREESTANDING
; Compact PE32+ Juicer launcher for windows-x86_64.
bits 64
org 0x150000000
STUB_IMAGE_BASE equ 0x150000000

dw 0x5a4d
dw 0,0,0,0,0,0,0,0,0,0
dw 0,0,0,0,0,0,0,0,0,0
dw 0,0,0,0,0,0,0,0,0
dd __stub_pe_header - STUB_IMAGE_BASE
dd 0,0,0,0,0,0,0,0
dd 0,0,0,0,0,0,0,0

__stub_pe_header:
	dd 0x00004550
	dw 0x8664
	dw 1
	dd 0
	dd 0,0
	dw __stub_optional_end - __stub_optional_header
	dw 0x0022

__stub_optional_header:
	dw 0x20b
	db 0,0
	dd __stub_section_raw_size
	dd 0,0
	dd _start - STUB_IMAGE_BASE
	dd 0x200
	dq STUB_IMAGE_BASE
	dd 0x200,0x200
	dw 6,0
	dw 0,0
	dw 6,0
	dd 0
	dd __stub_image_size
	dd 0x200
	dd 0
	dw 3,0
	dq 0x100000,0x1000
	dq 0x100000,0x1000
	dd 0
	dd 16
	dd 0,0
	dd __stub_imports - STUB_IMAGE_BASE, __stub_imports_end - __stub_imports
	dq 0,0,0,0,0,0,0,0,0,0
	dd __stub_iat - STUB_IMAGE_BASE, __stub_iat_end - __stub_iat
	dq 0,0,0
__stub_optional_end:

	db ".text",0,0,0
	dd __stub_section_virtual_size
	dd 0x200
	dd __stub_section_raw_size
	dd 0x200
	dd 0,0
	dw 0,0
	dd 0xe0000060

align 512
__stub_section_start:


__stub_call:
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 32
	call rax
	mov rsp, r12
	pop r12
	ret

__stub_create_file:
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 64
	mov edx, 0x80000000
	mov r8d, 7
	xor r9d, r9d
	mov dword [rsp + 32], 3
	mov dword [rsp + 40], 0x80
	mov qword [rsp + 48], 0
	mov rax, [rel __stub_imp_CreateFileA]
	call rax
	mov rsp, r12
	pop r12
	ret

_start:
	; Preserve the native process-entry stack for the decoded payload.
	mov r15,rsp
	sub rsp,1024
	; Resolve our own path and open the appended payload.
	xor ecx,ecx
	lea rdx,[rsp]
	mov r8d, 1024
	mov rax, [rel __stub_imp_GetModuleFileNameA]
	call __stub_call
	lea rcx, [rsp]
	call __stub_create_file
	cmp rax, -1
	je .fail
	mov r13, rax

	mov rcx, r13
	mov edx, __stub_file_end - STUB_IMAGE_BASE
	xor r8d, r8d
	xor r9d, r9d
	mov rax, [rel __stub_imp_SetFilePointer]
	call __stub_call

	; Compressed input and decoded raw PE buffers.
	xor ecx, ecx
	mov edx, 0x1000000
	mov r8d, 0x3000
	mov r9d, 4
	mov rax, [rel __stub_imp_VirtualAlloc]
	call __stub_call
	test rax, rax
	jz .fail
	mov rbp, rax

	mov rcx, r13
	mov rdx, rbp
	mov r8d, 0x1000000
	lea r9, [rel __stub_read]
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 48
	mov qword [rsp + 32], 0
	mov rax, [rel __stub_imp_ReadFile]
	call rax
	mov rsp, r12
	pop r12
	test eax, eax
	jz .fail

	mov rcx, r13
	mov rax, [rel __stub_imp_CloseHandle]
	call __stub_call

	xor ecx, ecx
	mov edx, 0x2000000
	mov r8d, 0x3000
	mov r9d, 4
	mov rax, [rel __stub_imp_VirtualAlloc]
	call __stub_call
	test rax, rax
	jz .fail
	mov r14, rax
	mov rsi, rbp
	mov rdi, r14
	call juicer_decode64

	; Read the preferred base and image size from the decoded PE header.
	mov eax, [r14 + 0x3c]
	lea rbx, [r14 + rax]
	add rbx, 24
	mov rcx,[rbx+24]
	mov ebp,[rbx+56]
	mov edx,ebp
	mov r8d, 0x3000
	mov r9d, 0x40
	mov rax, [rel __stub_imp_VirtualAlloc]
	call __stub_call
	test rax, rax
	jz .fail
	mov rcx, [rbx + 24]
	cmp rax, rcx
	jne .fail
	mov r13, rax

	; File offsets equal RVAs, so copy the decoded image verbatim.
	mov rsi, r14
	mov rdi, r13
	mov rcx,rbp
	db 243,164

	; Resolve the payload import directory.
	mov eax, [rbx + 120]
	test eax, eax
	jz .enter
	lea r14, [r13 + rax]
.descriptor:
	mov eax, [r14 + 12]
	test eax, eax
	jz .enter
	lea rcx, [r13 + rax]
	mov rax, [rel __stub_imp_LoadLibraryA]
	call __stub_call
	test rax, rax
	jz .fail
	mov r12, rax
	mov eax, [r14]
	test eax, eax
	jnz .have_thunk
	mov eax, [r14 + 16]
.have_thunk:
	lea rsi, [r13 + rax]
	mov eax, [r14 + 16]
	lea rdi, [r13 + rax]
.thunk:
	mov rax, [rsi]
	test rax, rax
	jz .next_descriptor
	cmp rax, 0
	jl .fail
	lea rdx, [r13 + rax]
	add rdx, 2
	mov rcx, r12
	mov rax, [rel __stub_imp_GetProcAddress]
	call __stub_call
	test rax, rax
	jz .fail
	mov [rdi], rax
	add rsi, 8
	add rdi, 8
	jmp .thunk
.next_descriptor:
	add r14, 20
	jmp .descriptor

.enter:
	mov eax,[rbx+16]
	add rax,r13
	mov rsp,r15
	push rax
	ret

.fail:
	mov ecx, 127
	mov rax, [rel __stub_imp_ExitProcess]
	call __stub_call
	hlt


align 8
__stub_read: dd 0

align 8
__stub_imports:
	dd __stub_ilt - STUB_IMAGE_BASE
	dd 0, 0
	dd __stub_kernel32_name - STUB_IMAGE_BASE
	dd __stub_iat - STUB_IMAGE_BASE
	dd 0, 0, 0, 0, 0
__stub_imports_end:
__stub_ilt:
	dq __stub_name_CloseHandle - STUB_IMAGE_BASE
	dq __stub_name_CreateFileA - STUB_IMAGE_BASE
	dq __stub_name_ExitProcess - STUB_IMAGE_BASE
	dq __stub_name_GetModuleFileNameA - STUB_IMAGE_BASE
	dq __stub_name_GetProcAddress - STUB_IMAGE_BASE
	dq __stub_name_LoadLibraryA - STUB_IMAGE_BASE
	dq __stub_name_ReadFile - STUB_IMAGE_BASE
	dq __stub_name_SetFilePointer - STUB_IMAGE_BASE
	dq __stub_name_VirtualAlloc - STUB_IMAGE_BASE
	dq 0
__stub_iat:
__stub_imp_CloseHandle: dq __stub_name_CloseHandle - STUB_IMAGE_BASE
__stub_imp_CreateFileA: dq __stub_name_CreateFileA - STUB_IMAGE_BASE
__stub_imp_ExitProcess: dq __stub_name_ExitProcess - STUB_IMAGE_BASE
__stub_imp_GetModuleFileNameA: dq __stub_name_GetModuleFileNameA - STUB_IMAGE_BASE
__stub_imp_GetProcAddress: dq __stub_name_GetProcAddress - STUB_IMAGE_BASE
__stub_imp_LoadLibraryA: dq __stub_name_LoadLibraryA - STUB_IMAGE_BASE
__stub_imp_ReadFile: dq __stub_name_ReadFile - STUB_IMAGE_BASE
__stub_imp_SetFilePointer: dq __stub_name_SetFilePointer - STUB_IMAGE_BASE
__stub_imp_VirtualAlloc: dq __stub_name_VirtualAlloc - STUB_IMAGE_BASE
	dq 0
__stub_iat_end:
__stub_kernel32_name: db "KERNEL32.dll", 0
align 2
__stub_name_CloseHandle: dw 0
	db "CloseHandle", 0
align 2
__stub_name_CreateFileA: dw 0
	db "CreateFileA", 0
align 2
__stub_name_ExitProcess: dw 0
	db "ExitProcess", 0
align 2
__stub_name_GetModuleFileNameA: dw 0
	db "GetModuleFileNameA", 0
align 2
__stub_name_GetProcAddress: dw 0
	db "GetProcAddress", 0
align 2
__stub_name_LoadLibraryA: dw 0
	db "LoadLibraryA", 0
align 2
__stub_name_ReadFile: dw 0
	db "ReadFile", 0
align 2
__stub_name_SetFilePointer: dw 0
	db "SetFilePointer", 0
align 2
__stub_name_VirtualAlloc: dw 0
	db "VirtualAlloc", 0

