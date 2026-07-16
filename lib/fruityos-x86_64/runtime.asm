%define PITH_exit
__jabara_fap_start:
	push rdi
	push rsi
	call main
	push rax
	call exit

%ifdef PITH_open
open:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 0
	int 132
	ret
%endif

%ifdef PITH_creat
creat:
	pop r10
	pop rdi
	push r10
	mov rax, 1
	int 132
	ret
%endif

%ifdef PITH_close
close:
	pop r10
	pop rdi
	push r10
	mov rax, 2
	int 132
	ret
%endif

%ifdef PITH_read
read:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 3
	int 132
	ret
%endif

%ifdef PITH_write
write:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 4
	int 132
	ret
%endif

%ifdef PITH_fgetch
fgetch:
	pop r10
	pop rdi
	push r10
	mov rax, 5
	int 132
	ret
%endif

%ifdef PITH_fputch
fputch:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 6
	int 132
	ret
%endif

%ifdef PITH_seek
seek:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 7
	int 132
	ret
%endif

%ifdef PITH_getch
getch:
	mov rax, 8
	int 132
	ret
%endif

%ifdef PITH_putch
putch:
	pop r10
	pop rdi
	push r10
	mov rax, 9
	int 132
	ret
%endif

%ifdef PITH_getcwd
getcwd:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 10
	int 132
	ret
%endif

%ifdef PITH_getdents64
getdents64:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov rax, 11
	int 132
	ret
%endif

%ifdef PITH_rename
rename:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 12
	int 132
	ret
%endif

%ifdef PITH_mkdir
mkdir:
	pop r10
	pop rdi
	push r10
	mov rax, 13
	int 132
	ret
%endif

%ifdef PITH_rmdir
rmdir:
	pop r10
	pop rdi
	push r10
	mov rax, 14
	int 132
	ret
%endif

%ifdef PITH_chdir
chdir:
	pop r10
	pop rdi
	push r10
	mov rax, 15
	int 132
	ret
%endif

%ifdef PITH_unlink
unlink:
	pop r10
	pop rdi
	push r10
	mov rax, 16
	int 132
	ret
%endif

%ifdef PITH_exec
exec:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 17
	int 132
	ret
%endif

%ifdef PITH_fork
fork:
	mov rax, 18
	int 132
	ret
%endif

%ifdef PITH_waitpid
waitpid:
	pop r10
	pop rdi
	push r10
	mov rax, 19
	int 132
	ret
%endif

%ifdef PITH_dup2
dup2:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, 20
	int 132
	ret
%endif

%ifdef PITH_brk
brk:
	pop r10
	pop rdi
	push r10
	mov rax, 21
	int 132
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
	mov rax, 22
	int 132
	ret
%endif

%ifdef PITH_exit
exit:
	pop r10
	pop rdi
	push r10
	mov rax, 23
	int 132
	hlt
%endif

%ifdef PITH_juicer_decode64
bits 64
; Freestanding callers pass RSI = input and RDI = output.
; Jabara callers push output followed by input.
; Returns the decoded size in RAX outside freestanding builds.
juicer_decode64:
	%ifndef JUICER_FREESTANDING
	pop r10
	pop rsi
	pop rdi
	push r10
	push rdi
	push rbx
	%endif
.juicer64_flags:
	db 172 ; lodsb
	mov ebx, 256
	mov bl, al
.juicer64_next:
	shr ebx, 1
	jz .juicer64_flags
	jc .juicer64_literal
	xor eax, eax
	db 102, 173 ; lodsw
	test eax, eax
	jz .juicer64_done
	mov ecx, eax
	and ecx, 15
	mov edx, eax
	shr edx, 4
	add ecx, 3
	push rsi
	mov rsi, rdi
	sub rsi, rdx
	db 243, 164 ; rep movsb
	pop rsi
	jmp .juicer64_advance
.juicer64_literal:
	db 172 ; lodsb
	db 170 ; stosb
.juicer64_advance:
	jmp .juicer64_next
.juicer64_done:
	%ifndef JUICER_FREESTANDING
	pop rbx
	pop rax
	neg rax
	add rax, rdi
	%endif
	ret
%endif
