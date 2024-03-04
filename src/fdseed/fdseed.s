	org 0x7c00
	bits 16

%define IDT_ADDR 0x6000
%define KERNEL_ADDR 0x10000
%define STACK_ADDR 0x6000

	; Canonicalize IP
	jmp 0x0000:start
start:
	; Clear the direction flag
	cld

	; Clear data segment
	xor ax, ax
	mov ds, ax

	mov bp, 0x4000	; Output buffer 0x40000
	xor bx, bx
	mov cx, 1	; Cylinder 0, Sector 1
	xor dh, dh	; Head 0

	; Reset disk
reset: 	mov ah, 0
	int 0x13

	; Load 14 cylinders into memory (CHS) (252k)
load:	mov ax, 0x0201	; Read 1 sector
	mov es, bp	; ES:BX is output buffer
	int 0x13
	jc reset
	add bp, 0x20	; Advance output buffer by 512
	inc cl		; Next sector
	cmp cl, 18	; Have we read the whole cylinder?
	jne load
	mov cl, 1	; Back to sector 1
	xor dh, 1	; Toggle head
	jnz load	; If head is zero, increment cylinder
	inc ch
	cmp ch, 14	; Repeat for 16 cylinders (TODO)
	jne load

	; Turn on A20 gate (fast A20)
a20:	in al, 0x92
	or al, 2
	out 0x92, al

	; Disable cursor
	mov dx, 0x3d4
	mov al, 0x0a
	out dx, al
	inc dx
	mov al, 0x20
	out dx, al

	; Set up long mode paging (identity map first 2 MB)
	mov edi, 0x1000
	mov cr3, edi
	xor eax, eax
	mov ecx, 4096
	rep stosd
	mov edi, cr3
	mov dword [edi], 0x2003
	add edi, 0x1000
	mov dword [edi], 0x3003
	add edi, 0x1000
	mov dword [edi], 0x4003
	add edi, 0x1000
	mov ebx, 3
	mov ecx, 512
page:	mov dword [edi], ebx
	add ebx, 0x1000
	add edi, 8
	loop page

	; Enable PAE
pae:	mov eax, cr4
	or eax, 1 << 5
	mov cr4, eax

	; Switch to long mode
	cli
	mov ecx, 0xc0000080	; LM-bit
	rdmsr
	or eax, 1 << 8
	wrmsr
	mov eax, cr0		; Enable paging and protected mode
	or eax, 1 << 31 | 1 << 0
	mov cr0, eax
	lgdt [gdtr]
	jmp CODE_SEG:lmode

	bits 64

lmode:	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov rsp, STACK_ADDR

	; Create IDT
	mov rdi, IDT_ADDR
	xor rcx, rcx
	dec cl
idt:	mov ax, isr
	stosw
	mov ax, CODE_SEG
	stosw
	mov ax, 0x8e00
	stosw
	xor rax, rax
	stosw
	stosd
	stosd
	loop idt

	; Remap PIC
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

	; Load IDT and enable interrupts
	lidt [idtr]
	sti

	; Unpack kernel
	mov rsi, 0x40200	; first 512 is bootsector
	mov rdi, KERNEL_ADDR
unpack: lodsb
	cmp al, 255
	jnz lit
	lodsw
	xor rcx, rcx
	xor rdx, rdx
	mov cx, ax
	mov dx, ax
	shr dx, 6
	and cx, 63
	jz zero
	dec cx
	jz boot
	inc cx
	push rsi
	mov rsi, rdi
	sub rsi, rdx
	dec rsi
	rep movsb
	pop rsi
	jmp unpack
zero:	mov al, 255
	stosb
	jmp unpack
lit:	stosb
	jmp unpack

	; notice rsi contains pointer to initrd
boot:	mov rdi, rsi
	jmp KERNEL_ADDR

	; Default isr
isr:
	iretq

idtr:
	dw (256 * 16) - 1
	dq IDT_ADDR

gdt:
gdtr: ; null segment also
	dw gdt_end - gdt - 1
	dd gdt
	dw 0

gdt_code:
	dw 0xffff	; limit
	dw 0x0000	; base
	db 0		; base
	db 0x9a		; access byte
	db 10101111b	; flags / limit
	db 0		; base

gdt_data:
	dw 0xffff
	dw 0x0000
	db 0
	db 0x92
	db 11001111b
	db 0
gdt_end:

CODE_SEG equ gdt_code - gdt
DATA_SEG equ gdt_data - gdt

times 510 - ($ - $$) db 0

	dw 0xAA55
