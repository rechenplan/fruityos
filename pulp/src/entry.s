org 0x10000

bits 64

%define IDT_ADDR 0xF000

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

        ; Create IDT
        mov rdi, IDT_ADDR
        xor rcx, rcx
        dec cl
idt:    mov ax, irq
        stosw
        mov ax, 0x08 ; CODE_SEG
        stosw
        mov ax, 0x8e00
        stosw
	mov ax, 1 ; 0x10000 origin
        stosw
        xor rax, rax
        stosd
        stosd
        loop idt

        ; Set keyboard handler on int 0x21 (IRQ1)
        mov word [IDT_ADDR + 0x21 * 16], irq1
	;mov word [IDT_ADDR + 0x21 * 16 + 6], 1

	; Load idt
	lidt [idtr]

	; Enable interrupts
	sti

	pop rdi ; pointer to initrd
	call kmain

die:
	hlt
	jmp die


idtr:
        dw (256 * 16) - 1
        dq IDT_ADDR

halt:
	hlt
	ret

        ; IRQ1 handler
irq1:   cli
        push rax
        push rcx
        push rdx
        push rsi
        push rdi
        push r8
        push r9
        push r10
        push r11
        xor rax, rax
        in al, 0x60
        mov rdi, rax
        call sys_keyboard
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdi
        pop rsi
        pop rdx
        pop rcx
        ; ack irq
        mov al, 0x20
        out 0x20, al
        out 0xa0, al
        pop rax
        sti
        iretq

        ; Default IRQ isr
irq:    cli
        push rax
        mov al, 0x20
        out 0x20, al
        out 0xa0, al
        pop rax
        sti
        iretq

; Global variables

_scr:		dq 0
_kb:		dq 0
_ramfs:		dq 0
_brk:		dq 0
_page:		dq 0
