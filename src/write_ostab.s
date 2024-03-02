bits 64

write_ostab:
	push rbp

	mov rbp, rsp
	mov rax, rdi

	mov rdi, open
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, creat
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, close
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, read
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, write
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, fgetch
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, fputch
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, seek
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, getch
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, putch
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, getcwd
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, getdents64
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, rename
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, mkdir
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, rmdir
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, chdir
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, unlink
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, exec
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, fork
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, waitpid
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, dup2
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, brk
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, mmap
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	mov rdi, exit
	mov [rax], rdi
	mov rdi, 8
	add rax, rdi

	pop rbp
	ret
