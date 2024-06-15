bits 64

idt_init:

        ; Create IDT. Autopopulate with pointers to default isr routine.
        mov rdi, IDT_ADDR
	mov rcx, 255
idt:    mov ax, isr
        stosw
        mov ax, 0x08 ; CODE_SEG
        stosw
        mov ax, 0x8e00 ; interrupt gate
        stosw
	mov ax, 1 ; 0x10000 origin
        stosw
        xor rax, rax
        stosd
        stosd
        loop idt

	; Exceptions
	mov word [IDT_ADDR + 0x00 * 16], de
	mov word [IDT_ADDR + 0x01 * 16], db
	mov word [IDT_ADDR + 0x02 * 16], isr
	mov word [IDT_ADDR + 0x03 * 16], bp1
	mov word [IDT_ADDR + 0x04 * 16], of
	mov word [IDT_ADDR + 0x05 * 16], br
	mov word [IDT_ADDR + 0x06 * 16], ud
	mov word [IDT_ADDR + 0x07 * 16], nm
	mov word [IDT_ADDR + 0x08 * 16], df
	mov word [IDT_ADDR + 0x09 * 16], isr
	mov word [IDT_ADDR + 0x0A * 16], ts
	mov word [IDT_ADDR + 0x0B * 16], np
	mov word [IDT_ADDR + 0x0C * 16], ss1
	mov word [IDT_ADDR + 0x0D * 16], gp
	mov word [IDT_ADDR + 0x0E * 16], pf
	mov word [IDT_ADDR + 0x0F * 16], isr
	mov word [IDT_ADDR + 0x10 * 16], mf
	mov word [IDT_ADDR + 0x11 * 16], ac
	mov word [IDT_ADDR + 0x12 * 16], mc
	mov word [IDT_ADDR + 0x13 * 16], xm
	mov word [IDT_ADDR + 0x14 * 16], ve
	mov word [IDT_ADDR + 0x15 * 16], cp
	mov word [IDT_ADDR + 0x16 * 16], isr
	mov word [IDT_ADDR + 0x17 * 16], isr
	mov word [IDT_ADDR + 0x18 * 16], isr
	mov word [IDT_ADDR + 0x19 * 16], isr
	mov word [IDT_ADDR + 0x1A * 16], isr
	mov word [IDT_ADDR + 0x1B * 16], isr
	mov word [IDT_ADDR + 0x1C * 16], hv
	mov word [IDT_ADDR + 0x1D * 16], vc
	mov word [IDT_ADDR + 0x1E * 16], sx
	mov word [IDT_ADDR + 0x1F * 16], isr

	; IRQs
        mov word [IDT_ADDR + 0x20 * 16], irq0
        mov word [IDT_ADDR + 0x21 * 16], irq1
        mov word [IDT_ADDR + 0x22 * 16], irq
        mov word [IDT_ADDR + 0x23 * 16], irq
        mov word [IDT_ADDR + 0x24 * 16], irq
        mov word [IDT_ADDR + 0x25 * 16], irq
        mov word [IDT_ADDR + 0x26 * 16], irq
        mov word [IDT_ADDR + 0x27 * 16], irq
        mov word [IDT_ADDR + 0x28 * 16], irq
        mov word [IDT_ADDR + 0x29 * 16], irq
        mov word [IDT_ADDR + 0x2a * 16], irq
        mov word [IDT_ADDR + 0x2b * 16], irq
        mov word [IDT_ADDR + 0x2c * 16], irq
        mov word [IDT_ADDR + 0x2d * 16], irq
        mov word [IDT_ADDR + 0x2e * 16], irq
        mov word [IDT_ADDR + 0x2f * 16], irq

	; Load idt
	lidt [idtr]

	; Enable interrupts
	sti
	ret

idtr:	dw (256 * 16) - 1
        dq IDT_ADDR

	; division error
de:	mov rdi, de_msg
	call kprintln
	jmp die
