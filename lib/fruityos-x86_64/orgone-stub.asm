bits 64
org 0x801000

; Relocate before expansion overwrites the loaded FAP image.
_start:
	mov [rel saved_rdi], rdi
	mov [rel saved_rsi], rsi
	lea rbx, [rel _start]
	mov rsi, rbx
	mov rdi, 0x8f0000
	mov rcx, stub_end - _start
	db 243,164 ; rep movsb
	mov rax, 0x8f0000 + orgone_run - _start
	db 255,224 ; jmp rax

orgone_run:
	; Preserve the encoded stream away from its expansion destination.
	mov rcx, stub_end - _start
	mov rsi, rbx
	add rsi, rcx
	mov rcx, [rsi]
	add rsi, 8
	mov rdi, 0x900000
	db 243,164 ; rep movsb

	; Read the immutable dictionary incrementally. The file size is not a
	; read-buffer limit: keep requesting chunks until EOF.
	lea rdi, [rel dict_path]
	xor rsi, rsi
	xor rax, rax
	int 132
	mov r15, rax
	mov r14, 0xa00000
	mov rsi, r14
.read_dictionary:
	mov rdi, r15
	mov rdx, 4096
	mov rax, 3
	int 132
	test rax, rax
	jle .dictionary_ready
	add rsi, rax
	jmp .read_dictionary
.dictionary_ready:
	mov rdi, r15
	mov rax, 2
	int 132
	mov r14, 0xa00000

	mov rsi, 0x900000
	mov rdi, 0x801000
	call decode
	mov rdi, [rel saved_rdi]
	mov rsi, [rel saved_rsi]
	xor rbx, rbx
	mov rax, 0x801000
	db 255,224 ; jmp rax

; Productions are arbitrary-length streams terminated by 128,253.
; 128,254 is literal 128. References 0..252 are direct; 128,255 is
; followed by an unsigned base-128 command number minus 253.
decode:
.next:
	db 172 ; lodsb
	db 60,128 ; cmp al, 128
	je .escape
.literal:
	db 170 ; stosb
	jmp .next
.escape:
	db 172 ; lodsb
	db 60,253 ; cmp al, 253
	je .done
	db 60,254 ; cmp al, 254
	je .literal_128
	db 60,255 ; cmp al, 255
	je .wide_reference
	movzx rdx, al
	jmp .follow
.literal_128:
	mov al, 128
	db 170 ; stosb
	jmp .next
.wide_reference:
	xor rdx, rdx
	xor rcx, rcx
.wide_byte:
	db 172 ; lodsb
	movzx r8, al
	and r8, 127
	db 73,211,224 ; shl r8, cl
	add rdx, r8
	db 168,128 ; test al, 128
	jz .wide_ready
	add rcx, 7
	jmp .wide_byte
.wide_ready:
	add rdx, 253
.follow:
	shl rdx, 5
	push rsi
	lea rsi, [r14 + rdx]
	call decode
	pop rsi
	jmp .next
.done:
	ret

saved_rdi: dq 0
saved_rsi: dq 0
dict_path: db "/lib/orgone.dct", 0
stub_end:
