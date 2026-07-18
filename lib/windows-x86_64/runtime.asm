; Windows x86-64 Pith runtime.  Jabara keeps its compact stack ABI; these
; wrappers adapt it to the Microsoft x64 ABI and a kernel32 import table.

; Runtime dependencies introduced by wrapper implementations.
%ifdef PITH_getch
%define PITH_fgetch
%endif
%ifdef PITH_putch
%define PITH_fputch
%endif

; The process entry path always needs these three APIs. Other imports are
; derived from the Pith surface actually emitted by the Jabara compiler.
%define WIN_IMPORT_ExitProcess
%define WIN_IMPORT_GetCommandLineA
%define WIN_IMPORT_VirtualAlloc

%ifdef PITH_close
%define WIN_IMPORT_CloseHandle
%endif
%ifdef PITH_open
%define WIN_IMPORT_CreateFileA
%define WIN_IMPORT_GetFileAttributesA
%endif
%ifdef PITH_creat
%define WIN_IMPORT_CreateFileA
%endif
%ifdef PITH_read
%define WIN_IMPORT_GetStdHandle
%define WIN_IMPORT_ReadFile
%endif
%ifdef PITH_write
%define WIN_IMPORT_GetStdHandle
%define WIN_IMPORT_WriteFile
%endif
%ifdef PITH_fgetch
%define WIN_IMPORT_GetStdHandle
%define WIN_IMPORT_ReadFile
%endif
%ifdef PITH_fputch
%define WIN_IMPORT_GetStdHandle
%define WIN_IMPORT_WriteFile
%endif
%ifdef PITH_seek
%define WIN_IMPORT_GetStdHandle
%define WIN_IMPORT_SetFilePointer
%endif
%ifdef PITH_getcwd
%define WIN_IMPORT_GetCurrentDirectoryA
%endif
%ifdef PITH_chdir
%define WIN_IMPORT_SetCurrentDirectoryA
%endif
%ifdef PITH_unlink
%define WIN_IMPORT_DeleteFileA
%endif
%ifdef PITH_rename
%define WIN_IMPORT_MoveFileExA
%endif
%ifdef PITH_mkdir
%define WIN_IMPORT_CreateDirectoryA
%endif
%ifdef PITH_rmdir
%define WIN_IMPORT_RemoveDirectoryA
%endif
%ifdef PITH_getdents64
%define WIN_IMPORT_FindClose
%define WIN_IMPORT_FindFirstFileA
%define WIN_IMPORT_FindNextFileA
%endif
%ifdef PITH_exec
%define WIN_IMPORT_CloseHandle
%define WIN_IMPORT_CreateProcessA
%define WIN_IMPORT_WaitForSingleObject
%endif

__win_call:
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 32
	call rax
	mov rsp, r12
	pop r12
	ret

__win_heap_init:
	mov rax, [rel __win_brk_base]
	test rax, rax
	jne __win_heap_init_done
	xor rcx, rcx
	mov rdx, 0x8000000
	mov r8d, 0x3000
	mov r9d, 4
	mov rax, [rel __imp_VirtualAlloc]
	call __win_call
	mov [rel __win_brk_base], rax
	mov [rel __win_brk_current], rax
__win_heap_init_done:
	ret

; RCX = bytes, RAX = monotonically allocated storage.
__win_heap_alloc:
	push r13
	mov r13, rcx
	call __win_heap_init
	add r13, 7
	and r13, -8
	mov rax, [rel __win_brk_current]
	mov rdx, rax
	add rdx, r13
	mov [rel __win_brk_current], rdx
	pop r13
	ret

%ifdef WIN_IMPORT_GetStdHandle
; RAX = Pith fd, RAX = Windows HANDLE.
__win_fd_handle:
	cmp rax, 0
	je __win_fd_handle_stdin
	cmp rax, 1
	je __win_fd_handle_stdout
	cmp rax, 2
	je __win_fd_handle_stderr
	ret
__win_fd_handle_stdin:
	mov ecx, -10
	jmp __win_fd_handle_standard
__win_fd_handle_stdout:
	mov ecx, -11
	jmp __win_fd_handle_standard
__win_fd_handle_stderr:
	mov ecx, -12
__win_fd_handle_standard:
	mov rax, [rel __imp_GetStdHandle]
	call __win_call
	ret

%endif

; Build a contiguous NUL-separated argv area from GetCommandLineA.
; Returns RAX = argc, RDX = argv text.
__win_init_args:
	push rbx
	push rsi
	push rdi
	xor rcx, rcx
	mov rax, [rel __imp_GetCommandLineA]
	call __win_call
	mov rsi, rax
	mov rcx, 32768
	call __win_heap_alloc
	mov rdi, rax
	mov rdx, rax
	xor ebx, ebx
__win_init_args_skip:
	movzx eax, byte [rsi]
	cmp al, 32
	je __win_init_args_skip_one
	cmp al, 9
	jne __win_init_args_token
__win_init_args_skip_one:
	add rsi, 1
	jmp __win_init_args_skip
__win_init_args_token:
	test al, al
	jz __win_init_args_finished
	add ebx, 1
	xor r10d, r10d
__win_init_args_copy:
	movzx eax, byte [rsi]
	test al, al
	jz __win_init_args_token_end
	cmp eax,34
	jne __win_init_args_not_quote
	movzx ecx,byte [rsi+1]
	cmp ecx,34
	jne __win_init_args_toggle_quote
	mov [rdi],al
	add rdi,1
	add rsi,2
	jmp __win_init_args_copy
__win_init_args_toggle_quote:
	xor r10d,1
	add rsi,1
	jmp __win_init_args_copy
__win_init_args_not_quote:
	test r10d, r10d
	jnz __win_init_args_store
	cmp al, 32
	je __win_init_args_token_end
	cmp al, 9
	je __win_init_args_token_end
__win_init_args_store:
	mov [rdi], al
	add rdi, 1
	add rsi, 1
	jmp __win_init_args_copy
__win_init_args_token_end:
	test eax,eax
	jz __win_init_args_last_token
	xor eax,eax
	mov [rdi],al
	add rdi,1
	jmp __win_init_args_skip
__win_init_args_last_token:
	mov [rdi],al
	add rdi,1
	jmp __win_init_args_finished
__win_init_args_finished:
	xor eax, eax
	mov [rdi], al
	mov eax, ebx
	pop rdi
	pop rsi
	pop rbx
	ret

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


%ifdef PITH_brk
brk:
	pop r10
	pop rcx
	push r10
	call __win_heap_init
	cmp rcx, -1
	je brk_query
	mov [rel __win_brk_current], rcx
	mov rax, rcx
	ret
brk_query:
	mov rax, [rel __win_brk_current]
	ret
%endif

%ifdef PITH_mmap
mmap:
	pop r10
	pop r9
	pop r8
	pop r11
	pop r11
	pop rdx
	pop rcx
	push r10
	mov r8d, 0x3000
	mov r9d, 0x40
	mov rax, [rel __imp_VirtualAlloc]
	jmp __win_call
%endif

%ifdef PITH_close
close:
	pop r10
	pop rax
	push r10
	mov rdx, rax
	and edx, 1
	jnz close_ok
	cmp rax, 2
	jbe close_ok
	mov rcx, rax
	mov rax, [rel __imp_CloseHandle]
	call __win_call
	ret
close_ok:
	xor eax, eax
	ret
%endif

%ifdef WIN_IMPORT_CreateFileA
; CreateFileA helper: RCX path, EDX access, R10D disposition, R11D attrs.
__win_create_file:
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 64
	mov r8d, 7
	xor r9d, r9d
	mov [rsp + 32], r10d
	mov [rsp + 40], r11d
	mov qword [rsp + 48], 0
	mov rax, [rel __imp_CreateFileA]
	call rax
	mov rsp, r12
	pop r12
	ret

%endif

