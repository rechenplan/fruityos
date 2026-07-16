bits 64
org 0x801000

_start:
	lea	rax, [rel platform]
	mov	[rel __jabara_global_platform], rax
	jmp __jabara_fap_start

platform: db "fruityos-x86_64", 0

; Stack-compiled modules only use this allocator for records and closures.
__jabara_alloc:
	pop r10
	pop rdi
	push r10
	push rbx
	add rdi, 7
	and rdi, -8
	mov rbx, rdi
	mov rdi, -1
	mov rax, 21
	int 132
	lea rdi, [rax + rbx]
	mov rax, 21
	int 132
	sub rax, rbx
	pop rbx
	ret
