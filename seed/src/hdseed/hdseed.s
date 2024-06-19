	org 0x7c00
	bits 16

%define KERNEL_ADDR 0x10000
%define STACK_ADDR 0x40000
%define LOAD_ADDR 0x40000
%define BLOCK_COUNT 127
%define GDT_ADDR (gdt - 0x7c00) + LOAD_ADDR

	; Canonicalize IP
	jmp 0x0000:start
start:
	cld
	cli

	; Setup
        xor ax, ax
        mov ds, ax
        mov es, ax

        mov bx, 0x1000
        mov ss, bx
        mov sp, ax
	push 0xb800
	pop gs

        ; Read 256 sectors (128k) from begining of disk to memory

	mov bx, LOAD_ADDR >> 4
	mov bp, 0
	mov cx, 4
load:
	mov word [dap + 0], 16
	mov word [dap + 2], 64
	mov word [dap + 4], 0
	mov word [dap + 6], bx ; segment
	mov word [dap + 8], bp ; starting block

        mov ah, 42h
        mov si, dap
        int 0x13
        jc load

	add bx, 0x0800
	add bp, 64
	loop load

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

	; Set up long mode paging
	mov edi, 0x1000
	mov cr3, edi
	xor eax, eax
	mov ecx, 0x4000 / 4
	rep stosd

	mov ax, 0x2003
        mov word [0x1000], ax
	add ah, 0x10
        mov word [0x2000], ax
	add ah, 0x10
        mov word [0x3000], ax
	add ah, 0x10

        mov eax, 3
        mov cx, 512
        mov di, 0x4000
page:   stosd
	add di, 4
        add eax, 0x1000
        loop page

	; Enable PAE
pae:	mov eax, cr4
	or eax, 1 << 5
	mov cr4, eax

	lgdt [gdtr]

	; Switch to long mode
	mov ecx, 0xc0000080	; LM-bit
	rdmsr
	or eax, 1 << 8
	wrmsr
	mov eax, cr0		; Enable paging and protected mode
	or eax, 1 << 31 | 1 << 0
	mov cr0, eax

	jmp CODE_SEG:lmode

	bits 64

lmode:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov rsp, STACK_ADDR

	; Initialize PIC
	mov al, 0x11
	out 0x20, al
	out 0xa0, al

	; Map IRQ0 - IRQ7 to int 0x20 - int 0x27
	; Map IRQ8 - IRQ16 to int 0x28 - int 0x30
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
	mov rdi, rsi
boot:	jmp KERNEL_ADDR + 0x100

align 4
dap:
        db 16                   ; size of packet
        db 0                    ; reserved
        dw BLOCK_COUNT          ; number of blocks to transfer
        dw 0                    ; buffer ptr
	dw LOAD_ADDR >> 4	; buffer seg
        dq 0                    ; block number

gdt:
gdtr: ; null segment also
	dw gdt_end - gdt - 1
	dd GDT_ADDR
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

times 0x1BE - ($ - $$) db 0

; Partition table
db 0x80		; bootable
db 0		; starting head (0)
dw 0<<6 | 1	; starting sector (1), starting cylinder (0)
db 0x7F		; System ID (filesystem type)
db 255		; ending head (255)
dw 1023<<6 | 63	; ending sector (63) ending cylinder (1023)
dd 0		; lba start
dd BLOCK_COUNT	; lba block count

times 510 - ($ - $$) db 0
	dw 0xAA55
