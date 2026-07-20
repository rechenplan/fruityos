; Canonical Juicer decoder for this platform.
; Define JUICER_OLD only for legacy 12/4 bootstrap streams.

%ifdef PITH_juicer_decode64
bits 64
; Freestanding callers pass RSI = input and RDI = output.
; Haruka/Jabara callers push output followed by input.
juicer_decode64:
	%ifndef JUICER_FREESTANDING
	pop r10
	pop rsi
	pop rdi
	push r10
	push rdi
	push rbx
	%endif
	mov r9, rdi
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
	%ifdef JUICER_OLD
	and ecx, 15
	%else
	and ecx, 31
	%endif
	mov edx, eax
	%ifdef JUICER_OLD
	shr edx, 4
	%else
	shr edx, 5
	%endif
	add ecx, 3
	mov r8, rdi
	sub r8, r9
	cmp r8, rdx
	jb .juicer64_dict_match
	push rsi
	mov rsi, rdi
	sub rsi, rdx
	db 243, 164 ; rep movsb
	pop rsi
	jmp .juicer64_advance
.juicer64_dict_match:
	push rsi
	lea rsi, [rel juicer64_dict_end]
	add rsi, r8
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
juicer64_dict:
	db 72,141,5,12,0,0,0,72,137,5,58,5,0,0,233,50
	db 1,0,0,102,114,117,105,116,121,111,115,45,120,56,54,95
	db 54,52,0,65,90,65,91,73,131,195,7,73,131,227,248,77
	db 137,216,73,131,195,16,76,139,77,232,76,137,202,76,41,218
	db 72,137,230,72,137,231,76,41,223,76,57,206,15,132,16,0
	db 0,0,72,139,6,72,137,7,72,131,198,8,72,131,199,8
	db 235,231,72,137,85,232,72,137,42,76,137,66,8,72,141,66
	db 16,76,41,220,65,82,195,65,90,65,91,77,139,75,248,73
	db 131,193,16,72,139,85,240,72,139,74,232,73,137,224,76,137
	db 198,76,137,199,76,41,207,72,57,206,15,132,16,0,0,0
	db 72,139,6,72,137,7,72,131,198,8,72,131,199,8,235,231
	db 76,41,201,72,137,74,232,72,137,215,74,141,20,9,76,137
	db 198,76,41,206,72,57,206,15,132,33,0,0,0,72,139,6
	db 76,57,192,15,130,15,0,0,0,72,57,194,15,134,6,0
	db 0,0,76,41,200,72,137,6,72,131,198,8,235,214,77,57
	db 195,15,130,12,0,0,0,76,57,218,15,134,3,0,0,0
	db 77,41,203,76,41,205,76,137,196,76,41,204,72,137,57,73
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,65,90,69,15,182,26,73,255,194,72
	db 133,192,117,6,77,1,211,65,255,227,65,255,226,65,90,69
	db 15,183,26,73,131,194,2,77,1,243,65,82,65,255,227,72
	db 133,192,15,149,192,15,182,192,195,72,133,219,15,149,195,15
	db 182,219,195,200,32,0,0,72,137,109,240,72,137,101,232,69
	db 49,192,76,137,69,224,72,139,69,16,15,182,0,72,137,69
	db 224,65,255,214,24,72,139,69,224,80,232,233
juicer64_dict_end:
%endif
