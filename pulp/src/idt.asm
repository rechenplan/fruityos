bits 64

idt_load:
	lidt [rdi]
	ret

idt_sti:
	sti
	ret

idt_cli:
	cli
	ret

	; division error
exception_de: dq de
de:	mov rdi, de_msg
	call kprintln
	jmp die
de_msg:	db "Exception: Division Error", 0

	; debug
exception_db: dq db
db:	mov rdi, db_msg
	call kprintln
	jmp die
db_msg:	db "Exception: Debug", 0

	; breakpoint
exception_bp1: dq bp1
bp1:	mov rdi, bp_msg
	call kprintln
	jmp die
bp_msg: db "Exception: Breakpoint", 0

	; overflow
exception_of: dq of
of:	mov rdi, of_msg
	call kprintln
	jmp die
of_msg:	db "Exception: Overflow", 0

	; bound range
exception_br: dq br
br:	mov rdi, br_msg
	call kprintln
	jmp die
br_msg:	db "Exception: Bound Range", 0

	; invalid opcode
exception_ud: dq ud
ud:	mov rdi, ud_msg
	call kprintln
	jmp die
ud_msg:	db "Exception: Invalid Opcode", 0

	; device not available
exception_nm: dq nm
nm:	mov rdi, nm_msg
	call kprintln
	jmp die
nm_msg:	db "Exception: Device Not Available", 0

	; double fault
exception_df: dq df
df:	mov rdi, df_msg
	call kprintln
	jmp die
df_msg:	db "Exception: Double Fault. Stopping.", 0

	; invalid tss
exception_ts: dq ts
ts:	mov rdi, ts_msg
	call kprintln
	add sp, 8
	jmp die
ts_msg:	db "Exception: Invalid TSS", 0

	; Segment not present
exception_np: dq np
np:
	mov rdi, np_msg
	call kprintln
	add sp, 8
	jmp die
np_msg:	db "Exception: Segment Not Present", 0

	; Stack segment fault
exception_ss1: dq ss1
ss1:	mov rdi, ss_msg
	call kprintln
	add sp, 8
	jmp die
ss_msg:	db "Exception: Stack Segment Fault", 0

	; General protection fault
exception_gp: dq gp
gp:	mov rdi, gp_msg
	call kprintln
	add sp, 8
	jmp die
gp_msg:	db "Exception: General Protection Fault", 0

	; Page Fault
exception_pf: dq pf
pf:	mov rdi, pf_msg
	call kprintln
	add sp, 8
	jmp die
pf_msg:	db "Exception: Page Fault", 0

	; x87 floating-poiunt exception
exception_mf: dq mf
mf:	mov rdi, mf_msg
	call kprintln
	jmp die
mf_msg:	db "Exception: x87 Floating Point Exception", 0

	; Alignment Check
exception_ac: dq ac
ac:	mov rdi, ac_msg
	call kprintln
	add sp, 8
	jmp die
ac_msg:	db "Exception: Alignment Check", 0

	; machine check
exception_mc: dq mc
mc:	mov rdi, mc_msg
	call kprintln
	jmp die
mc_msg:	db "Exception: Machine Check. Stopping.", 0

	; SIMD floating point exception
exception_xm: dq xm
xm:	mov rdi, xm_msg
	call kprintln
	jmp die
xm_msg:	db "Exception: SIMD Floating Point Exception", 0

	; Virtualization Exception
exception_ve: dq ve
ve:	mov rdi, ve_msg
	call kprintln
	jmp die
ve_msg:	db "Exception: Virtualization Exception", 0

	; control protection exception
exception_cp: dq cp
cp:	mov rdi, cp_msg
	call kprintln
	add sp, 8
	jmp die
cp_msg:	db "Exception: Control Protection Exception", 0

	; hypervisor injection exception
exception_hv: dq hv
hv:	mov rdi, hv_msg
	call kprintln
	jmp die
hv_msg:	db "Exception: Hypervisor Injection Exception", 0

	; VmM COMMUNICATION EXCEPTION
exception_vc: dq vc
vc:	mov rdi, vc_msg
	call kprintln
	add sp, 8
	jmp die
vc_msg:	db "Exception: VMM Communication Exception", 0

	; Security Exception
exception_sx: dq sx
sx:	mov rdi, sx_msg
	call kprintln
	add sp, 8
	jmp die
sx_msg:	db "Exception: Security Exception", 0

; Default isr (no error code)
exception_isr: dq isr
isr:    iretq

	; generic IRQ handler
exception_irq: dq irq
irq:
	; ack irq
	push rax
        mov al, 0x20
        out 0x20, al
        out 0xa0, al
	pop rax
	iretq

	; IRQ0 handler (timer)
exception_irq0: dq irq0
irq0:
	; ack irq
	push rax
	mov al, 0x20
	out 0x20, al
	out 0xa0, al
	pop rax
	iretq

        ; IRQ1 handler (keyboard)
exception_irq1: dq irq1
irq1:
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
        iretq
