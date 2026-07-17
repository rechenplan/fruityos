%ifdef JABARA_ALLOC
__jabara_alloc:
	pop	r10
	pop	r11
	add	r11, 7
	and	r11, -8
	mov	r8, r11
	add	r11, 16
	mov	r9, [rbp - 24]
	mov	rdx, r9
	sub	rdx, r11
	mov	rsi, rsp
	mov	rdi, rsp
	sub	rdi, r11
.__jabara_alloc_copy:
	cmp	rsi, r9
	je	.__jabara_alloc_copied
	mov	rax, [rsi]
	mov	[rdi], rax
	add	rsi, 8
	add	rdi, 8
	jmp	.__jabara_alloc_copy
.__jabara_alloc_copied:
	mov	[rbp - 24], rdx
	mov	[rdx], rbp
	mov	[rdx + 8], r8
	lea	rax, [rdx + 16]
	sub	rsp, r11
	push	r10
	ret
%endif

%ifdef JABARA_LIFT
__jabara_lift:
	pop	r10
	pop	r11
	mov	r9, [r11 - 8]
	add	r9, 16
	mov	rdx, [rbp - 16]
	mov	rcx, [rdx - 24]
	mov	r8, rsp
	mov	rsi, r8
	mov	rdi, r8
	sub	rdi, r9
.__jabara_lift_move:
	cmp	rsi, rcx
	je	.__jabara_lift_moved
	mov	rax, [rsi]
	mov	[rdi], rax
	add	rsi, 8
	add	rdi, 8
	jmp	.__jabara_lift_move
.__jabara_lift_moved:
	sub	rcx, r9
	mov	[rdx - 24], rcx
	mov	rdi, rdx
	lea	rdx, [rcx + r9]
	mov	rsi, r8
	sub	rsi, r9
.__jabara_lift_relocate:
	cmp	rsi, rcx
	je	.__jabara_lift_relocated
	mov	rax, [rsi]
	cmp	rax, r8
	jb	.__jabara_lift_next
	cmp	rdx, rax
	jbe	.__jabara_lift_next
	sub	rax, r9
	mov	[rsi], rax
.__jabara_lift_next:
	add	rsi, 8
	jmp	.__jabara_lift_relocate
.__jabara_lift_relocated:
	cmp	r11, r8
	jb	.__jabara_lift_source_ready
	cmp	rdx, r11
	jbe	.__jabara_lift_source_ready
	sub	r11, r9
.__jabara_lift_source_ready:
	sub	rbp, r9
	mov	rsp, r8
	sub	rsp, r9
	mov	[rcx], rdi
	lea	rax, [r9 - 16]
	mov	[rcx + 8], rax
	mov	r8, rax
	test	r8, r8
	jz	.__jabara_lift_copied
	mov	rsi, r11
	lea	rdi, [rcx + 16]
.__jabara_lift_copy:
	mov	rax, [rsi]
	mov	[rdi], rax
	add	rsi, 8
	add	rdi, 8
	sub	r8, 8
	jnz	.__jabara_lift_copy
.__jabara_lift_copied:
	lea	rax, [rcx + 16]
	push	r10
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
