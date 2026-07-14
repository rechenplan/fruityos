bits 64
org 0x801000

_start:
	jmp __jabara_fap_start

; Stack-compiled modules only use this allocator for records and closures.
__jabara_alloc:
	push rbx
	add rdi, 7
	and rdi, -8
	mov rbx, rdi
	mov rdi, -1
	call brk
	lea rdi, [rax + rbx]
	call brk
	sub rax, rbx
	pop rbx
	ret