%ifdef PITH_open
open:
	pop r10
	pop r13
	pop rdi
	push r10
	push rbx
	mov rcx, rdi
	mov rax, [rel __imp_GetFileAttributesA]
	call __win_call
	cmp eax, -1
	je open_file
	and eax, 0x10
	jz open_file
	mov rcx, 1040
	call __win_heap_alloc
	mov rbx, rax
	mov qword [rbx], 0x524944
	lea rdx, [rbx + 16]
open_copy_path:
	movzx eax, byte [rdi]
	mov [rdx], al
	add rdi, 1
	add rdx, 1
	test al, al
	jnz open_copy_path
	lea rax, [rbx + 1]
	pop rbx
	ret
open_file:
	mov rcx, rdi
	mov edx, 0x80000000
	cmp r13, 2
	jne open_access_ready
	mov edx, 0xc0000000
open_access_ready:
	mov r10d, 3
	mov r11d, 0x80
	call __win_create_file
	pop rbx
	ret
%endif

%ifdef PITH_creat
creat:
	pop r10
	pop rcx
	push r10
	mov edx, 0xc0000000
	mov r10d, 2
	mov r11d, 0x80
	jmp __win_create_file
%endif

%ifdef PITH_read
read:
	pop r10
	pop r8
	pop rdx
	pop rax
	push r10
	call __win_fd_handle
	mov rcx, rax
	lea r9, [rel __win_io_count]
	mov dword [r9], 0
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 48
	mov qword [rsp + 32], 0
	mov rax, [rel __imp_ReadFile]
	call rax
	mov rsp, r12
	pop r12
	test eax, eax
	jz read_fail
	mov eax, [rel __win_io_count]
	ret
read_fail:
	mov rax, -1
	ret
%endif

%ifdef PITH_write
write:
	pop r10
	pop r8
	pop rdx
	pop rax
	push r10
	call __win_fd_handle
	mov rcx, rax
	lea r9, [rel __win_io_count]
	mov dword [r9], 0
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 48
	mov qword [rsp + 32], 0
	mov rax, [rel __imp_WriteFile]
	call rax
	mov rsp, r12
	pop r12
	test eax, eax
	jz write_fail
	mov eax, [rel __win_io_count]
	ret
write_fail:
	mov rax, -1
	ret
%endif

%ifdef PITH_fgetch
fgetch:
	pop r10
	pop rax
	push r10
	call __win_fd_handle
	mov rcx, rax
	lea rdx, [rel __win_char]
	mov r8d, 1
	lea r9, [rel __win_io_count]
	mov dword [r9], 0
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 48
	mov qword [rsp + 32], 0
	mov rax, [rel __imp_ReadFile]
	call rax
	mov rsp, r12
	pop r12
	mov eax, [rel __win_io_count]
	test eax, eax
	jz fgetch_eof
	xor eax, eax
	mov al, [rel __win_char]
	ret
fgetch_eof:
	xor eax, eax
	ret
%endif

%ifdef PITH_getch
getch:
	push 0
	call fgetch
	ret
%endif

%ifdef PITH_fputch
fputch:
	pop r10
	pop rdx
	pop rax
	push r10
	mov [rel __win_char], dl
	call __win_fd_handle
	mov rcx, rax
	lea rdx, [rel __win_char]
	mov r8d, 1
	lea r9, [rel __win_io_count]
	mov dword [r9], 0
	push r12
	mov r12, rsp
	and rsp, -16
	sub rsp, 48
	mov qword [rsp + 32], 0
	mov rax, [rel __imp_WriteFile]
	call rax
	mov rsp, r12
	pop r12
	xor eax, eax
	mov al, [rel __win_char]
	ret
%endif

%ifdef PITH_putch
putch:
	pop r10
	pop rdx
	push 1
	push rdx
	push r10
	jmp fputch
%endif

%ifdef PITH_seek
seek:
	pop r10
	pop r9
	pop rdx
	pop rax
	push r10
	call __win_fd_handle
	mov rcx, rax
	xor r8d, r8d
	mov rax, [rel __imp_SetFilePointer]
	call __win_call
	ret
%endif

%ifdef PITH_getcwd
getcwd:
	pop r10
	pop rcx
	pop rdx
	push r10
	push rdx
	mov rax, [rel __imp_GetCurrentDirectoryA]
	call __win_call
	pop rdx
	push rax
getcwd_normalize:
	movzx eax, byte [rdx]
	test al, al
	jz getcwd_done
	cmp al, 92
	jne getcwd_next
	mov al, 47
	mov [rdx], al
getcwd_next:
	add rdx, 1
	jmp getcwd_normalize
getcwd_done:
	pop rax
	ret
%endif

%ifdef PITH_chdir
chdir:
	pop r10
	pop rcx
	push r10
	mov rax, [rel __imp_SetCurrentDirectoryA]
	call __win_call
	test eax, eax
	jz chdir_fail
	xor eax, eax
	ret
chdir_fail:
	mov rax, -1
	ret
%endif

%ifdef PITH_unlink
unlink:
	pop r10
	pop rcx
	push r10
	mov rax,[rel __imp_DeleteFileA]
	call __win_call
	test eax,eax
	jz unlink_fail
	xor eax,eax
	ret
unlink_fail:
	mov rax,-1
	ret
%endif

%ifdef PITH_rename
rename:
	pop r10
	pop rdx
	pop rcx
	push r10
	mov r8d, 1
	mov rax,[rel __imp_MoveFileExA]
	call __win_call
	test eax,eax
	jz rename_fail
	xor eax,eax
	ret
rename_fail:
	mov rax,-1
	ret
%endif

%ifdef PITH_mkdir
mkdir:
	pop r10
	pop rcx
	push r10
	xor edx, edx
	mov rax,[rel __imp_CreateDirectoryA]
	call __win_call
	test eax,eax
	jz mkdir_fail
	xor eax,eax
	ret
mkdir_fail:
	mov rax,-1
	ret
%endif

%ifdef PITH_rmdir
rmdir:
	pop r10
	pop rcx
	push r10
	mov rax,[rel __imp_RemoveDirectoryA]
	call __win_call
	test eax,eax
	jz rmdir_fail
	xor eax,eax
	ret
rmdir_fail:
	mov rax,-1
	ret
%endif

%ifdef PITH_getdents64
getdents64:
	pop r10
	pop r15
	pop r14
	pop rax
	push r10
	push rbx
	push rsi
	push rdi
	push r12
	push r13
	push rbp
	push r14
	and rax,-2
	lea rsi,[rax+16]
	mov rcx,1040
	call __win_heap_alloc
	mov rbp,rax
	mov rdi,rax
getdents64_copy_dir:
	movzx eax,byte [rsi]
	test eax,eax
	jz getdents64_append
	mov [rdi],al
	add rsi,1
	add rdi,1
	jmp getdents64_copy_dir
getdents64_append:
	mov eax,10799
	mov [rdi],ax
	xor eax,eax
	mov [rdi+2],al
	mov rcx,592
	call __win_heap_alloc
	mov r12,rax
	mov rcx,rbp
	mov rdx,r12
	mov rax,[rel __imp_FindFirstFileA]
	call __win_call
	cmp rax,-1
	je getdents64_none
	mov r13,rax
	add r15,r14
getdents64_entry:
	lea rsi,[r12+44]
	mov rdx,rsi
	xor ecx,ecx
getdents64_name_len:
	movzx eax,byte [rdx]
	test eax,eax
	jz getdents64_have_len
	add rdx,1
	add rcx,1
	jmp getdents64_name_len
getdents64_have_len:
	lea rbx,[rcx+27]
	and rbx,-8
	lea rax,[r14+rbx]
	cmp rax,r15
	jg getdents64_finish
	mov edx,[r12+28]
	shl rdx,32
	mov eax,[r12+32]
	or rax,rdx
	mov [r14],rax
	mov qword [r14+8],0
	mov [r14+16],bx
	mov al,8
	mov edx,[r12]
	and edx,16
	jz getdents64_type_ready
	mov al,4
getdents64_type_ready:
	mov [r14+18],al
	lea rdi,[r14+19]
getdents64_copy_name:
	movzx eax,byte [rsi]
	mov [rdi],al
	add rsi,1
	add rdi,1
	test eax,eax
	jnz getdents64_copy_name
	add r14,rbx
	mov rcx,r13
	mov rdx,r12
	mov rax,[rel __imp_FindNextFileA]
	call __win_call
	test eax,eax
	jnz getdents64_entry
getdents64_finish:
	mov rcx,r13
	mov rax,[rel __imp_FindClose]
	call __win_call
	mov rax,r14
	mov rdx,[rsp]
	sub rax,rdx
	jmp getdents64_return
getdents64_none:
	xor eax,eax
getdents64_return:
	add rsp,8
	pop rbp
	pop r13
	pop r12
	pop rdi
	pop rsi
	pop rbx
	ret
%endif

%ifdef PITH_exec
exec:
	pop r10
	pop rsi
	pop r13
	push r10
	push rbx
	push rdi
	push r12
	push r14
	push r15
	mov rcx,32768
	call __win_heap_alloc
	mov r12,rax
	mov rdi,rax
exec_args:
	mov rbx,[rsi]
	test rbx,rbx
	jz exec_args_done
	mov al,34
	mov [rdi],al
	add rdi,1
exec_copy_arg:
	movzx eax,byte [rbx]
	test eax,eax
	jz exec_arg_done
	cmp eax,34
	jne exec_copy_plain
	mov ax,0x2222
	mov [rdi],ax
	add rbx,1
	add rdi,2
	jmp exec_copy_arg
exec_copy_plain:
	mov [rdi],al
	add rbx,1
	add rdi,1
	jmp exec_copy_arg
exec_arg_done:
	mov eax,8226
	mov [rdi],ax
	add rdi,2
	add rsi,8
	jmp exec_args
exec_args_done:
	cmp rdi,r12
	je exec_empty
	xor eax,eax
	mov [rdi-1],al
	jmp exec_allocate
exec_empty:
	xor eax,eax
	mov [rdi],al
exec_allocate:
	mov rcx,128
	call __win_heap_alloc
	mov r14,rax
	mov rdi,rax
	xor eax,eax
	mov ecx,128
	db 243,170
	mov dword [r14],104
	mov rcx,24
	call __win_heap_alloc
	mov r15,rax
	mov rcx,r13
	mov rdx,r12
	xor r8d,r8d
	xor r9d,r9d
	push rbp
	mov rbp,rsp
	and rsp,-16
	sub rsp,96
	mov qword [rsp+32],1
	mov qword [rsp+40],0
	mov qword [rsp+48],0
	mov qword [rsp+56],0
	mov [rsp+64],r14
	mov [rsp+72],r15
	mov rax,[rel __imp_CreateProcessA]
	call rax
	mov rsp,rbp
	pop rbp
	test eax,eax
	jz exec_fail
	mov rcx,[r15]
	mov edx,-1
	mov rax,[rel __imp_WaitForSingleObject]
	call __win_call
	mov rcx,[r15+8]
	mov rax,[rel __imp_CloseHandle]
	call __win_call
	mov rcx,[r15]
	mov rax,[rel __imp_CloseHandle]
	call __win_call
	mov eax,1
	jmp exec_done
exec_fail:
	xor eax,eax
exec_done:
	pop r15
	pop r14
	pop r12
	pop rdi
	pop rbx
	ret
%endif

%ifdef PITH_fork
fork:
	mov rax, -1
	ret
%endif

%ifdef PITH_waitpid
waitpid:
	pop r10
	pop rax
	push r10
	xor eax, eax
	ret
%endif

%ifdef PITH_dup2
dup2:
	pop r10
	pop rax
	pop rax
	push r10
	xor eax, eax
	ret
%endif

%ifdef PITH_exit
exit:
	pop r10
	pop rcx
	push r10
	mov rax, [rel __imp_ExitProcess]
	call __win_call
	hlt
%endif

%ifdef PITH_juicer_decode64
%define JUICER_LONG_ONLY
%endif

align 8
__win_brk_base: dq 0
__win_brk_current: dq 0
__win_io_count: dd 0
__win_char: db 0

align 8
__win_imports:
	dd __win_ilt-WIN_IMAGE_BASE
	dd 0,0
	dd __win_kernel32_name-WIN_IMAGE_BASE
	dd __win_iat-WIN_IMAGE_BASE
	dd 0,0,0,0,0
__win_imports_end:

__win_ilt:
%ifdef WIN_IMPORT_CloseHandle
	dq __win_name_CloseHandle-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_CreateDirectoryA
	dq __win_name_CreateDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_CreateFileA
	dq __win_name_CreateFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_CreateProcessA
	dq __win_name_CreateProcessA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_DeleteFileA
	dq __win_name_DeleteFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_ExitProcess
	dq __win_name_ExitProcess-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_FindClose
	dq __win_name_FindClose-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_FindFirstFileA
	dq __win_name_FindFirstFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_FindNextFileA
	dq __win_name_FindNextFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetCommandLineA
	dq __win_name_GetCommandLineA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetCurrentDirectoryA
	dq __win_name_GetCurrentDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetFileAttributesA
	dq __win_name_GetFileAttributesA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetStdHandle
	dq __win_name_GetStdHandle-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_MoveFileExA
	dq __win_name_MoveFileExA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_ReadFile
	dq __win_name_ReadFile-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_RemoveDirectoryA
	dq __win_name_RemoveDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_SetCurrentDirectoryA
	dq __win_name_SetCurrentDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_SetFilePointer
	dq __win_name_SetFilePointer-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_VirtualAlloc
	dq __win_name_VirtualAlloc-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_WaitForSingleObject
	dq __win_name_WaitForSingleObject-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_WriteFile
	dq __win_name_WriteFile-WIN_IMAGE_BASE
%endif
	dq 0

__win_iat:
%ifdef WIN_IMPORT_CloseHandle
__imp_CloseHandle: dq __win_name_CloseHandle-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_CreateDirectoryA
__imp_CreateDirectoryA: dq __win_name_CreateDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_CreateFileA
__imp_CreateFileA: dq __win_name_CreateFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_CreateProcessA
__imp_CreateProcessA: dq __win_name_CreateProcessA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_DeleteFileA
__imp_DeleteFileA: dq __win_name_DeleteFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_ExitProcess
__imp_ExitProcess: dq __win_name_ExitProcess-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_FindClose
__imp_FindClose: dq __win_name_FindClose-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_FindFirstFileA
__imp_FindFirstFileA: dq __win_name_FindFirstFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_FindNextFileA
__imp_FindNextFileA: dq __win_name_FindNextFileA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetCommandLineA
__imp_GetCommandLineA: dq __win_name_GetCommandLineA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetCurrentDirectoryA
__imp_GetCurrentDirectoryA: dq __win_name_GetCurrentDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetFileAttributesA
__imp_GetFileAttributesA: dq __win_name_GetFileAttributesA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_GetStdHandle
__imp_GetStdHandle: dq __win_name_GetStdHandle-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_MoveFileExA
__imp_MoveFileExA: dq __win_name_MoveFileExA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_ReadFile
__imp_ReadFile: dq __win_name_ReadFile-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_RemoveDirectoryA
__imp_RemoveDirectoryA: dq __win_name_RemoveDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_SetCurrentDirectoryA
__imp_SetCurrentDirectoryA: dq __win_name_SetCurrentDirectoryA-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_SetFilePointer
__imp_SetFilePointer: dq __win_name_SetFilePointer-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_VirtualAlloc
__imp_VirtualAlloc: dq __win_name_VirtualAlloc-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_WaitForSingleObject
__imp_WaitForSingleObject: dq __win_name_WaitForSingleObject-WIN_IMAGE_BASE
%endif
%ifdef WIN_IMPORT_WriteFile
__imp_WriteFile: dq __win_name_WriteFile-WIN_IMAGE_BASE
%endif
	dq 0
