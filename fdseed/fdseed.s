	org 0x7c00

start:
	xor ax, ax
	mov ds, ax
	mov si, msg
	call puts

	

spin:	jmp spin

puts:	mov ah, 0x0e
	lodsb
	cmp al, 0
	je puts.x
	int 0x10
	jmp puts
puts.x:	ret

msg:	db "Starting FruityOS...", 13, 10, 0

times 510 - ($ - $$) db 0

	dw 0xAA55

