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
global getcwd
global exec
global fork
global waitpid
global chdir
global getdents64
global unlink
global rename
global mkdir
global rmdir
global dup2

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

getcwd:
	mov	rax, 79
	syscall
	ret

exec:
	mov	rax, 59
	xor	rdx, rdx
	syscall
	ret

fork:
	mov	rax, 57
	syscall
	ret

waitpid:
	mov	rax, 61
	xor	rsi, rsi
	push	rsi
	pop	rdx
	push	rsi
	pop	r10
	syscall
	ret

chdir:
	mov	rax, 80
	syscall
	ret

getdents64:
	mov	rax, 217
	syscall
	ret

unlink:
	mov	rax, 87
	syscall
	ret

rename:
	mov	rax, 82
	syscall
	ret

mkdir:
	mov	rax, 83
	mov	rsi, 511
	syscall
	ret

rmdir:
	mov	rax, 84
	syscall
	ret

dup2:
	mov	rax, 33
	syscall
	ret
