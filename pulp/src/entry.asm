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
	jmp die

gdt_init:
        lgdt [gdtr]
	mov ax, 0x10
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	push 0x08
	mov rax, gdt_init_ret
	push rax
	retfq
gdt_init_ret:
	ret

tss_init:
        mov eax, (5 * 8) | 0
        ltr ax
	ret

gdtr: ; null segment also
        dw gdt_end - gdt - 1
        dq gdt
gdt:
null:
	dd 0
	dd 0

kernel_code:
        dw 0xffff       ; limit
        dw 0x0000       ; base
        db 0            ; base
        db 0x9a         ; access byte
        db 10101111b    ; flags / limit
        db 0            ; base

kernel_data:
        dw 0xffff
        dw 0x0000
        db 0
        db 0x92
        db 11001111b
        db 0

user_code:
        dw 0xffff       ; limit
        dw 0x0000       ; base
        db 0            ; base
        db 0xfa         ; access byte
        db 10101111b     ; flags / limit
        db 0            ; base

user_data:
        dw 0xffff       ; limit
        dw 0            ; base
        db 0            ; base
        db 0xf2         ; access byte
        db 11001111b    ; flags / limit
        db 0            ; base

tss:
	dw 103		; limit
	dw TSS & 65535	; base
	db (TSS >> 16) & 255 ; base
	db 0x89		; access byte
	db 0		; flags (see https://wiki.osdev.org/Task_State_Segment)
	db (TSS >> 24) & 255 ; base
	dd (TSS >> 32)
	dd 0

gdt_end:

tss_start:
        dd 0 ; reserved
        dq 0x40000 ; rsp0
        dq 0 ; rsp1
        dq 0 ; rsp2
        dq 0 ; reserved
        dq 0x60000 ; ist1
        dq 0 ; ist2
        dq 0 ; ist3
        dq 0 ; ist4
        dq 0 ; ist5
        dq 0 ; ist6
        dq 0 ; ist7
        dq 0    ; reserved
        dw 0    ; reserved
        dw 103  ; iopb
tss_end:

TSS equ tss_start - sys + 0x10000
TSS_LEN equ tss_start - tss_end
TSS_SEG equ tss - gdt

flush_tlb:
	mov cr3, rdi
	ret

die:	cli
	hlt
	jmp die

proc_init:

	xor rax, rax
	mov [0x800000 + (0 << 3)], rax ; rax
	mov rax, 0x801000
	mov [0x800000 + (1 << 3)], rax ; rip
	mov rax, (3 * 8) | 3
	mov [0x800000 + (2 << 3)], rax ; cs
	xor rax, rax
	mov [0x800000 + (3 << 3)], rax ; rflags
	mov rax, 0x1000000
	mov [0x800000 + (4 << 3)], rax ; rsp
	mov rax, (4 * 8) | 3
	mov [0x800000 + (5 << 3)], rax ; ss

	xor rax, rax
	mov [0x800000 + (6 << 3)], rdi
	mov [0x800000 + (7 << 3)], rsi
	mov [0x800000 + (8 << 3)], rax ; rbx
	mov [0x800000 + (9 << 3)], rax ; rcx
	mov [0x800000 + (10 << 3)], rax ; rdx
	mov [0x800000 + (11 << 3)], rax ; rbp
	mov [0x800000 + (12 << 3)], rax ; r8
	mov [0x800000 + (13 << 3)], rax ; r9
	mov [0x800000 + (14 << 3)], rax ; r10
	mov [0x800000 + (15 << 3)], rax ; r11
	mov [0x800000 + (16 << 3)], rax ; r12
	mov [0x800000 + (17 << 3)], rax ; r13
	mov [0x800000 + (18 << 3)], rax ; r14
	mov [0x800000 + (19 << 3)], rax ; r15

	ret

sys_ptr: dq sys_handler
sys_handler:

	mov [0x800000 + (6 << 3)], rdi
	mov [0x800000 + (7 << 3)], rsi
	mov [0x800000 + (8 << 3)], rbx
	mov [0x800000 + (9 << 3)], rcx
	mov [0x800000 + (10 << 3)], rdx
	mov [0x800000 + (11 << 3)], rbp
	mov [0x800000 + (12 << 3)], r8
	mov [0x800000 + (13 << 3)], r9
	mov [0x800000 + (14 << 3)], r10
	mov [0x800000 + (15 << 3)], r11
	mov [0x800000 + (16 << 3)], r12
	mov [0x800000 + (17 << 3)], r13
	mov [0x800000 + (18 << 3)], r14
	mov [0x800000 + (19 << 3)], r15

	mov [0x800000 + (0 << 3)], rax ; store rax

	pop rax
	mov [0x800000 + (1 << 3)], rax ; rip
	pop rax
	mov [0x800000 + (2 << 3)], rax ; cs
	pop rax
	mov [0x800000 + (3 << 3)], rax ; rflags
	pop rax
	mov [0x800000 + (4 << 3)], rax ; rsp
	pop rax
	mov [0x800000 + (5 << 3)], rax ; ss


	sti
        mov ax, (2 *  8) | 0
        mov ss, ax
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov gs, ax

	mov rax, [0x800000 + (0 << 3)] ; restore rax

	shl rax, 3
	push rdi
	mov rdi, sys
	add rdi, rax
	mov rax, [rdi]
	pop rdi

	call rax

	mov [0x800000 + (0 << 3)], rax ; store rax

user_jmp:

        mov bx, (4 *  8) | 3
        mov ds, bx
        mov es, bx
        mov fs, bx
        mov gs, bx

	mov rax, [0x800000 + (5 << 3)] ; ss
	push rax
	mov rax, [0x800000 + (4 << 3)] ; rsp
	push rax
	mov rax, [0x800000 + (3 << 3)] ; rflags
	push rax
	mov rax, [0x800000 + (2 << 3)] ; cs
	push rax
	mov rax, [0x800000 + (1 << 3)] ; rip
	push rax

	mov rdi, [0x800000 + (6 << 3)]
	mov rsi, [0x800000 + (7 << 3)]
	mov rbx, [0x800000 + (8 << 3)]
	mov rcx, [0x800000 + (9 << 3)]
	mov rdx, [0x800000 + (10 << 3)]
	mov rbp, [0x800000 + (11 << 3)]
	mov r8, [0x800000 + (12 << 3)]
	mov r9, [0x800000 + (13 << 3)]
	mov r10, [0x800000 + (14 << 3)]
	mov r11, [0x800000 + (15 << 3)]
	mov r12, [0x800000 + (16 << 3)]
	mov r13, [0x800000 + (17 << 3)]
	mov r14, [0x800000 + (18 << 3)]
	mov r15, [0x800000 + (19 << 3)]

	mov rax, [0x800000 + (0 << 3)] ; restore rax

	iretq

sys_wait:
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
_pid:		dq 0
