%ifdef JABARA_ALLOC
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
%endif

%ifdef PITH_mmap
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
%endif

%ifdef PITH_brk
brk:
	pop r10
	pop rdi
	push r10
	mov rax, 12
	syscall
	ret
%endif

%ifdef PITH_close
close:
	pop r10
	pop rdi
	push r10
	mov rax, 3
	syscall
	ret
%endif

%ifdef PITH_creat
creat:
	pop r10
	pop rdi
	push r10
	mov rax, 85
	mov rsi, 511
	syscall
	ret
%endif

%ifdef PITH_exit
exit:
	pop r10
	pop rdi
	push r10
	mov rax, 60
	syscall
	hlt
%endif

%ifdef PITH_getch
getch:
	push 0
	mov rsi, rsp
	mov rdx, 1
	xor rdi, rdi
	xor rax, rax
	syscall
	pop rdx
	test rax, rax
	jz .getch_done
	mov rax, rdx
.getch_done:
	ret
%endif

%ifdef PITH_fgetch
fgetch:
	pop r10
	pop rdi
	push r10
	push 0
	mov rsi, rsp
	mov rdx, 1
	xor rax, rax
	syscall
	pop rdx
	test rax, rax
	jz .fgetch_done
	mov rax, rdx
.fgetch_done:
	ret
%endif

%ifdef PITH_open
open:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 2
	syscall
	ret
%endif

%ifdef PITH_putch
putch:
	pop r10
	pop rsi
	push r10
	push rsi
	mov rsi, rsp
	mov rdx, 1
	mov rdi, 1
	mov rax, 1
	syscall
	pop rax
	ret
%endif

%ifdef PITH_fputch
fputch:
	pop r10
	pop rsi
	pop rdi
	push r10
	push rsi
	mov rsi, rsp
	mov rdx, 1
	mov rax, 1
	syscall
	pop rax
	ret
%endif

%ifdef PITH_read
read:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	xor rax, rax
	syscall
	ret
%endif

%ifdef PITH_seek
seek:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 8
	syscall
	ret
%endif

%ifdef PITH_write
write:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 1
	syscall
	ret
%endif

%ifdef PITH_getcwd
getcwd:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 79
	syscall
	ret
%endif

%ifdef PITH_exec
exec:
	pop r9
	pop r8
	pop rdi
	mov rsi, 1
	mov rax, 21
	syscall
	test rax, rax
	jnz .fail
	mov rax, 57
	syscall
	test rax, rax
	jz .child
	cmp rax, 0
	jl .fail
	mov rdi, rax
	xor rsi, rsi
	xor rdx, rdx
	xor r10, r10
	mov rax, 61
	syscall
	mov rax, 1
	push r9
	ret
.child:
	mov rsi, r8
	xor rdx, rdx
	mov rax, 59
	syscall
	mov rdi, 127
	mov rax, 60
	syscall
.fail:
	xor rax, rax
	push r9
	ret
%endif

%ifdef PITH_fork
fork:
	mov rax, 57
	syscall
	ret
%endif

%ifdef PITH_waitpid
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
%endif

%ifdef PITH_chdir
chdir:
	pop r10
	pop rdi
	push r10
	mov rax, 80
	syscall
	ret
%endif

%ifdef PITH_getdents64
getdents64:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 217
	syscall
	ret
%endif

%ifdef PITH_unlink
unlink:
	pop r10
	pop rdi
	push r10
	mov rax, 87
	syscall
	ret
%endif

%ifdef PITH_rename
rename:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 82
	syscall
	ret
%endif

%ifdef PITH_mkdir
mkdir:
	pop r10
	pop rdi
	push r10
	mov rax, 83
	mov rsi, 511
	syscall
	ret
%endif

%ifdef PITH_rmdir
rmdir:
	pop r10
	pop rdi
	push r10
	mov rax, 84
	syscall
	ret
%endif

%ifdef PITH_dup2
dup2:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 33
	syscall
	ret
%endif

__jabara_file_end:
