	org 0x7c00

start:	mov ax, 0x4141
	mov dx, 0xb800
	mov es, dx
	xor di, di
	stosw
spin:	jmp spin

times 510 - ($ - $$) db 0

	dw 0xAA55

