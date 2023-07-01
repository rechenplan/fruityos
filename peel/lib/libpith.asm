bits 64

global brk
global close
global creat
global exit
global getch
global fgetch
global open
global putch
global fputch
global read
global seek
global write

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
	jz	.bail
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
