__jabara_fap_start:
	push rdi
	push rsi
	call main
	push rax
	call exit

open:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 0
	int 132
	ret
creat:
	pop r10
	pop rdi
	push r10
	mov rax, 1
	int 132
	ret
close:
	pop r10
	pop rdi
	push r10
	mov rax, 2
	int 132
	ret
read:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 3
	int 132
	ret
write:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 4
	int 132
	ret
fgetch:
	pop r10
	pop rdi
	push r10
	mov rax, 5
	int 132
	ret
fputch:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 6
	int 132
	ret
seek:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 7
	int 132
	ret
getch:
	mov rax, 8
	int 132
	ret
putch:
	pop r10
	pop rdi
	push r10
	mov rax, 9
	int 132
	ret
getcwd:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 10
	int 132
	ret
getdents64:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 11
	int 132
	ret
rename:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 12
	int 132
	ret
mkdir:
	pop r10
	pop rdi
	push r10
	mov rax, 13
	int 132
	ret
rmdir:
	pop r10
	pop rdi
	push r10
	mov rax, 14
	int 132
	ret
chdir:
	pop r10
	pop rdi
	push r10
	mov rax, 15
	int 132
	ret
unlink:
	pop r10
	pop rdi
	push r10
	mov rax, 16
	int 132
	ret
exec:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 17
	int 132
	ret
fork:
	mov rax, 18
	int 132
	ret
waitpid:
	pop r10
	pop rdi
	push r10
	mov rax, 19
	int 132
	ret
dup2:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 20
	int 132
	ret
brk:
	pop r10
	pop rdi
	push r10
	mov rax, 21
	int 132
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
	mov rax, 22
	int 132
	ret
exit:
	pop r10
	pop rdi
	push r10
	mov rax, 23
	int 132
	hlt
