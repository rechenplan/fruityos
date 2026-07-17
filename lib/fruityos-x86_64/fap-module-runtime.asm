bits 64
org 0x801000

_start:
	jmp __jabara_fap_start

__jabara_alloc:
	pop	r10
	pop	r11
	add	r11, 7
	and	r11, -8
	mov	r8, r11
	add	r11, 16
	mov	r9, [rbp - 24]
	mov	rdx, r9
	sub	rdx, r11
	mov	rsi, rsp
	mov	rdi, rsp
	sub	rdi, r11
.__jabara_alloc_copy:
	cmp	rsi, r9
	je	.__jabara_alloc_copied
	mov	rax, [rsi]
	mov	[rdi], rax
	add	rsi, 8
	add	rdi, 8
	jmp	.__jabara_alloc_copy
.__jabara_alloc_copied:
	mov	[rbp - 24], rdx
	mov	[rdx], rbp
	mov	[rdx + 8], r8
	lea	rax, [rdx + 16]
	sub	rsp, r11
	push	r10
	ret

__jabara_lift:
	pop	r10
	pop	r11
	mov	r9, [r11 - 8]
	add	r9, 16
	mov	rdx, [rbp - 16]
	mov	rcx, [rdx - 24]
	mov	r8, rsp
	mov	rsi, r8
	mov	rdi, r8
	sub	rdi, r9
.__jabara_lift_move:
	cmp	rsi, rcx
	je	.__jabara_lift_moved
	mov	rax, [rsi]
	mov	[rdi], rax
	add	rsi, 8
	add	rdi, 8
	jmp	.__jabara_lift_move
.__jabara_lift_moved:
	sub	rcx, r9
	mov	[rdx - 24], rcx
	mov	rdi, rdx
	lea	rdx, [rcx + r9]
	mov	rsi, r8
	sub	rsi, r9
.__jabara_lift_relocate:
	cmp	rsi, rcx
	je	.__jabara_lift_relocated
	mov	rax, [rsi]
	cmp	rax, r8
	jb	.__jabara_lift_next
	cmp	rdx, rax
	jbe	.__jabara_lift_next
	sub	rax, r9
	mov	[rsi], rax
.__jabara_lift_next:
	add	rsi, 8
	jmp	.__jabara_lift_relocate
.__jabara_lift_relocated:
	cmp	r11, r8
	jb	.__jabara_lift_source_ready
	cmp	rdx, r11
	jbe	.__jabara_lift_source_ready
	sub	r11, r9
.__jabara_lift_source_ready:
	sub	rbp, r9
	mov	rsp, r8
	sub	rsp, r9
	mov	[rcx], rdi
	lea	rax, [r9 - 16]
	mov	[rcx + 8], rax
	mov	r8, rax
	test	r8, r8
	jz	.__jabara_lift_copied
	mov	rsi, r11
	lea	rdi, [rcx + 16]
.__jabara_lift_copy:
	mov	rax, [rsi]
	mov	[rdi], rax
	add	rsi, 8
	add	rdi, 8
	sub	r8, 8
	jnz	.__jabara_lift_copy
.__jabara_lift_copied:
	lea	rax, [rcx + 16]
	push	r10
	ret
