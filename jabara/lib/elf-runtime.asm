__jabara_alloc:
	pop r10
	pop rdi
	push r10
	push rbx
	add rdi, 7
	and rdi, -8
	mov rbx, rdi
	mov rdi, -1
	push rdi
	call brk
	lea rdi, [rax + rbx]
	push rdi
	call brk
	sub rax, rbx
	pop rbx
	ret

mmap:
	pop r10
	pop r9
	pop r8
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 9
	mov r10, rcx
	syscall
	ret
brk:
	pop r10
	pop rdi
	push r10
	mov rax, 12
	syscall
	ret
close:
	pop r10
	pop rdi
	push r10
	mov rax, 3
	syscall
	ret
creat:
	pop r10
	pop rdi
	push r10
	mov rax, 85
	mov rsi, 511
	syscall
	ret
exit:
	pop r10
	pop rdi
	push r10
	mov rax, 60
	syscall
	hlt
getch:
	xor rdi, rdi
	jmp __jabara_fgetch_body
fgetch:
	pop r10
	pop rdi
	push r10
__jabara_fgetch_body:
	push 0
	mov rsi, rsp
	mov rdx, 1
	xor rax, rax
	syscall
	pop rdx
	test rax, rax
	jz .done
	mov rax, rdx
.done:
	ret
open:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 2
	syscall
	ret
putch:
	pop r10
	pop rsi
	push r10
	mov rdi, 1
	jmp __jabara_fputch_body
fputch:
	pop r10
	pop rsi
	pop rdi
	push r10
__jabara_fputch_body:
	push rsi
	mov rsi, rsp
	mov rdx, 1
	mov rax, 1
	syscall
	pop rax
	ret
read:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	xor rax, rax
	syscall
	ret
seek:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 8
	syscall
	ret
write:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 1
	syscall
	ret
getcwd:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 79
	syscall
	ret
exec:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 59
	xor rdx, rdx
	syscall
	ret
fork:
	mov rax, 57
	syscall
	ret
waitpid:
	pop r10
	pop rdi
	push r10
	mov rax, 61
	xor rsi, rsi
	xor rdx, rdx
	xor r10, r10
	syscall
	ret
chdir:
	pop r10
	pop rdi
	push r10
	mov rax, 80
	syscall
	ret
getdents64:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 217
	syscall
	ret
unlink:
	pop r10
	pop rdi
	push r10
	mov rax, 87
	syscall
	ret
rename:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 82
	syscall
	ret
mkdir:
	pop r10
	pop rdi
	push r10
	mov rax, 83
	mov rsi, 511
	syscall
	ret
rmdir:
	pop r10
	pop rdi
	push r10
	mov rax, 84
	syscall
	ret
dup2:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 33
	syscall
	ret

__jabara_file_end:
