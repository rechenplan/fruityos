; this code was generated by a tool. assemble with nasm.
bits 64

global puts
global nextarg
global main

puts:
	push	rbp
	mov	rbp, rsp
	xor	rax, rax
	push	rdi
	push	rax
	jmp	puts_L1
puts_L0:
	mov	rax, putch
	push	rax
	mov	rax, rbp
	mov	rdi, 16
	sub	rax, rdi
	mov	rax, [rax]
	push	rax
	pop	rdi
	pop	rax
	call	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	push	rax
	mov	rax, 1
	push	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	mov	rax, [rax]
	pop	rdi
	add	rax, rdi
	pop	rdi
	mov	[rdi], rax
puts_L1:
	mov	rax, rbp
	mov	rdi, 16
	sub	rax, rdi
	push	rax
	mov	rax, 255
	push	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	mov	rax, [rax]
	mov	rax, [rax]
	pop	rdi
	and	rax, rdi
	pop	rdi
	mov	[rdi], rax
	test	rax, rax
	jnz	puts_L0
	mov	rax, 0
	mov	rsp, rbp
	pop	rbp
	ret
	mov	rsp, rbp
	pop	rbp
	ret

nextarg:
	push	rbp
	mov	rbp, rsp
	xor	rax, rax
	push	rdi
	push	rax
	jmp	nextarg_L1
nextarg_L0:
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	push	rax
	mov	rax, 1
	push	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	mov	rax, [rax]
	pop	rdi
	add	rax, rdi
	pop	rdi
	mov	[rdi], rax
nextarg_L1:
	mov	rax, rbp
	mov	rdi, 16
	sub	rax, rdi
	push	rax
	mov	rax, 255
	push	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	mov	rax, [rax]
	mov	rax, [rax]
	pop	rdi
	and	rax, rdi
	pop	rdi
	mov	[rdi], rax
	test	rax, rax
	jnz	nextarg_L0
	mov	rax, 1
	push	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	mov	rax, [rax]
	pop	rdi
	add	rax, rdi
	mov	rsp, rbp
	pop	rbp
	ret
	mov	rsp, rbp
	pop	rbp
	ret

main:
	push	rbp
	mov	rbp, rsp
	xor	rax, rax
	push	rdi
	push	rsi
	push	rax
	mov	rax, 2
	push	rax
	mov	rax, rbp
	mov	rdi, 8
	sub	rax, rdi
	mov	rax, [rax]
	pop	rdi
	xor	rdx, rdx
	cmp	rax, rdi
	setne	dl
	mov	rax, rdx
	test	rax, rax
	jz	main_L0
	mov	rax, puts
	push	rax
	jmp	main_L3
main_L2:
	db	"usage: rmdir name"
	db 0
main_L3:
	mov	rax, main_L2
	push	rax
	pop	rdi
	pop	rax
	call	rax
	mov	rax, putch
	push	rax
	mov	rax, 10
	push	rax
	pop	rdi
	pop	rax
	call	rax
	mov	rax, exit
	push	rax
	pop	rax
	call	rax
	jmp main_L1
main_L0:
main_L1:
	mov	rax, rmdir
	push	rax
	mov	rax, nextarg
	push	rax
	mov	rax, rbp
	mov	rdi, 16
	sub	rax, rdi
	mov	rax, [rax]
	push	rax
	pop	rdi
	pop	rax
	call	rax
	push	rax
	pop	rdi
	pop	rax
	call	rax
	mov	rax, 0
	mov	rsp, rbp
	pop	rbp
	ret
	mov	rsp, rbp
	pop	rbp
	ret

