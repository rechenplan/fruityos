org 0x10000

bits 64

start:
	dq sys_open
	dq sys_creat
	dq sys_close
	dq sys_read
	dq sys_write
	dq sys_fgetch
	dq sys_fputch
	dq sys_seek
	dq sys_getch
	dq sys_putch
	dq sys_getcwd
	dq sys_getdents64
	dq sys_rename
	dq sys_mkdir
	dq sys_rmdir
	dq sys_chdir
	dq sys_unlink
	dq sys_exec
	dq sys_fork
	dq sys_waitpid
	dq sys_dup2
	dq sys_brk
	dq sys_mmap
	dq sys_exit
	dq sys_stub
	dq sys_stub
	dq sys_stub
	dq sys_stub
	dq sys_stub
	dq sys_stub
	dq sys_stub
	dq sys_keyboard

entry:
	mov rax, kmain
	call rax

spin:
	hlt
	jmp spin

_scr:		dq 0
_kb:		dq 0
