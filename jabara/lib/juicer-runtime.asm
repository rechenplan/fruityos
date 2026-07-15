; Juicer memory decoders for boot and runtime consumers.

%ifndef JUICER_LONG_ONLY
bits 16
; DS:SI = input, ES:DI = output.
juicer_decode16:
	push bx
.juicer16_flags:
	db 172 ; lodsb
	xor bx, bx
	mov bl, al
	or bx, 256
.juicer16_next:
	shr bx, 1
	jz .juicer16_flags
	jc .juicer16_literal
	db 173 ; lodsw
	test ax, ax
	jz .juicer16_done
	mov cx, ax
	and cx, 15
	mov dx, ax
	shr dx, 4
	add cx, 3
	push si
	mov si, di
	sub si, dx
	db 243, 164 ; rep movsb
	pop si
	jmp .juicer16_advance
.juicer16_literal:
	db 172 ; lodsb
	db 170 ; stosb
.juicer16_advance:
	jmp .juicer16_next
.juicer16_done:
	pop bx
	ret
%endif

bits 64
; Freestanding callers pass RSI = input and RDI = output.
; Jabara callers push output followed by input.
; Returns the decoded size in RAX outside freestanding builds.
juicer_decode64:
	%ifndef JUICER_FREESTANDING
	pop r10
	pop rsi
	pop rdi
	push r10
	push rdi
	push rbx
	%endif
.juicer64_flags:
	db 172 ; lodsb
	mov ebx, 256
	mov bl, al
.juicer64_next:
	shr ebx, 1
	jz .juicer64_flags
	jc .juicer64_literal
	xor eax, eax
	db 102, 173 ; lodsw
	test eax, eax
	jz .juicer64_done
	mov ecx, eax
	and ecx, 15
	mov edx, eax
	shr edx, 4
	add ecx, 3
	push rsi
	mov rsi, rdi
	sub rsi, rdx
	db 243, 164 ; rep movsb
	pop rsi
	jmp .juicer64_advance
.juicer64_literal:
	db 172 ; lodsb
	db 170 ; stosb
.juicer64_advance:
	jmp .juicer64_next
.juicer64_done:
	%ifndef JUICER_FREESTANDING
	pop rbx
	pop rax
	neg rax
	add rax, rdi
	%endif
	ret
