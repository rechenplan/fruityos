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

mmap:
	mov rax, 9
	mov r10, rcx
	syscall
	ret
brk:
	mov rax, 12
	syscall
	ret
close:
	mov rax, 3
	syscall
	ret
creat:
	mov rax, 85
	mov rsi, 511
	syscall
	ret
exit:
	mov rax, 60
	syscall
	hlt
getch:
	xor rdi, rdi
fgetch:
	push rax
	push rsp
	pop rsi
	mov rdx, 1
	call read
	pop rdx
	test rax, rax
	jz .done
	mov rax, rdx
.done:
	ret
open:
	mov rax, 2
	syscall
	ret
putch:
	mov rsi, rdi
	mov rdi, 1
fputch:
	push rsi
	push rsp
	pop rsi
	mov rdx, 1
	call write
	pop rax
	ret
read:
	xor rax, rax
	syscall
	ret
seek:
	mov rax, 8
	syscall
	ret
write:
	mov rax, 1
	syscall
	ret
getcwd:
	mov rax, 79
	syscall
	ret
exec:
	mov rax, 59
	xor rdx, rdx
	syscall
	ret
fork:
	mov rax, 57
	syscall
	ret
waitpid:
	mov rax, 61
	xor rsi, rsi
	xor rdx, rdx
	xor r10, r10
	syscall
	ret
chdir:
	mov rax, 80
	syscall
	ret
getdents64:
	mov rax, 217
	syscall
	ret
unlink:
	mov rax, 87
	syscall
	ret
rename:
	mov rax, 82
	syscall
	ret
mkdir:
	mov rax, 83
	mov rsi, 511
	syscall
	ret
rmdir:
	mov rax, 84
	syscall
	ret
dup2:
	mov rax, 33
	syscall
	ret

__jabara_file_end:
