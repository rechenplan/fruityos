	org 0x7c00
	bits 16

%define KERNEL_ADDR 0x10000
%define STACK_ADDR 0x40000

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

	; Load 19 cylinders into memory (CHS) (342 KiB)
load:	mov ax, 0x0201	; Read 1 sector
	mov es, bp	; ES:BX is output buffer
	int 0x13
	jc reset
	add bp, 0x20	; Advance output buffer by 512
	inc cl		; Next sector
	cmp cl, 19	; Have we read the whole cylinder?
	jne load
	mov cl, 1	; Back to sector 1
	xor dh, 1	; Toggle head
	jnz load	; If head is zero, increment cylinder
	inc ch
	cmp ch, 19	; Stop below conventional-memory firmware data.
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
	mov es, ax
	mov ecx, 0x6000 / 4
	rep stosd

	; 6 MB identity mapped

	mov word [0x1000], 0x2003
	mov word [0x2000], 0x3003

	mov word [0x3000], 0x4003
	mov word [0x3008], 0x5003
	mov word [0x3010], 0x6003

	mov ebx, 3
	mov ecx, 512 * 3
	mov edi, 0x4000
page:	mov dword [edi], ebx	; [0x4000] = 0x0003, [0x4008] = 0x1003, ..., [0x4200] = 0x2000003
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

	; Find /pulp.sys in the initrd Jar after the boot sector.
	mov rsi, 0x40200
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

%include "../../../lib/fruityos-x86_64/juicer.asm"

boot:	mov rsi, r12
	jmp KERNEL_ADDR + 0x100

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
