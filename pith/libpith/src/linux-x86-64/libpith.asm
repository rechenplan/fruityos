bits 64

_start:
	pop	rdi
	pop	rsi
	mov	rax, main
	call	rax
	push	rax
	pop	rdi
	mov	rax, exit
	call	rax

brk:
	mov	rax, 12
	syscall
	ret

close:
	mov	rax, 3
	syscall
	ret

creat:
	mov	rax, 85
	mov	rsi, 511
	syscall
	ret

exit:
	mov	rax, 60
	syscall
	hlt

getch:
	xor	rdi, rdi

fgetch:
	push	rax
	push	rsp
	pop	rsi
	mov	rdx, 1
	mov	rax, read
	call	rax
	pop	rdx
	test	rax, rax
	jle	bail
	push	rdx
	pop	rax
.bail:
	ret

open:
	mov	rax, 2
	syscall
	ret

putch:
	push	rdi
	pop	rsi
	mov	rdi, 1

fputch:
	push	rsi
	push	rsp
	pop	rsi
	mov	rdx, 1
	mov	rax, write
	call	rax
	pop	rax
	ret

read:
	xor	rax, rax
	syscall
	ret

seek:
	mov	rax, 8
	syscall
	ret

write:
	mov	rax, 1
	syscall
	ret