__win_iat_end:

__win_kernel32_name: db "KERNEL32.dll",0
%ifdef WIN_IMPORT_CloseHandle
align 2
__win_name_CloseHandle: dw 0
	db "CloseHandle",0
%endif
%ifdef WIN_IMPORT_CreateDirectoryA
align 2
__win_name_CreateDirectoryA: dw 0
	db "CreateDirectoryA",0
%endif
%ifdef WIN_IMPORT_CreateFileA
align 2
__win_name_CreateFileA: dw 0
	db "CreateFileA",0
%endif
%ifdef WIN_IMPORT_CreateProcessA
align 2
__win_name_CreateProcessA: dw 0
	db "CreateProcessA",0
%endif
%ifdef WIN_IMPORT_DeleteFileA
align 2
__win_name_DeleteFileA: dw 0
	db "DeleteFileA",0
%endif
%ifdef WIN_IMPORT_ExitProcess
align 2
__win_name_ExitProcess: dw 0
	db "ExitProcess",0
%endif
%ifdef WIN_IMPORT_FindClose
align 2
__win_name_FindClose: dw 0
	db "FindClose",0
%endif
%ifdef WIN_IMPORT_FindFirstFileA
align 2
__win_name_FindFirstFileA: dw 0
	db "FindFirstFileA",0
%endif
%ifdef WIN_IMPORT_FindNextFileA
align 2
__win_name_FindNextFileA: dw 0
	db "FindNextFileA",0
%endif
%ifdef WIN_IMPORT_GetCommandLineA
align 2
__win_name_GetCommandLineA: dw 0
	db "GetCommandLineA",0
%endif
%ifdef WIN_IMPORT_GetCurrentDirectoryA
align 2
__win_name_GetCurrentDirectoryA: dw 0
	db "GetCurrentDirectoryA",0
%endif
%ifdef WIN_IMPORT_GetFileAttributesA
align 2
__win_name_GetFileAttributesA: dw 0
	db "GetFileAttributesA",0
%endif
%ifdef WIN_IMPORT_GetStdHandle
align 2
__win_name_GetStdHandle: dw 0
	db "GetStdHandle",0
%endif
%ifdef WIN_IMPORT_MoveFileExA
align 2
__win_name_MoveFileExA: dw 0
	db "MoveFileExA",0
%endif
%ifdef WIN_IMPORT_ReadFile
align 2
__win_name_ReadFile: dw 0
	db "ReadFile",0
%endif
%ifdef WIN_IMPORT_RemoveDirectoryA
align 2
__win_name_RemoveDirectoryA: dw 0
	db "RemoveDirectoryA",0
%endif
%ifdef WIN_IMPORT_SetCurrentDirectoryA
align 2
__win_name_SetCurrentDirectoryA: dw 0
	db "SetCurrentDirectoryA",0
%endif
%ifdef WIN_IMPORT_SetFilePointer
align 2
__win_name_SetFilePointer: dw 0
	db "SetFilePointer",0
%endif
%ifdef WIN_IMPORT_VirtualAlloc
align 2
__win_name_VirtualAlloc: dw 0
	db "VirtualAlloc",0
%endif
%ifdef WIN_IMPORT_WaitForSingleObject
align 2
__win_name_WaitForSingleObject: dw 0
	db "WaitForSingleObject",0
%endif
%ifdef WIN_IMPORT_WriteFile
align 2
__win_name_WriteFile: dw 0
	db "WriteFile",0
%endif

__win_section_virtual_size equ __win_file_end-__win_section_start
__win_section_raw_size equ __win_file_end-__win_section_start
__win_image_size equ __win_file_end-WIN_IMAGE_BASE
