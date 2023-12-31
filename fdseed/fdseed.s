	org 0x7c00
	bits 16

CODE_SEG equ gdt_code - gdt
DATA_SEG equ gdt_data - gdt

start:
	; Display loading message
	xor ax, ax
	mov ds, ax
	mov si, boot_m
	call puts

	; Load OS from disk (CHS)
	mov ax, 0x027f	; Read 127 sectors (64k - 512 byte boot sector)
	mov cx, 2	; Cylinder 0, Sector 2
	mov dh, 0	; Head 0 (note dl already contains id of boot disk)
	mov bx, 0x7e0	; ES:BX is output buffer (0x7e00)
	mov es, bx
	xor bx, bx
	int 0x13

	; Turn on A20 gate (fast A20)
	in al, 0x92
	or al, 2
	out 0x92, al

	; Disable interrupts
	cli

	; Switch to protected mode
	lgdt [gdtr]
	mov eax, cr0
	or al, 1
	mov cr0, eax
	jmp CODE_SEG:unpack

	bits 32

unpack: mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov al, '$'
	mov [0xb8000], al
	mov al, 7
	mov [0xb8001], al

	; Unpack kernel

spin:	jmp spin

	; Switch to long mode

	; Put string subroutine
	bits 16

puts:	mov ah, 0x0e
	lodsb
	cmp al, 0
	je puts.x
	int 0x10
	jmp puts
puts.x:	ret

boot_m: db "Booting FruityOS...", 13, 10, 0

gdtr:
	dw gdt_end - gdt - 1
	dd gdt

gdt:
gdt_null:
	dq 0

gdt_code:
	dw 0xffff	; limit
	dw 0x0000	; base
	db 0		; base
	db 0x9a		; access byte
	db 11001111b	; flags / limit
	db 0		; base

gdt_data:
	dw 0xffff
	dw 0x0000
	db 0
	db 0x92
	db 11001111b
	db 0

gdt_end:

times 510 - ($ - $$) db 0

	dw 0xAA55


; Normally we won't do this. We'll just concatenate the kernel.
times 65536 - 512 db 0x80
