	org 0x7c00
	bits 16

%define KERNEL_ADDR 0x10000
%define STACK_ADDR 0x40000
%define LOAD_ADDR 0x40000
%define PAYLOAD_ADDR 0x300000
%define IMAGE_BLOCK_COUNT 2048
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

        ; Copy the boot sector to its working address so the temporary GDT is
        ; still available after firmware services are left behind.
load:
        mov ah, 42h
        mov si, dap
        int 0x13
        jc load

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
	mov ecx, 0x6000 / 4
	rep stosd

	mov ax, 0x2003
        mov word [0x1000], ax
	add ah, 0x10
        mov word [0x2000], ax
	add ah, 0x10
        mov word [0x3000], ax
	add ah, 0x10
        mov word [0x3008], ax

        mov eax, 3
	mov cx, 512 * 2
        mov di, 0x4000
pt:     stosd
	add di, 4
        add eax, 0x1000
        loop pt

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

	; The BIOS transfer is limited by conventional memory. Fetch the complete
	; padded payload through the primary ATA controller into high memory.
	mov r8d, 1
	mov rdi, PAYLOAD_ADDR
	mov ebp, IMAGE_BLOCK_COUNT - 1
ata_read:
	mov eax, r8d
	shr eax, 24
	and al, 0x0f
	or al, 0xe0
	mov dx, 0x1f6
	out dx, al
	mov dx, 0x1f2
	mov al, 1
	out dx, al
	inc dx
	mov eax, r8d
	out dx, al
	inc dx
	shr eax, 8
	out dx, al
	inc dx
	shr eax, 8
	out dx, al
	inc dx
	inc dx
	mov al, 0x20
	out dx, al
ata_wait:
	in al, dx
	test al, 0x80
	jnz ata_wait
	test al, 0x08
	jz ata_wait
	mov dx, 0x1f0
	mov ecx, 256
	rep insw
	inc r8d
	dec ebp
	jnz ata_read

	; Find /pulp.sys in the initrd Jar.
	mov rsi, PAYLOAD_ADDR
	mov r12, rsi
	mov rdx, 0x7379732e706c7570
find_pulp:
	cmp byte [rsi], 0
	je find_pulp
	cmp [rsi + 2], rdx
	je pulp_found
skip_name:
	lodsb
	test al, al
	jnz skip_name
	mov rax, [rsi]
	lea rsi, [rsi + rax + 8]
	jmp find_pulp
pulp_found:
	add rsi, 19

	; Unpack kernel
	mov rdi, KERNEL_ADDR
	call juicer_decode64
	jmp boot

%include "juicer-runtime.asm"

	; Pass the Jar start, not the kernel entry, to Pulp.
boot:	mov rsi, r12
	jmp KERNEL_ADDR + 0x100


align 4
dap:
        db 16                   ; size of packet
        db 0                    ; reserved
        dw 1                    ; number of blocks to transfer
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
dd IMAGE_BLOCK_COUNT	; lba block count

times 510 - ($ - $$) db 0
	dw 0xAA55
