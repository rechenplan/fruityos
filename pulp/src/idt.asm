bits 64

idt_load:
	pop r10
	pop rdi
	push r10
	lidt [rdi]
	ret

idt_sti:
	sti
	ret

idt_cli:
	cli
	ret

idt_populate:
	pop r10
	pop rdi
	push r10
	push rbx
	mov rbx, rdi
	xor rcx, rcx
.default:
	mov rsi, isr
	call .set
	add rcx, 1
	cmp rcx, 256
	jb .default
	xor rcx, rcx
.specific:
	mov rax, rcx
	shl rax, 3
	mov rdx, idt_handlers
	add rax, rdx
	mov rsi, [rax]
	call .set
	add rcx, 1
	cmp rcx, 48
	jb .specific
	mov rcx, 132
	mov rsi, sys_handler
	call .set
	mov ax, 0xee00
	mov [rdx + 4], ax
	pop rbx
	ret
.set:
	mov rdx, rcx
	shl rdx, 4
	add rdx, rbx
	mov rax, rsi
	mov [rdx], ax
	shr rax, 16
	mov [rdx + 6], ax
	shr rax, 16
	mov [rdx + 8], eax
	mov eax, 0x8e010008
	mov [rdx + 2], eax
	xor eax, eax
	mov [rdx + 12], eax
	ret

idt_handlers:
	dq de, db, isr, bp1, of, br, ud, nm
	dq df, isr, ts, np, ss1, gp, pf, isr
	dq mf, ac, mc, xm, ve, cp, isr, isr
	dq isr, isr, isr, isr, hv, vc, sx, isr
	dq irq0, irq1, irq, irq, irq, irq, irq, irq
	dq irq, irq, irq, irq, irq, irq, irq, irq

pic_init:
	mov al, 0x11
	out 0x20, al
	out 0xa0, al
	mov al, 0x20
	out 0x21, al
	mov al, 0x28
	out 0xa1, al
	mov al, 0x04
	out 0x21, al
	mov al, 0x02
	out 0xa1, al
	mov al, 0x05
	out 0x21, al
	mov al, 0x01
	out 0xa1, al
	ret

kb_s2c:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, [rdi + 24]
	cmp rsi, 42
	je .left_down
	cmp rsi, 170
	je .left_up
	cmp rsi, 54
	je .right_down
	cmp rsi, 182
	je .right_up
	cmp rsi, 58
	jb .valid
	jmp .none
.valid:
	mov rdx, rax
	and rdx, 3
	cmp rdx, 0
	jne .shifted
	mov rax, kb_unshifted
	jmp .lookup
.shifted:
	mov rax, kb_shifted
.lookup:
	add rax, rsi
	xor rdx, rdx
	mov dl, [rax]
	mov rax, rdx
	ret
.left_down:
	or rax, 1
	jmp .state
.left_up:
	and rax, -2
	jmp .state
.right_down:
	or rax, 2
	jmp .state
.right_up:
	and rax, -3
.state:
	mov [rdi + 24], rax
.none:
	xor rax, rax
	ret

kb_unshifted:
	db 0, 27, "1234567890-=", 8, 9, "qwertyuiop[]", 10, 0
	db "asdfghjkl;'`", 0, 92, "zxcvbnm,./", 0, 0, 0, 32
kb_shifted:
	db 0, 27, "!@#$%^&*()_+", 8, 9, "QWERTYUIOP{}", 10, 0
	db "ASDFGHJKL:", 34, 126, 0, 124, "ZXCVBNM<>?", 0, 0, 0, 32

x86_mul:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, rdi
	mul rsi
	ret

x86_div:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, rdi
	xor rdx, rdx
	div rsi
	ret

x86_mod:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, rdi
	xor rdx, rdx
	div rsi
	mov rax, rdx
	ret

task_init:
	pop r10
	pop rdx
	pop rsi
	pop rdi
	push r10
	mov r8, rdi
	add r8, 1
	shl r8, 27
	mov r9, rsi
	mov r10, rdx
	mov rax, r8
	mov rcx, 20
	xor rdx, rdx
.zero:
	mov [rax], rdx
	add rax, 8
	sub rcx, 1
	jnz .zero
	mov rax, 0x801000
	mov [r8 + 8], rax
	mov rax, 27
	mov [r8 + 16], rax
	mov rax, 0x8800000
	mov [r8 + 32], rax
	mov rax, 35
	mov [r8 + 40], rax
	mov [r8 + 48], r9
	mov [r8 + 56], r10
	mov rax, 0x900000
	mov [r8 + 248], rax
	ret

task_switch:
	pop r10
	pop rdi
	push r10
	add rdi, 1
	shl rdi, 18
	add rdi, 0x103000
	or rdi, 7
	mov rax, 0x102020
	mov rcx, 64
.map:
	mov [rax], rdi
	add rax, 8
	add rdi, 4096
	sub rcx, 1
	jnz .map
	mov rdi, 0x100000
	push rdi
	call flush_tlb
	ret

task_getBrk:
	pop r10
	pop rdi
	push r10
	add rdi, 1
	shl rdi, 27
	mov rax, [rdi + 248]
	ret

task_setBrk:
	pop r10
	pop rsi
	pop rdi
	push r10
	add rdi, 1
	shl rdi, 27
	mov [rdi + 248], rsi
	ret

list_init:
	pop r10
	pop rdi
	push r10
	xor rax, rax
	mov [rdi], rax
	mov [rdi + 8], rax
	ret

list_getNodeHdrSize:
list_getHdrSize:
	mov rax, 16
	ret

list_setHead:
list_setNext:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi], rsi
	ret

list_setTail:
list_setPrev:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 8], rsi
	ret

list_getHead:
list_getNext:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi]
	ret

list_getTail:
list_getPrev:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 8]
	ret

list_pop:
	mov rax, [rdi]
	test rax, rax
	jz .pop_done
	mov rdx, [rax]
	xor rcx, rcx
	mov [rdx + 8], rcx
	mov [rdi], rdx
.pop_done:
	ret

list_dequeue:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 8]
	test rax, rax
	jz .dequeue_done
	mov rdx, [rax + 8]
	xor rcx, rcx
	mov [rdx], rcx
	mov [rdi + 8], rdx
.dequeue_done:
	ret

list_push:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov rax, [rdi]
	test rax, rax
	jnz .nonempty
	mov [rdi], rsi
	mov [rdi + 8], rsi
	xor rax, rax
	mov [rsi], rax
	mov [rsi + 8], rax
	ret
.nonempty:
	xor rdx, rdx
	mov [rsi + 8], rdx
	mov [rsi], rax
	mov [rax + 8], rsi
	mov [rdi], rsi
	ret

fba_getHdrSize:
	mov rax, 24
	ret

fba_getAvailableBlocks:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 16]
	ret

fba_setAvailableBlocks:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 16], rsi
	ret

fba_getPool:
	pop r10
	pop rdi
	push r10
	mov rax, rdi
	add rax, 24
	ret

fba_getNext:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi - 16]
	add rax, 16
	ret

fba_getPrev:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi - 8]
	add rax, 16
	ret

fba_setNext:
	pop r10
	pop rsi
	pop rdi
	push r10
	sub rdi, 16
	sub rsi, 16
	mov [rdi], rsi
	ret

fba_setPrev:
	pop r10
	pop rsi
	pop rdi
	push r10
	sub rdi, 16
	sub rsi, 16
	mov [rdi + 8], rsi
	ret

heap_getBaseAddr:
heap_addr32:
	mov rax, 0x400000
	ret

heap_size32:
	mov rax, 0x10000
	ret

heap_size256:
	mov rax, 0x40000
	ret

heap_size1024:
	mov rax, 0x380000
	ret

heap_addr256:
	mov rax, 0x410000
	ret

heap_addr1024:
	mov rax, 0x450000
	ret

global_getScr:
	mov rax, [__haruka_global__scr]
	ret

global_getKb:
	mov rax, [__haruka_global__kb]
	ret

global_getRamfs:
	mov rax, [__haruka_global__ramfs]
	ret

global_getCurrentPid:
	mov rax, [__haruka_global__pid]
	ret

global_setCurrentPid:
	pop r10
	pop rdi
	push r10
	mov [__haruka_global__pid], rdi
	ret

scr_getAddress:
	mov rax, 0xb8000
	ret

scr_getSize:
	mov rax, 32
	ret

scr_setCursorColumn:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi], rsi
	ret

scr_getCursorColumn:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi]
	ret

scr_setCursorRow:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 8], rsi
	ret

scr_getCursorRow:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 8]
	ret

scr_setRowCnt:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 16], rsi
	ret

scr_getRowCnt:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 16]
	ret

scr_setColumnCnt:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 24], rsi
	ret

scr_getColumnCnt:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 24]
	ret

kb_getSize:
	mov rax, 32
	ret

kb_getBufferSize:
	mov rax, 256
	ret

kb_getHead:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi]
	ret

kb_getTail:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 8]
	ret

kb_getBuffer:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 16]
	ret

kb_getState:
	pop r10
	pop rdi
	push r10
	mov rax, [rdi + 24]
	ret

kb_setHead:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi], rsi
	ret

kb_setTail:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 8], rsi
	ret

kb_setBuffer:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 16], rsi
	ret

kb_setState:
	pop r10
	pop rsi
	pop rdi
	push r10
	mov [rdi + 24], rsi
	ret

	; division error
exception_de: dq de
de:	mov rdi, de_msg
	push rdi
	call kputs
	jmp die
de_msg:	db "Exception: Division Error", 0

	; debug
exception_db: dq db
db:	mov rdi, db_msg
	push rdi
	call kputs
	jmp die
db_msg:	db "Exception: Debug", 0

	; breakpoint
exception_bp1: dq bp1
bp1:	mov rdi, bp_msg
	push rdi
	call kputs
	jmp die
bp_msg: db "Exception: Breakpoint", 0

	; overflow
exception_of: dq of
of:	mov rdi, of_msg
	push rdi
	call kputs
	jmp die
of_msg:	db "Exception: Overflow", 0

	; bound range
exception_br: dq br
br:	mov rdi, br_msg
	push rdi
	call kputs
	jmp die
br_msg:	db "Exception: Bound Range", 0

	; invalid opcode
exception_ud: dq ud
ud:	mov rdi, ud_msg
	push rdi
	call kputs
	jmp die
ud_msg:	db "Exception: Invalid Opcode", 0

	; device not available
exception_nm: dq nm
nm:	mov rdi, nm_msg
	push rdi
	call kputs
	jmp die
nm_msg:	db "Exception: Device Not Available", 0

	; double fault
exception_df: dq df
df:	mov rdi, df_msg
	push rdi
	call kputs
	jmp die
df_msg:	db "Exception: Double Fault. Stopping.", 0

	; invalid tss
exception_ts: dq ts
ts:	mov rdi, ts_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
ts_msg:	db "Exception: Invalid TSS ", 0

	; Segment not present
exception_np: dq np
np:
	mov rdi, np_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
np_msg:	db "Exception: Segment Not Present ", 0

	; Stack segment fault
exception_ss1: dq ss1
ss1:	mov rdi, ss_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
ss_msg:	db "Exception: Stack Segment Fault ", 0

	; General protection fault
exception_gp: dq gp
gp:	mov rdi, gp_msg
	push rdi
	call kputs
	pop rdi
	push rdi
	call kputn
	jmp die
gp_msg:	db "Exception: General Protection Fault ", 0

	; Page Fault
exception_pf: dq pf
pf:	mov rdi, pf_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
pf_msg:	db "Exception: Page Fault ", 0

	; x87 floating-poiunt exception
exception_mf: dq mf
mf:	mov rdi, mf_msg
	push rdi
	call kputs
	jmp die
mf_msg:	db "Exception: x87 Floating Point Exception", 0

	; Alignment Check
exception_ac: dq ac
ac:	mov rdi, ac_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
ac_msg:	db "Exception: Alignment Check ", 0

	; machine check
exception_mc: dq mc
mc:	mov rdi, mc_msg
	push rdi
	call kputs
	jmp die
mc_msg:	db "Exception: Machine Check. Stopping.", 0

	; SIMD floating point exception
exception_xm: dq xm
xm:	mov rdi, xm_msg
	push rdi
	call kputs
	jmp die
xm_msg:	db "Exception: SIMD Floating Point Exception", 0

	; Virtualization Exception
exception_ve: dq ve
ve:	mov rdi, ve_msg
	push rdi
	call kputs
	jmp die
ve_msg:	db "Exception: Virtualization Exception", 0

	; control protection exception
exception_cp: dq cp
cp:	mov rdi, cp_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
cp_msg:	db "Exception: Control Protection Exception ", 0

	; hypervisor injection exception
exception_hv: dq hv
hv:	mov rdi, hv_msg
	push rdi
	call kputs
	jmp die
hv_msg:	db "Exception: Hypervisor Injection Exception", 0

	; VmM COMMUNICATION EXCEPTION
exception_vc: dq vc
vc:	mov rdi, vc_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
vc_msg:	db "Exception: VMM Communication Exception ", 0

	; Security Exception
exception_sx: dq sx
sx:	mov rdi, sx_msg
	push rdi
	call kputs
        pop rdi
        push rdi
        call kputn
	jmp die
sx_msg:	db "Exception: Security Exception ", 0

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
        push rax
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
