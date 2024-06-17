org 0x10000

bits 64

sys:
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
	push rsi ; pointer to initrd
	pop rdi ; pointer to initrd
	call kmain

die:
	cli
	hlt
	jmp die

sys_wait:
	pushf
	pop rax
	and rax, 1 << 9
	jnz ints_enabled
	call kb_poll
	ret

ints_enabled:
	hlt
	ret

kb_poll:
	push rax
	push rdi
        xor rax, rax
        in al, 0x60
	cmp byte [last_scancode], al
	je kb_bail
	mov byte [last_scancode], al
        mov rdi, rax
	call sys_keyboard
kb_bail:
	pop rdi
	pop rax
	ret

last_scancode: db 0

; Global variables

_scr:		dq 0
_kb:		dq 0
_ramfs:		dq 0
_brk:		dq 0
_page:		dq 0
_idt:		dq 0
_idtr:		dq 0