de_msg:	db "Exception: Division Error", 0

	; debug
db:	mov rdi, db_msg
	call kprintln
	jmp die
db_msg:	db "Exception: Debug", 0

	; breakpoint
bp1:	mov rdi, bp_msg
	call kprintln
	jmp die
bp_msg: db "Exception: Breakpoint", 0

	; overflow
of:	mov rdi, of_msg
	call kprintln
	jmp die
of_msg:	db "Exception: Overflow", 0

	; bound range
br:	mov rdi, br_msg
	call kprintln
	jmp die
br_msg:	db "Exception: Bound Range", 0

	; invalid opcode
ud:	mov rdi, ud_msg
	call kprintln
	jmp die
ud_msg:	db "Exception: Invalid Opcode", 0

	; device not available
nm:	mov rdi, nm_msg
	call kprintln
	jmp die
nm_msg:	db "Exception: Device Not Available", 0

	; double fault
df:	mov rdi, df_msg
	call kprintln
	jmp die
df_msg:	db "Exception: Double Fault. Stopping.", 0

	; invalid tss
ts:	mov rdi, ts_msg
	call kprintln
	add sp, 8
	jmp die
ts_msg:	db "Exception: Invalid TSS", 0

	; Segment not present
np:	mov rdi, np_msg
	call kprintln
	add sp, 8
	jmp die
np_msg:	db "Exception: Segment Not Present", 0

	; Stack segment fault
ss1:	mov rdi, ss_msg
	call kprintln
	add sp, 8
	jmp die
ss_msg:	db "Exception: Stack Segment Fault", 0

	; General protection fault
gp:	mov rdi, gp_msg
	call kprintln
	add sp, 8
	jmp die
gp_msg:	db "Exception: General Protection Fault", 0

	; Page Fault
pf:	mov rdi, pf_msg
	call kprintln
	add sp, 8
	jmp die
pf_msg:	db "Exception: Page Fault", 0

	; x87 floating-poiunt exception
mf:	mov rdi, mf_msg
	call kprintln
	jmp die
mf_msg:	db "Exception: x87 Floating Point Exception", 0

	; Alignment Check
ac:	mov rdi, ac_msg
	call kprintln
	add sp, 8
	jmp die
ac_msg:	db "Exception: Alignment Check", 0

	; machine check
mc:	mov rdi, mc_msg
	call kprintln
	jmp die
mc_msg:	db "Exception: Machine Check. Stopping.", 0

	; SIMD floating point exception
xm:	mov rdi, xm_msg
	call kprintln
	jmp die
xm_msg:	db "Exception: SIMD Floating Point Exception", 0

	; Virtualization Exception
ve:	mov rdi, ve_msg
	call kprintln
	jmp die
ve_msg:	db "Exception: Virtualization Exception", 0

	; control protection exception
cp:	mov rdi, cp_msg
	call kprintln
	add sp, 8
	jmp die
cp_msg:	db "Exception: Control Protection Exception", 0

	; hypervisor injection exception
hv:	mov rdi, hv_msg
	call kprintln
	jmp die
hv_msg:	db "Exception: Hypervisor Injection Exception", 0

	; VmM COMMUNICATION EXCEPTION
vc:	mov rdi, vc_msg
	call kprintln
	add sp, 8
	jmp die
vc_msg:	db "Exception: VMM Communication Exception", 0

	; Security Exception
sx:	mov rdi, sx_msg
	call kprintln
	add sp, 8
	jmp die
sx_msg:	db "Exception: Security Exception", 0


        ; Default isr (no error code)
isr:    iretq

	; generic IRQ handler
irq:	; ack irq
	push rax
        mov al, 0x20
        out 0x20, al
        out 0xa0, al
	pop rax
	iretq

	; IRQ0 handler (timer)
irq0:
	; ack irq
	push rax
	mov al, 0x20
	out 0x20, al
	out 0xa0, al
	pop rax
	sti
	iretq

        ; IRQ1 handler (keyboard)
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
