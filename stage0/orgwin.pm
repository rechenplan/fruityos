; Seed Orgasm for Windows PE32+
; Petit emits the bytes exactly as written below.
; Each comment describes the adjacent instruction, string, header field, or table.

; ---- DOS header ----
#4D5A0000000000000000000000000000# ; DOS header
#00000000000000000000000000000000# ; DOS header
#00000000000000000000000000000000# ; DOS header
#00000000000000000000000080000000# ; DOS header
#00000000000000000000000000000000# ; DOS header
#00000000000000000000000000000000# ; DOS header
#00000000000000000000000000000000# ; DOS header
#00000000000000000000000000000000# ; DOS header

; ---- PE32+ headers ----
#50450000648601000000000000000000# ; PE32+ headers
#00000000F00022000B020000005E0000# ; PE32+ headers
#00000000000000000F02000000020000# ; PE32+ headers
#00000040010000000002000000020000# ; PE32+ headers
#06000000000000000600000000000000# ; PE32+ headers
#00600000000200000000000003000000# ; PE32+ headers
#00001000000000000010000000000000# ; PE32+ headers
#00001000000000000010000000000000# ; PE32+ headers
#00000000100000000000000000000000# ; PE32+ headers
#205E0000280000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#0000000000000000985E000050000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000002E74657874000000# ; PE32+ headers
#805D000000020000005E000000020000# ; PE32+ headers
#000000000000000000000000600000E0# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers
#00000000000000000000000000000000# ; PE32+ headers

'windows-x86_64' #00# ; text
#488D05EAFFFFFF# ; lea rax, [rip - 0x16]
#488905F3570000# ; mov qword ptr [rip + 0x57f3], rax
#E8FA580000# ; call 0x140005b1c
#50# ; push rax
#52# ; push rdx
#E8FB000000# ; call 0x140000324
#50# ; push rax
#E8C55B0000# ; call 0x140005df4
#C8000000# ; enter 0, 0
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F840E000000# ; je 0x140000251
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBE2# ; jmp 0x140000233
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#C9# ; leave
#C20800# ; ret 8
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A00# ; push 0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A00# ; push 0
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8D96000000# ; jge 0x14000031c
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#E8F8590000# ; call 0x140005c88
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8F37000000# ; jg 0x1400002d9
#E90F000000# ; jmp 0x1400002b6
'error opening ' #00# ; text
#488D05EAFFFFFF# ; lea rax, [rip - 0x16]
#50# ; push rax
#E8750A0000# ; call 0x140000d38
#FF7528# ; push qword ptr [rbp + 0x28]
#E86D0A0000# ; call 0x140000d38
#6A0A# ; push 0xa
#E8185B0000# ; call 0x140005dea
#6A01# ; push 1
#E81B5B0000# ; call 0x140005df4
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7510# ; push qword ptr [rbp + 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E851490000# ; call 0x140004c3b
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#E822590000# ; call 0x140005c21
#FF7528# ; push qword ptr [rbp + 0x28]
#E828FFFFFF# ; call 0x14000022f
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#E959FFFFFF# ; jmp 0x140000275
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#C9# ; leave
#C22000# ; ret 0x20
#C8400000# ; enter 0x40, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F803# ; cmp rax, 3
#0F8D4F000000# ; jge 0x1400003a3
#E92F000000# ; jmp 0x140000388
'usage: orgasm input.asm [input.asm ...] output' #00# ; text
#488D05CAFFFFFF# ; lea rax, [rip - 0x36]
#50# ; push rax
#E8A3090000# ; call 0x140000d38
#6A0A# ; push 0xa
#E84E5A0000# ; call 0x140005dea
#6A01# ; push 1
#E8515A0000# ; call 0x140005df4
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#E84B580000# ; call 0x140005bfa
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4881C000000800# ; add rax, 0x80000
#50# ; push rax
#E836580000# ; call 0x140005bfa
#6A00# ; push 0
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4881F800200000# ; cmp rax, 0x2000
#0F8D2A000000# ; jge 0x140000406
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48C1E006# ; shl rax, 6
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBC5# ; jmp 0x1400003cb
#FF7510# ; push qword ptr [rbp + 0x10]
#E821FEFFFF# ; call 0x14000022f
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#6A00# ; push 0
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8D1A000000# ; jge 0x140000452
#FF75E0# ; push qword ptr [rbp - 0x20]
#E8EFFDFFFF# ; call 0x14000022f
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBCF# ; jmp 0x140000421
#FF75E0# ; push qword ptr [rbp - 0x20]
#E8B1580000# ; call 0x140005d0b
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F800# ; cmp rax, 0
#0F8F36000000# ; jg 0x1400004a2
#E916000000# ; jmp 0x140000487
'error creating output' #00# ; text
#488D05E3FFFFFF# ; lea rax, [rip - 0x1d]
#50# ; push rax
#E8A4080000# ; call 0x140000d38
#6A0A# ; push 0xa
#E84F590000# ; call 0x140005dea
#6A01# ; push 1
#E852590000# ; call 0x140005df4
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E8A0FDFFFF# ; call 0x14000025d
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E881FDFFFF# ; call 0x14000025d
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF75D0# ; push qword ptr [rbp - 0x30]
#488B45C8# ; mov rax, qword ptr [rbp - 0x38]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8D29000000# ; jge 0x14000051a
#488B45C8# ; mov rax, qword ptr [rbp - 0x38]
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E849FDFFFF# ; call 0x14000025d
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#EBC6# ; jmp 0x1400004e0
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75F8# ; push qword ptr [rbp - 8]
#E82CFDFFFF# ; call 0x14000025d
#FF75D8# ; push qword ptr [rbp - 0x28]
#E8E8560000# ; call 0x140005c21
#31C0# ; xor eax, eax
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#E969010000# ; jmp 0x1400006b1
'ret$syscall$push$pop$mul$div$neg$not$add$sub$and$xor$or$test$cmp$shl$shr$sete$setne$setz$setnz$setg$setl$setge$setle$mov$lea$call$jmp$jnz$jz$db$extern$global$bits$qword$rax$rcx$rdx$rbx$rsp$rbp$rsi$rdi$r8$r9$r10$cl$dl$,$[$]$-$+$org$al$int$jne$jbe$je$jb$jc$align$dq$dd$dw$imul$movzx$byte$dword$word$hlt$cli$sti$iretq$retfq$lgdt$lidt$ltr$in$out$equ$jge$jg$jle$jl$' #00# ; text
#488D0590FEFFFF# ; lea rax, [rip - 0x170]
#C9# ; leave
#C3# ; ret
#C8000000# ; enter 0, 0
#E902000000# ; jmp 0x1400006c5
#3900# ; cmp dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x1400006e7
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#C9# ; leave
#C20800# ; ret 8
#C8000000# ; enter 0, 0
#E902000000# ; jmp 0x140000714
#2E00488D# ; add byte ptr cs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140000736
#5F# ; pop rdi
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140000758
#7A00# ; jp 0x140000758
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x14000077a
#6100488D05F7FFFFFF0FB60050488B45# ; data
#105F31# ; adc byte ptr [rdi + 0x31], bl
#D24839# ; ror byte ptr [rax + 0x39], cl
#F8# ; clc
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E902000000# ; jmp 0x1400007a0
#5A# ; pop rdx
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x1400007c2
#4100488D# ; add byte ptr [r8 - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#C9# ; leave
#C20800# ; ret 8
#C8100000# ; enter 0x10, 0
#E90B000000# ; jmp 0x140000804
',[]-+*&|()' #00# ; text
#488D05EEFFFFFF# ; lea rax, [rip - 0x12]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F842B000000# ; je 0x14000084a
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x14000083c
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBC5# ; jmp 0x14000080f
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E8D3FCFFFF# ; call 0x14000053f
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F8406010000# ; je 0x140000986
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841A000000# ; je 0x1400008e8
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883C001# ; add rax, 1
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883C001# ; add rax, 1
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#EBA8# ; jmp 0x140000890
#E902000000# ; jmp 0x1400008ef
#2400# ; and al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8408000000# ; je 0x140000938
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x14000093f
#2400# ; and al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F840E000000# ; je 0x140000969
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBCF# ; jmp 0x140000938
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E9EAFEFFFF# ; jmp 0x140000870
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C20800# ; ret 8
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#408807# ; mov byte ptr [rdi], al
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#4885C0# ; test rax, rax
#0F8473030000# ; je 0x140000d31
#E902000000# ; jmp 0x1400009c5
#2500488D05# ; and eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45F85F4839F80F85# ; data
#070000006A0058C9C21000E902000000# ; data
#3B00# ; cmp eax, dword ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F856E000000# ; jne 0x140000a73
#6A00# ; push 0
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A0A# ; push 0xa
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8420000000# ; je 0x140000a60
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBAC# ; jmp 0x140000a0c
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E801# ; sub rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF75F8# ; push qword ptr [rbp - 8]
#E88EFCFFFF# ; call 0x140000709
#4885C0# ; test rax, rax
#0F84B3000000# ; je 0x140000b37
#E902000000# ; jmp 0x140000a8b
#5F# ; pop rdi
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140000aad
#3A00# ; cmp al, byte ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E8EAFBFFFF# ; call 0x1400006ba
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E830FCFFFF# ; call 0x140000709
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8435000000# ; je 0x140000b23
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E961FFFFFF# ; jmp 0x140000a84
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F822# ; cmp rax, 0x22
#0F858A000000# ; jne 0x140000bcf
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#4883F822# ; cmp rax, 0x22
#0F8427000000# ; je 0x140000ba6
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#EBC4# ; jmp 0x140000b6a
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#C9# ; leave
#C21000# ; ret 0x10
#FF75F8# ; push qword ptr [rbp - 8]
#E8E3FAFFFF# ; call 0x1400006ba
#4885C0# ; test rax, rax
#0F8464000000# ; je 0x140000c44
#FF75F8# ; push qword ptr [rbp - 8]
#E821FBFFFF# ; call 0x140000709
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E8C9FAFFFF# ; call 0x1400006ba
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8432000000# ; je 0x140000c30
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBB0# ; jmp 0x140000be0
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#6A0A# ; push 0xa
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E890FBFFFF# ; call 0x1400007f0
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8429000000# ; je 0x140000c96
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#C9# ; leave
#C21000# ; ret 0x10
#E902000000# ; jmp 0x140000c9d
#3E00488D# ; add byte ptr ds:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140000cbf
#3C00# ; cmp al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F843A000000# ; je 0x140000d20
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C002# ; add rax, 2
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C002# ; add rax, 2
#C9# ; leave
#C21000# ; ret 0x10
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#E979FCFFFF# ; jmp 0x1400009aa
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#4885C0# ; test rax, rax
#0F8416000000# ; je 0x140000d6c
#FF75F8# ; push qword ptr [rbp - 8]
#E88C500000# ; call 0x140005dea
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBD6# ; jmp 0x140000d42
#31C0# ; xor eax, eax
#C9# ; leave
#C20800# ; ret 8
#C8000000# ; enter 0, 0
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8532000000# ; jne 0x140000dc1
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F800# ; cmp rax, 0
#0F8507000000# ; jne 0x140000da7
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBB5# ; jmp 0x140000d76
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841A000000# ; je 0x140000e24
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBA8# ; jmp 0x140000dcc
#E902000000# ; jmp 0x140000e2b
#2400# ; and al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#C9# ; leave
#C21000# ; ret 0x10
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E905010000# ; jmp 0x140000f7f
'rax$eax$ax$al$rcx$ecx$cx$cl$rdx$edx$dx$dl$rbx$ebx$bx$bl$rsp$esp$sp$spl$rbp$ebp$bp$bpl$rsi$esi$si$sil$rdi$edi$di$dil$r8$r8d$r8w$r8b$r9$r9d$r9w$r9b$r10$r10d$r10w$r10b$r11$r11d$r11w$r11b$r12$r12d$r12w$r12b$r13$r13d$r13w$r13b$r14$r14d$r14w$r14b$r15$r15d$r15w$r15b$' #00# ; text
#488D05F4FEFFFF# ; lea rax, [rip - 0x10c]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F846B000000# ; je 0x140001005
#FF7510# ; push qword ptr [rbp + 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E823FEFFFF# ; call 0x140000dc8
#4885C0# ; test rax, rax
#0F840C000000# ; je 0x140000fba
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48C1E802# ; shr rax, 2
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x140000fc1
#2400# ; and al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F840E000000# ; je 0x140000feb
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBCF# ; jmp 0x140000fba
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EB85# ; jmp 0x140000f8a
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C20800# ; ret 8
#C8100000# ; enter 0x10, 0
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F840E000000# ; je 0x14000103d
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBDE# ; jmp 0x14000101b
#E902000000# ; jmp 0x140001044
#6200488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140001067
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x14000106e
#7700# ; ja 0x14000106e
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140001091
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x140001098
#6400488D# ; add byte ptr fs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x1400010bb
#6A04# ; push 4
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x1400010c2
#6500488D# ; add byte ptr gs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x1400010e5
#6A04# ; push 4
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x1400010ec
#6C# ; insb byte ptr [rdi], dx
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x140001136
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x14000113d
#6900488D05F7# ; imul eax, dword ptr [rax], 0xf7058d48
#FFFFFF0FB60050488B45F80FB6005F31# ; data
#D24839# ; ror byte ptr [rax + 0x39], cl
#F8# ; clc
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140001162
#7000# ; jo 0x140001162
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140001187
#7800# ; js 0x140001187
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x1400011d9
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#6A08# ; push 8
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#C8000000# ; enter 0, 0
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C002# ; add rax, 2
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140001206
#7300# ; jae 0x140001206
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F840A000000# ; je 0x14000123e
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x140001245
#6500488D# ; add byte ptr gs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140001268
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x14000126f
#7300# ; jae 0x14000126f
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140001292
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x140001299
#6400488D# ; add byte ptr fs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x1400012bc
#6A03# ; push 3
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x1400012c3
#6600488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x1400012e6
#6A04# ; push 4
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x1400012ed
#6700488D# ; add byte ptr [eax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140001310
#6A05# ; push 5
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C20800# ; ret 8
#C8000000# ; enter 0, 0
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C14000000# ; jl 0x140001340
#FF7518# ; push qword ptr [rbp + 0x18]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4881E0FF000000# ; and rax, 0xff
#50# ; push rax
#E84D4A0000# ; call 0x140005d8d
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8D25000000# ; jge 0x140001387
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8ADFFFFFF# ; call 0x14000131a
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#48C1E808# ; shr rax, 8
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBCA# ; jmp 0x140001351
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#6A40# ; push 0x40
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F808# ; cmp rax, 8
#0F850C000000# ; jne 0x1400013b4
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C808# ; or rax, 8
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x1400013ce
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C804# ; or rax, 4
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x1400013e8
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C801# ; or rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#6A40# ; push 0x40
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8412000000# ; je 0x14000141d
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F8# ; push qword ptr [rbp - 8]
#E804FFFFFF# ; call 0x14000131a
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x140001453
#FF7530# ; push qword ptr [rbp + 0x30]
#6A66# ; push 0x66
#E8D4FEFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E8E7FEFFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E85AFEFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883E007# ; and rax, 7
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E820FEFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#4883F800# ; cmp rax, 0
#0F854C020000# ; jne 0x140001777
#68FFFFFF7F# ; push 0x7fffffff
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#48B80000008000000000# ; movabs rax, 0x80000000
#48F7D8# ; neg rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#6A08# ; push 8
#58# ; pop rax
#50# ; push rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F84D8000000# ; je 0x140001663
#6A7F# ; push 0x7f
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6880000000# ; push 0x80
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F842B000000# ; je 0x1400015f0
#FF7538# ; push qword ptr [rbp + 0x38]
#6A6A# ; push 0x6a
#E84BFDFFFF# ; call 0x14000131a
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#E83CFDFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E928000000# ; jmp 0x140001618
#FF7538# ; push qword ptr [rbp + 0x38]
#6A68# ; push 0x68
#E820FDFFFF# ; call 0x14000131a
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A04# ; push 4
#E83CFDFFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F808# ; cmp rax, 8
#0F8C17000000# ; jl 0x14000163d
#FF7538# ; push qword ptr [rbp + 0x38]
#6A41# ; push 0x41
#E8EAFCFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#50# ; push rax
#6A58# ; push 0x58
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E8C4FCFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x140001688
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E89FFCFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#FF7520# ; push qword ptr [rbp + 0x20]
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E8CBFCFFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F801# ; cmp rax, 1
#0F852E000000# ; jne 0x14000170d
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#50# ; push rax
#68B0000000# ; push 0xb0
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E81FFCFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E929000000# ; jmp 0x140001736
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#50# ; push rax
#68B8000000# ; push 0xb8
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E8F1FBFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F801# ; cmp rax, 1
#0F8518000000# ; jne 0x14000175c
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CBFBFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7528# ; push qword ptr [rbp + 0x28]
#E8DDFBFFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#E902000000# ; jmp 0x14000177e
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7530# ; push qword ptr [rbp + 0x30]
#E908000000# ; jmp 0x140001799
'0054167' #00# ; text
#488D05F1FFFFFF# ; lea rax, [rip - 0xf]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x1400017d4
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E853FBFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#FF7520# ; push qword ptr [rbp + 0x20]
#6A00# ; push 0
#E8A9FBFFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A7F# ; push 0x7f
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6880000000# ; push 0x80
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841F000000# ; je 0x14000184c
#FF7538# ; push qword ptr [rbp + 0x38]
#6883000000# ; push 0x83
#E8E0FAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E91A000000# ; jmp 0x140001866
#FF7538# ; push qword ptr [rbp + 0x38]
#6881000000# ; push 0x81
#E8C1FAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E88BFAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A7F# ; push 0x7f
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6880000000# ; push 0x80
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8418000000# ; je 0x1400018ee
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#E839FAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F851A000000# ; jne 0x140001916
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A02# ; push 2
#E83EFAFFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A04# ; push 4
#E824FAFFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#C8000000# ; enter 0, 0
#6A05# ; push 5
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E007# ; and rax, 7
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x140001973
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#6A7F# ; push 0x7f
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6880000000# ; push 0x80
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x1400019b4
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E007# ; and rax, 7
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E854FFFFFF# ; call 0x140001930
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#48C1E006# ; shl rax, 6
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E811F9FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F804# ; cmp rax, 4
#0F8517000000# ; jne 0x140001a3b
#FF7528# ; push qword ptr [rbp + 0x28]
#6A24# ; push 0x24
#E8ECF8FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F801# ; cmp rax, 1
#0F8518000000# ; jne 0x140001a61
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8C6F8FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F802# ; cmp rax, 2
#0F851A000000# ; jne 0x140001a89
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#E8CBF8FFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C22000# ; ret 0x20
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A40# ; push 0x40
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E883FEFFFF# ; call 0x140001930
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x140001ad6
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E851F8FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F808# ; cmp rax, 8
#0F850C000000# ; jne 0x140001af0
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C808# ; or rax, 8
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x140001b0a
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C804# ; or rax, 4
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B050F3F0000# ; mov rax, qword ptr [rip + 0x3f0f]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x140001b27
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C802# ; or rax, 2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x140001b41
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C801# ; or rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B05D43E0000# ; mov rax, qword ptr [rip + 0x3ed4]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#6A40# ; push 0x40
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8418000000# ; je 0x140001bd8
#FF7538# ; push qword ptr [rbp + 0x38]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E84FF7FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E837F7FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#48C1E006# ; shl rax, 6
#4883C804# ; or rax, 4
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E804F7FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E007# ; and rax, 7
#50# ; push rax
#488B05EA3D0000# ; mov rax, qword ptr [rip + 0x3dea]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E8D2F6FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F801# ; cmp rax, 1
#0F8518000000# ; jne 0x140001c7b
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8ACF6FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F802# ; cmp rax, 2
#0F851A000000# ; jne 0x140001ca3
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#E8B1F6FFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C23000# ; ret 0x30
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B05643D0000# ; mov rax, qword ptr [rip + 0x3d64]
#4883F800# ; cmp rax, 0
#0F8C1B000000# ; jl 0x140001ce1
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8B4FDFFFF# ; call 0x140001a91
#C9# ; leave
#C23000# ; ret 0x30
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8D18000000# ; jge 0x140001d07
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8C1000000# ; call 0x140001dc4
#C9# ; leave
#C23000# ; ret 0x30
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x140001d2c
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E8FBF5FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E80EF6FFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E881F5FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E804FCFFFF# ; call 0x1400019bb
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x140001df3
#FF7530# ; push qword ptr [rbp + 0x30]
#6A66# ; push 0x66
#E834F5FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A00# ; push 0
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E860F5FFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E8D3F4FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#6A04# ; push 4
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E8A9F4FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A25# ; push 0x25
#E892F4FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#E8A5F4FFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E802# ; sub rax, 2
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A7F# ; push 0x7f
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6880000000# ; push 0x80
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9CC2# ; setl dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#68E9000000# ; push 0xe9
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841F000000# ; je 0x140001f69
#FF7528# ; push qword ptr [rbp + 0x28]
#68EB000000# ; push 0xeb
#E8C3F3FFFF# ; call 0x14000131a
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F8# ; push qword ptr [rbp - 8]
#E8B8F3FFFF# ; call 0x14000131a
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8A6F3FFFF# ; call 0x14000131a
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E805# ; sub rax, 5
#50# ; push rax
#6A04# ; push 4
#E8B9F3FFFF# ; call 0x140001347
#6A05# ; push 5
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x140001fc4
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E863F3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#6A00# ; push 0
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E88FF3FFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E802F3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#4883C805# ; or rax, 5
#50# ; push rax
#E8DCF2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF75F8# ; push qword ptr [rbp - 8]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E804# ; sub rax, 4
#50# ; push rax
#6A04# ; push 4
#E8DBF2FFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C23000# ; ret 0x30
#C8100000# ; enter 0x10, 0
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E802# ; sub rax, 2
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A7F# ; push 0x7f
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6880000000# ; push 0x80
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9CC2# ; setl dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8425000000# ; je 0x140002126
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#6A70# ; push 0x70
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E806F2FFFF# ; call 0x14000131a
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F8# ; push qword ptr [rbp - 8]
#E8FBF1FFFF# ; call 0x14000131a
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#6A0F# ; push 0xf
#E8EAF1FFFF# ; call 0x14000131a
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#6880000000# ; push 0x80
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E8D4F1FFFF# ; call 0x14000131a
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E806# ; sub rax, 6
#50# ; push rax
#6A04# ; push 4
#E8E7F1FFFF# ; call 0x140001347
#6A06# ; push 6
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#6A01# ; push 1
#6A00# ; push 0
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#E8FBF1FFFF# ; call 0x14000138f
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#6A0F# ; push 0xf
#E86FF1FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6890000000# ; push 0x90
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E84CF1FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883E007# ; and rax, 7
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E823F1FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C21800# ; ret 0x18
#C8000000# ; enter 0, 0
#E907000000# ; jmp 0x14000221c
'error ' #00# ; text
#488D05F2FFFFFF# ; lea rax, [rip - 0xe]
#50# ; push rax
#E80FEBFFFF# ; call 0x140000d38
#488B0520380000# ; mov rax, qword ptr [rip + 0x3820]
#50# ; push rax
#E802EBFFFF# ; call 0x140000d38
#6A0A# ; push 0xa
#E8AD3B0000# ; call 0x140005dea
#6A01# ; push 1
#E8B03B0000# ; call 0x140005df4
#31C0# ; xor eax, eax
#C9# ; leave
#C3# ; ret
#C8300000# ; enter 0x30, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#6A0A# ; push 0xa
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F840E000000# ; je 0x140002287
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883C001# ; add rax, 1
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#EBE2# ; jmp 0x140002269
#E902000000# ; jmp 0x14000228e
#6200488D05F7FFFFFF0FB60050488B45# ; data
#D84883# ; fmul dword ptr [rax - 0x7d]
#E8010FB600# ; call 0x140b631a5
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9FC2# ; setg dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x1400022d6
#6A02# ; push 2
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E902000000# ; jmp 0x1400022e8
#58# ; pop rax
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140002311
#7800# ; js 0x140002311
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E902000000# ; jmp 0x14000233e
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841E000000# ; je 0x140002383
#6A10# ; push 0x10
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C002# ; add rax, 2
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E902000000# ; jmp 0x14000238a
#4600488D# ; add byte ptr [rax - 0x73], r9b
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x1400023ac
#4100488D# ; add byte ptr [r8 - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E902000000# ; jmp 0x1400023d2
#6600488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x1400023f4
#6100488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E89FE2FFFF# ; call 0x1400006ba
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8441010000# ; je 0x14000256d
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x14000244e
#6200488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A02# ; push 2
#58# ; pop rax
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8408000000# ; je 0x140002495
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#C9# ; leave
#C20800# ; ret 8
#FF75F8# ; push qword ptr [rbp - 8]
#E81DE2FFFF# ; call 0x1400006ba
#4885C0# ; test rax, rax
#0F8423000000# ; je 0x1400024c9
#E902000000# ; jmp 0x1400024ad
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E969000000# ; jmp 0x140002532
#E902000000# ; jmp 0x1400024d0
#6100488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8C27000000# ; jl 0x140002510
#E902000000# ; jmp 0x1400024f0
#6100488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883C00A# ; add rax, 0xa
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E922000000# ; jmp 0x140002532
#E902000000# ; jmp 0x140002517
#4100488D# ; add byte ptr [r8 - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883C00A# ; add rax, 0xa
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E0# ; push qword ptr [rbp - 0x20]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E916FEFFFF# ; jmp 0x140002383
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#C9# ; leave
#C20800# ; ret 8
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#4883F800# ; cmp rax, 0
#0F8443000000# ; je 0x1400025db
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F83A# ; cmp rax, 0x3a
#0F8508000000# ; jne 0x1400025ae
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C20800# ; ret 8
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A21# ; push 0x21
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4881E0FF1F0000# ; and rax, 0x1fff
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBA8# ; jmp 0x140002583
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C20800# ; ret 8
#C8100000# ; enter 0x10, 0
#6A01# ; push 1
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8438000000# ; je 0x14000264c
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#EBA2# ; jmp 0x1400025ee
#6A3A# ; push 0x3a
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#C9# ; leave
#C21000# ; ret 0x10
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D1FEFFFF# ; call 0x140002575
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4881F800200000# ; cmp rax, 0x2000
#0F8D90000000# ; jge 0x140002749
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#48C1E006# ; shl rax, 6
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#488B00# ; mov rax, qword ptr [rax]
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F850A000000# ; jne 0x1400026f8
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C21000# ; ret 0x10
#FF7518# ; push qword ptr [rbp + 0x18]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C008# ; add rax, 8
#50# ; push rax
#E8DAFEFFFF# ; call 0x1400025e3
#4885C0# ; test rax, rax
#0F8413000000# ; je 0x140002725
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4889052B330000# ; mov qword ptr [rip + 0x332b], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#4881E0FF1F0000# ; and rax, 0x1fff
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883C001# ; add rax, 1
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E95FFFFFFF# ; jmp 0x1400026a8
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C21000# ; ret 0x10
#C8300000# ; enter 0x30, 0
#31C0# ; xor eax, eax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E804FEFFFF# ; call 0x140002575
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4881F800200000# ; cmp rax, 0x2000
#0F8D12010000# ; jge 0x140002898
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#48C1E006# ; shl rax, 6
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#488B00# ; mov rax, qword ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F85C1000000# ; jne 0x140002874
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#6A08# ; push 8
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#6A3F# ; push 0x3f
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9CC2# ; setl dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F843C000000# ; je 0x14000283e
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F83A# ; cmp rax, 0x3a
#0F8420000000# ; je 0x140002830
#FF75D8# ; push qword ptr [rbp - 0x28]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#408807# ; mov byte ptr [rdi], al
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883C001# ; add rax, 1
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#EB89# ; jmp 0x1400027c7
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F840# ; cmp rax, 0x40
#0F8D21000000# ; jge 0x14000286d
#FF75D8# ; push qword ptr [rbp - 0x28]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#408807# ; mov byte ptr [rdi], al
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883C001# ; add rax, 1
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#EBD1# ; jmp 0x14000283e
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C21800# ; ret 0x18
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#4881E0FF1F0000# ; and rax, 0x1fff
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883C001# ; add rax, 1
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E9DDFEFFFF# ; jmp 0x140002775
#E86FF9FFFF# ; call 0x14000220c
#31C0# ; xor eax, eax
#C9# ; leave
#C21800# ; ret 0x18
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8D8FDFFFF# ; call 0x14000268a
#4883F800# ; cmp rax, 0
#0F8C10000000# ; jl 0x1400028cc
#488B0585310000# ; mov rax, qword ptr [rip + 0x3185]
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#31C0# ; xor eax, eax
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#FF7510# ; push qword ptr [rbp + 0x10]
#E889E5FFFF# ; call 0x140000e67
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F800# ; cmp rax, 0
#0F8D05000000# ; jge 0x1400028f5
#E817F9FFFF# ; call 0x14000220c
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C20800# ; ret 8
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E884E0FFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8416000000# ; je 0x140002934
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F80A# ; cmp rax, 0xa
#0F8405000000# ; je 0x140002934
#E8D8F8FFFF# ; call 0x14000220c
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E845E0FFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8417000000# ; je 0x140002974
#FF7510# ; push qword ptr [rbp + 0x10]
#E8ECDEFFFF# ; call 0x140000851
#4883F831# ; cmp rax, 0x31
#0F8405000000# ; je 0x140002974
#E898F8FFFF# ; call 0x14000220c
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E872FFFFFF# ; call 0x1400028fd
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EA2D0000# ; call 0x140005784
#C9# ; leave
#C22000# ; ret 0x20
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8DDDFFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E889F8FFFF# ; call 0x140002248
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E82FFFFFFF# ; call 0x1400028fd
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#E8762D0000# ; call 0x140005753
#C9# ; leave
#C21800# ; ret 0x18
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E892DFFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8ABDCFFFF# ; call 0x1400006ba
#50# ; push rax
#6A02# ; push 2
#58# ; pop rax
#50# ; push rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8468000000# ; je 0x140002a98
#FF7510# ; push qword ptr [rbp + 0x10]
#E810F8FFFF# ; call 0x140002248
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F87F# ; cmp rax, 0x7f
#0F8F26000000# ; jg 0x140002a70
#FF7520# ; push qword ptr [rbp + 0x20]
#6A6A# ; push 0x6a
#E8C6E8FFFF# ; call 0x14000131a
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E8B7E8FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#FF7520# ; push qword ptr [rbp + 0x20]
#6A68# ; push 0x68
#E8A0E8FFFF# ; call 0x14000131a
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A04# ; push 4
#E8BCE8FFFF# ; call 0x140001347
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#FF7510# ; push qword ptr [rbp + 0x10]
#E832FEFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E84EFEFFFF# ; call 0x1400028fd
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#E83C2D0000# ; call 0x1400057fd
#C9# ; leave
#C22000# ; ret 0x20
#C8400000# ; enter 0x40, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E89EDEFFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E853DDFFFF# ; call 0x140000851
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A23# ; push 0x23
#58# ; pop rax
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A45# ; push 0x45
#58# ; pop rax
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A46# ; push 0x46
#58# ; pop rax
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A44# ; push 0x44
#58# ; pop rax
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F841B010000# ; je 0x140002c81
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F844# ; cmp rax, 0x44
#0F8507000000# ; jne 0x140002b7b
#6A01# ; push 1
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F846# ; cmp rax, 0x46
#0F8507000000# ; jne 0x140002b90
#6A02# ; push 2
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F845# ; cmp rax, 0x45
#0F8507000000# ; jne 0x140002ba5
#6A04# ; push 4
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F823# ; cmp rax, 0x23
#0F8507000000# ; jne 0x140002bba
#6A08# ; push 8
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CBDDFFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E880DCFFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F8405000000# ; je 0x140002be0
#E82CF6FFFF# ; call 0x14000220c
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A8150000# ; call 0x140004196
#488B05432E0000# ; mov rax, qword ptr [rip + 0x2e43]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E83EFDFFFF# ; call 0x14000293c
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E883DDFFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B9FCFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#4883F80E# ; cmp rax, 0xe
#0F8556000000# ; jne 0x140002c81
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F801# ; cmp rax, 1
#0F8524000000# ; jne 0x140002c5d
#FF7528# ; push qword ptr [rbp + 0x28]
#6A38# ; push 0x38
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05CD2D0000# ; mov rax, qword ptr [rip + 0x2dcd]
#50# ; push rax
#488B05D52D0000# ; mov rax, qword ptr [rip + 0x2dd5]
#50# ; push rax
#E852F0FFFF# ; call 0x140001cab
#C9# ; leave
#C22800# ; ret 0x28
#FF7528# ; push qword ptr [rbp + 0x28]
#6A39# ; push 0x39
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05A92D0000# ; mov rax, qword ptr [rip + 0x2da9]
#50# ; push rax
#488B05B12D0000# ; mov rax, qword ptr [rip + 0x2db1]
#50# ; push rax
#E82EF0FFFF# ; call 0x140001cab
#C9# ; leave
#C22800# ; ret 0x28
#FF7518# ; push qword ptr [rbp + 0x18]
#E849FCFFFF# ; call 0x1400028d2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E87AE3FFFF# ; call 0x14000100f
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E898FCFFFF# ; call 0x14000293c
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8DDDCFFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8F6D9FFFF# ; call 0x1400006ba
#50# ; push rax
#E902000000# ; jmp 0x140002ccc
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F31D2# ; data
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F84AD000000# ; je 0x140002da3
#E902000000# ; jmp 0x140002cfd
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F4839# ; data
#F8# ; clc
#0F8528000000# ; jne 0x140002d41
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E86CDCFFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E818F5FFFF# ; call 0x140002248
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E90C000000# ; jmp 0x140002d4d
#FF7518# ; push qword ptr [rbp + 0x18]
#E8FFF4FFFF# ; call 0x140002248
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E902000000# ; jmp 0x140002d54
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7530# ; push qword ptr [rbp + 0x30]
#E908000000# ; jmp 0x140002d6f
'1235406' #00# ; text
#488D05F1FFFFFF# ; lea rax, [rip - 0xf]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E808# ; sub rax, 8
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E0# ; push qword ptr [rbp - 0x20]
#6A00# ; push 0
#E870E7FFFF# ; call 0x14000150f
#C9# ; leave
#C22800# ; ret 0x28
#FF7518# ; push qword ptr [rbp + 0x18]
#E827FBFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E843FBFFFF# ; call 0x1400028fd
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#4883F80D# ; cmp rax, 0xd
#0F851A000000# ; jne 0x140002de6
#FF7528# ; push qword ptr [rbp + 0x28]
#6885000000# ; push 0x85
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E842E6FFFF# ; call 0x140001424
#C9# ; leave
#C22800# ; ret 0x28
#E902000000# ; jmp 0x140002ded
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7530# ; push qword ptr [rbp + 0x30]
#E908000000# ; jmp 0x140002e08
'0546107' #00# ; text
#488D05F1FFFFFF# ; lea rax, [rip - 0xf]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E808# ; sub rax, 8
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#48C1E003# ; shl rax, 3
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E8E0E5FFFF# ; call 0x140001424
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E82FDBFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E865FAFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E881FAFFFF# ; call 0x1400028fd
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F814# ; cmp rax, 0x14
#0F8F19000000# ; jg 0x140002ea7
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883E001# ; and rax, 1
#50# ; push rax
#6A05# ; push 5
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E921000000# ; jmp 0x140002ec8
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883E80A# ; sub rax, 0xa
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F815# ; cmp rax, 0x15
#0F8507000000# ; jne 0x140002ec8
#6A0F# ; push 0xf
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E891F2FFFF# ; call 0x140002167
#C9# ; leave
#C22000# ; ret 0x20
#C8300000# ; enter 0x30, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E88DDAFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8C3F9FFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8F4E0FFFF# ; call 0x14000100f
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E812FAFFFF# ; call 0x14000293c
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E857DAFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E870D7FFFF# ; call 0x1400006ba
#4885C0# ; test rax, rax
#0F84AB000000# ; je 0x140002ffe
#FF7510# ; push qword ptr [rbp + 0x10]
#E8EDF2FFFF# ; call 0x140002248
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F80F# ; cmp rax, 0xf
#0F850C000000# ; jne 0x140002f79
#6A04# ; push 4
#58# ; pop rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#E907000000# ; jmp 0x140002f80
#6A05# ; push 5
#58# ; pop rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A00# ; push 0
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#E8FDE3FFFF# ; call 0x14000138f
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#68C1000000# ; push 0xc1
#E877E3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883E007# ; and rax, 7
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E841E3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75E0# ; push qword ptr [rbp - 0x20]
#E829E3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#FF7510# ; push qword ptr [rbp + 0x10]
#E84BD8FFFF# ; call 0x140000851
#4883F82F# ; cmp rax, 0x2f
#0F8405000000# ; je 0x140003015
#E8F7F1FFFF# ; call 0x14000220c
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8DDF8FFFF# ; call 0x1400028fd
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#E8F4280000# ; call 0x140005926
#C9# ; leave
#C22000# ; ret 0x20
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E83DD9FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F2D7FFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F8570000000# ; jne 0x1400030d9
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E81CD9FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E852F8FFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#6A00# ; push 0
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#E8FAE2FFFF# ; call 0x14000138f
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68FF000000# ; push 0xff
#E874E2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883E007# ; and rax, 7
#50# ; push rax
#6A10# ; push 0x10
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E84EE2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E886DDFFFF# ; call 0x140000e67
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F800# ; cmp rax, 0
#0F8C67000000# ; jl 0x14000315a
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8FFF7FFFF# ; call 0x1400028fd
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#6A00# ; push 0
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#E87CE2FFFF# ; call 0x14000138f
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68FF000000# ; push 0xff
#E8F6E1FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883E007# ; and rax, 7
#50# ; push rax
#68D0000000# ; push 0xd0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E8CDE1FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7510# ; push qword ptr [rbp + 0x10]
#E825F5FFFF# ; call 0x14000268a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8D07000000# ; jge 0x14000317e
#6A00# ; push 0
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E874F7FFFF# ; call 0x1400028fd
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68E8000000# ; push 0xe8
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7518# ; push qword ptr [rbp + 0x18]
#E80FEDFFFF# ; call 0x140001eaf
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8D7D7FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E885D6FFFF# ; call 0x140000851
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x1400031db
#E831F0FFFF# ; call 0x14000220c
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A4F4FFFF# ; call 0x14000268a
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8405000000# ; je 0x140003229
#E8E3EFFFFF# ; call 0x14000220c
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8505000000# ; jne 0x140003243
#E8C9EFFFFF# ; call 0x14000220c
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F81C# ; cmp rax, 0x1c
#0F8517000000# ; jne 0x140003268
#FF7530# ; push qword ptr [rbp + 0x30]
#68E9000000# ; push 0xe9
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E84BECFFFF# ; call 0x140001eaf
#C9# ; leave
#C23000# ; ret 0x30
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F852# ; cmp rax, 0x52
#0F8C48000000# ; jl 0x1400032be
#FF7530# ; push qword ptr [rbp + 0x30]
#E902000000# ; jmp 0x140003280
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7538# ; push qword ptr [rbp + 0x38]
#E905000000# ; jmp 0x140003298
#3D3F3E3C00# ; cmp eax, 0x3c3e3f
#488D05F4FFFFFF# ; lea rax, [rip - 0xc]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E852# ; sub rax, 0x52
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8C7EDFFFF# ; call 0x140002081
#C9# ; leave
#C23000# ; ret 0x30
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F839# ; cmp rax, 0x39
#0F8D1D000000# ; jge 0x1400032e9
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7538# ; push qword ptr [rbp + 0x38]
#6A22# ; push 0x22
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E89CEDFFFF# ; call 0x140002081
#C9# ; leave
#C23000# ; ret 0x30
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F83C# ; cmp rax, 0x3c
#0F8C14000000# ; jl 0x14000330b
#FF7530# ; push qword ptr [rbp + 0x30]
#6A02# ; push 2
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E87AEDFFFF# ; call 0x140002081
#C9# ; leave
#C23000# ; ret 0x30
#FF7530# ; push qword ptr [rbp + 0x30]
#E902000000# ; jmp 0x140003315
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7538# ; push qword ptr [rbp + 0x38]
#E904000000# ; jmp 0x14000332c
#3536340048# ; xor eax, 0x48003436
#8D05F5FFFFFF# ; lea eax, [rip - 0xb]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E839# ; sub rax, 0x39
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E833EDFFFF# ; call 0x140002081
#C9# ; leave
#C23000# ; ret 0x30
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#6A01# ; push 1
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4885C0# ; test rax, rax
#0F84A9010000# ; je 0x140003521
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E80DD6FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F822# ; cmp rax, 0x22
#0F852C000000# ; jne 0x1400033c4
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E800260000# ; call 0x1400059a3
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D5D5FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E92E010000# ; jmp 0x1400034f2
#E902000000# ; jmp 0x1400033cb
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F855B000000# ; jne 0x140003442
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x1400033f7
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E8C3050000# ; call 0x1400039ce
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B052A260000# ; mov rax, qword ptr [rip + 0x262a]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x140003424
#2C00# ; sub al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A01# ; push 1
#E895050000# ; call 0x1400039ce
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E95F000000# ; jmp 0x1400034a1
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E83DF2FFFF# ; call 0x14000268a
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F800# ; cmp rax, 0
#0F8C0D000000# ; jl 0x14000346c
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E90C000000# ; jmp 0x140003478
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D4EDFFFF# ; call 0x140002248
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x140003488
#2C00# ; sub al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A01# ; push 1
#E831050000# ; call 0x1400039ce
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B0598250000# ; mov rax, qword ptr [rip + 0x2598]
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F801# ; cmp rax, 1
#0F851D000000# ; jne 0x1400034d7
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E855DEFFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E91B000000# ; jmp 0x1400034f2
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7528# ; push qword ptr [rbp + 0x28]
#E862DEFFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E902000000# ; jmp 0x1400034f9
#2C00# ; sub al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8407000000# ; je 0x14000351c
#6A00# ; push 0
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E94AFEFFFF# ; jmp 0x14000336b
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C22800# ; ret 0x28
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#E8AF260000# ; call 0x140005bfa
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C040# ; add rax, 0x40
#50# ; push rax
#E89D260000# ; call 0x140005bfa
#6A00# ; push 0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF75F8# ; push qword ptr [rbp - 8]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F842C000000# ; je 0x1400035a7
#FF75F8# ; push qword ptr [rbp - 8]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#408807# ; mov byte ptr [rdi], al
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBBD# ; jmp 0x140003564
#FF75F8# ; push qword ptr [rbp - 8]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#408807# ; mov byte ptr [rdi], al
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8534000000# ; jne 0x14000360b
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A1F0FFFF# ; call 0x14000268a
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x1400035f8
#E814ECFFFF# ; call 0x14000220c
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E84DF1FFFF# ; call 0x140002753
#E923000000# ; jmp 0x14000362e
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F850E000000# ; jne 0x14000362e
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E875F2FFFF# ; call 0x1400028a3
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E857D3FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F800# ; cmp rax, 0
#0F8507000000# ; jne 0x140003652
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#FF7518# ; push qword ptr [rbp + 0x18]
#E8F7D1FFFF# ; call 0x140000851
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A3A# ; push 0x3a
#58# ; pop rax
#50# ; push rax
#FF75E0# ; push qword ptr [rbp - 0x20]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E801# ; sub rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#6A51# ; push 0x51
#58# ; pop rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8410000000# ; je 0x1400036c8
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4889058D230000# ; mov qword ptr [rip + 0x238d], rax
#E844EBFFFF# ; call 0x14000220c
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F851# ; cmp rax, 0x51
#0F8567000000# ; jne 0x14000373d
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A0A# ; push 0xa
#6A00# ; push 0
#6A00# ; push 0
#E8E4020000# ; call 0x1400039ce
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F840E000000# ; je 0x140003736
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7510# ; push qword ptr [rbp + 0x10]
#E86DF1FFFF# ; call 0x1400028a3
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F81F# ; cmp rax, 0x1f
#0F8517000000# ; jne 0x140003762
#FF7530# ; push qword ptr [rbp + 0x30]
#6A01# ; push 1
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8F4FBFFFF# ; call 0x140003352
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F83F# ; cmp rax, 0x3f
#0F8517000000# ; jne 0x140003787
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8CFFBFFFF# ; call 0x140003352
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F840# ; cmp rax, 0x40
#0F8517000000# ; jne 0x1400037ac
#FF7530# ; push qword ptr [rbp + 0x30]
#6A04# ; push 4
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8AAFBFFFF# ; call 0x140003352
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F841# ; cmp rax, 0x41
#0F8517000000# ; jne 0x1400037d1
#FF7530# ; push qword ptr [rbp + 0x30]
#6A02# ; push 2
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E885FBFFFF# ; call 0x140003352
#C9# ; leave
#C22800# ; ret 0x28
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E897D1FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E862D6FFFF# ; call 0x140000e67
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F800# ; cmp rax, 0
#0F8D0C000000# ; jge 0x140003823
#FF7518# ; push qword ptr [rbp + 0x18]
#E829EAFFFF# ; call 0x140002248
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E80EF1FFFF# ; call 0x14000293c
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E853D1FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E81ED6FFFF# ; call 0x140000e67
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4885C0# ; test rax, rax
#0F844E000000# ; je 0x1400038a8
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F802# ; cmp rax, 2
#0F8511000000# ; jne 0x140003879
#FF7528# ; push qword ptr [rbp + 0x28]
#68EC000000# ; push 0xec
#E8A5DAFFFF# ; call 0x14000131a
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#68E4000000# ; push 0xe4
#E894DAFFFF# ; call 0x14000131a
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B3E9FFFF# ; call 0x140002248
#50# ; push rax
#E87FDAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F802# ; cmp rax, 2
#0F8511000000# ; jne 0x1400038c7
#FF7528# ; push qword ptr [rbp + 0x28]
#68EE000000# ; push 0xee
#E857DAFFFF# ; call 0x14000131a
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#68E6000000# ; push 0xe6
#E846DAFFFF# ; call 0x14000131a
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E837DAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#C8000000# ; enter 0, 0
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F801# ; cmp rax, 1
#0F850F000000# ; jne 0x140003911
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F802# ; cmp rax, 2
#0F850F000000# ; jne 0x14000392e
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F803# ; cmp rax, 3
#0F8510000000# ; jne 0x14000394c
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F804# ; cmp rax, 4
#0F8512000000# ; jne 0x14000396c
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4889F9# ; mov rcx, rdi
#48D3E0# ; shl rax, cl
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F805# ; cmp rax, 5
#0F8512000000# ; jne 0x14000398c
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4889F9# ; mov rcx, rdi
#48D3E8# ; shr rax, cl
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F806# ; cmp rax, 6
#0F850F000000# ; jne 0x1400039a9
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F807# ; cmp rax, 7
#0F850F000000# ; jne 0x1400039c6
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#C9# ; leave
#C21800# ; ret 0x18
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F800# ; cmp rax, 0
#0F84C7030000# ; je 0x140003db5
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E897CFFFFF# ; call 0x140000990
#48894538# ; mov qword ptr [rbp + 0x38], rax
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F800# ; cmp rax, 0
#0F8512000000# ; jne 0x140003a1d
#6A00# ; push 0
#58# ; pop rax
#4889052B200000# ; mov qword ptr [rip + 0x202b], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C23000# ; ret 0x30
#6A0A# ; push 0xa
#58# ; pop rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#FF7520# ; push qword ptr [rbp + 0x20]
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8413000000# ; je 0x140003a69
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#488905DF1F0000# ; mov qword ptr [rip + 0x1fdf], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C23000# ; ret 0x30
#E902000000# ; jmp 0x140003a70
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F856C000000# ; jne 0x140003af8
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E902000000# ; jmp 0x140003a9c
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E81EFFFFFF# ; call 0x1400039ce
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B05851F0000# ; mov rax, qword ptr [rip + 0x1f85]
#48894538# ; mov qword ptr [rbp + 0x38], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8514000000# ; jne 0x140003ae1
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#48894518# ; mov qword ptr [rbp + 0x18], rax
#6A01# ; push 1
#58# ; pop rax
#48894510# ; mov qword ptr [rbp + 0x10], rax
#E912000000# ; jmp 0x140003af3
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E801FEFFFF# ; call 0x1400038f0
#48894518# ; mov qword ptr [rbp + 0x18], rax
#E9B8020000# ; jmp 0x140003db0
#E902000000# ; jmp 0x140003aff
#7C00# ; jl 0x140003aff
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140003b24
#2600488D# ; add byte ptr es:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140003b49
#3E00488D# ; add byte ptr ds:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140003b6e
#3C00# ; cmp al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140003b93
#2A00# ; sub al, byte ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140003bb8
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45300FB6005F31D2# ; data
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x140003bdd
#2B00# ; sub eax, dword ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F842B010000# ; je 0x140003d46
#E902000000# ; jmp 0x140003c22
#2B00# ; sub eax, dword ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140003c45
#6A01# ; push 1
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x140003c4c
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45300FB6005F4839# ; data
#F8# ; clc
#0F8507000000# ; jne 0x140003c6f
#6A02# ; push 2
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x140003c76
#2A00# ; sub al, byte ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140003c99
#6A03# ; push 3
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x140003ca0
#3C00# ; cmp al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140003cc3
#6A04# ; push 4
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x140003cca
#3E00488D# ; add byte ptr ds:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140003ced
#6A05# ; push 5
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x140003cf4
#2600488D# ; add byte ptr es:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140003d17
#6A06# ; push 6
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x140003d1e
#7C00# ; jl 0x140003d1e
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x140003d41
#6A07# ; push 7
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E96A000000# ; jmp 0x140003db0
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E839E9FFFF# ; call 0x14000268a
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F800# ; cmp rax, 0
#0F8C0D000000# ; jl 0x140003d70
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E90C000000# ; jmp 0x140003d7c
#FF7530# ; push qword ptr [rbp + 0x30]
#E8D0E4FFFF# ; call 0x140002248
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8514000000# ; jne 0x140003d9e
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#48894518# ; mov qword ptr [rbp + 0x18], rax
#6A01# ; push 1
#58# ; pop rax
#48894510# ; mov qword ptr [rbp + 0x10], rax
#E912000000# ; jmp 0x140003db0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E844FBFFFF# ; call 0x1400038f0
#48894518# ; mov qword ptr [rbp + 0x18], rax
#E92BFCFFFF# ; jmp 0x1400039e0
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#488905801C0000# ; mov qword ptr [rip + 0x1c80], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C23000# ; ret 0x30
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A7CBFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8DDEAFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E80ED2FFFF# ; call 0x14000100f
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E82CEBFFFF# ; call 0x14000293c
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E871CBFFFF# ; call 0x140000990
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A7EAFFFF# ; call 0x1400028d2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A00# ; push 0
#E84DD5FFFF# ; call 0x14000138f
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#6A0F# ; push 0xf
#E8CAD4FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#68AF000000# ; push 0xaf
#E8B0D4FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883E007# ; and rax, 7
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E876D4FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8BECAFFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F4E9FFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E825D1FFFF# ; call 0x14000100f
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E843EAFFFF# ; call 0x14000293c
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E888CAFFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E905000000# ; jmp 0x140003f19
#6279746500488D05F4FFFFFF50E84CCE# ; data
#FFFF4885C00F840F000000FF7528FF75# ; data
#20E8# ; and al, ch
#56# ; push rsi
#CAFFFF# ; retf 0xffff
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E80BC9FFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F8583000000# ; jne 0x140003fd3
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E838020000# ; call 0x140004196
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05AA1A0000# ; mov rax, qword ptr [rip + 0x1aaa]
#50# ; push rax
#6A00# ; push 0
#E819D4FFFF# ; call 0x14000138f
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A0F# ; push 0xf
#E896D3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68B6000000# ; push 0xb6
#E87CD3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05601A0000# ; mov rax, qword ptr [rip + 0x1a60]
#50# ; push rax
#488B05681A0000# ; mov rax, qword ptr [rip + 0x1a68]
#50# ; push rax
#E8F5D9FFFF# ; call 0x1400019bb
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F7E8FFFF# ; call 0x1400028d2
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#50# ; push rax
#E88BD3FFFF# ; call 0x14000138f
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A0F# ; push 0xf
#E808D3FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68B6000000# ; push 0xb6
#E8EED2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883E007# ; and rax, 7
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E8B4D2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E808C9FFFF# ; call 0x140000990
#48894530# ; mov qword ptr [rbp + 0x30], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#E8BDC7FFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F8405000000# ; je 0x1400040a3
#E869E1FFFF# ; call 0x14000220c
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8E5000000# ; call 0x140004196
#488B0560190000# ; mov rax, qword ptr [rip + 0x1960]
#4883F800# ; cmp rax, 0
#0F8C1A000000# ; jl 0x1400040dc
#FF7538# ; push qword ptr [rbp + 0x38]
#6A04# ; push 4
#6A00# ; push 0
#488B0548190000# ; mov rax, qword ptr [rip + 0x1948]
#50# ; push rax
#6A00# ; push 0
#E8B7D2FFFF# ; call 0x14000138f
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#6A0F# ; push 0xf
#E834D2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#6A01# ; push 1
#E81DD2FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B0507190000# ; mov rax, qword ptr [rip + 0x1907]
#4883F800# ; cmp rax, 0
#0F8C28000000# ; jl 0x140004143
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B05F0180000# ; mov rax, qword ptr [rip + 0x18f0]
#50# ; push rax
#488B05F8180000# ; mov rax, qword ptr [rip + 0x18f8]
#50# ; push rax
#E885D8FFFF# ; call 0x1400019bb
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#48C1E003# ; shl rax, 3
#4883C805# ; or rax, 5
#50# ; push rax
#E8C2D1FFFF# ; call 0x14000131a
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#488B05B3180000# ; mov rax, qword ptr [rip + 0x18b3]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E804# ; sub rax, 4
#50# ; push rax
#6A04# ; push 4
#E8BED1FFFF# ; call 0x140001347
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A01# ; push 1
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#48890564180000# ; mov qword ptr [rip + 0x1864], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#4889055F180000# ; mov qword ptr [rip + 0x185f], rax
#6A00# ; push 0
#58# ; pop rax
#4889055D180000# ; mov qword ptr [rip + 0x185d], rax
#6A00# ; push 0
#58# ; pop rax
#4889055B180000# ; mov qword ptr [rip + 0x185b], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B0C7FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E904000000# ; jmp 0x1400041f0
#7265# ; jb 0x140004253
#6C# ; insb byte ptr [rdi], dx
#00488D# ; add byte ptr [rax - 0x73], cl
#05F5FFFFFF# ; add eax, 0xfffffff5
#50# ; push rax
#E875CBFFFF# ; call 0x140000d72
#4885C0# ; test rax, rax
#0F8455000000# ; je 0x14000425b
#6A01# ; push 1
#58# ; pop rax
#48890520180000# ; mov qword ptr [rip + 0x1820], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E875C7FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E860E4FFFF# ; call 0x14000268a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8C0B000000# ; jl 0x140004247
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#488905E1170000# ; mov qword ptr [rip + 0x17e1], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E83EC7FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E963020000# ; jmp 0x1400044be
#FF7518# ; push qword ptr [rbp + 0x18]
#E804CCFFFF# ; call 0x140000e67
#488905AE170000# ; mov qword ptr [rip + 0x17ae], rax
#488B05A7170000# ; mov rax, qword ptr [rip + 0x17a7]
#4883F800# ; cmp rax, 0
#0F8D3C000000# ; jge 0x1400042b7
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E804E4FFFF# ; call 0x14000268a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8C10000000# ; jl 0x1400042a8
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48890585170000# ; mov qword ptr [rip + 0x1785], rax
#E90F000000# ; jmp 0x1400042b7
#FF7518# ; push qword ptr [rbp + 0x18]
#E898DFFFFF# ; call 0x140002248
#48890571170000# ; mov qword ptr [rip + 0x1771], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CEC6FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E902000000# ; jmp 0x1400042cd
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F31D2# ; data
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x1400042f2
#2B00# ; sub eax, dword ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F84A2010000# ; je 0x1400044be
#E902000000# ; jmp 0x140004323
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F4839# ; data
#F8# ; clc
#0F850A000000# ; jne 0x140004349
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E83CC6FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E807CBFFFF# ; call 0x140000e67
#488905B9160000# ; mov qword ptr [rip + 0x16b9], rax
#488B05B2160000# ; mov rax, qword ptr [rip + 0x16b2]
#4883F800# ; cmp rax, 0
#0F8D37010000# ; jge 0x1400044af
#E902000000# ; jmp 0x14000437f
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8560000000# ; jne 0x1400043fb
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x1400043ab
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E80FF6FFFF# ; call 0x1400039ce
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#50# ; push rax
#488B0551160000# ; mov rax, qword ptr [rip + 0x1651]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#48890546160000# ; mov qword ptr [rip + 0x1646], rax
#488B0557160000# ; mov rax, qword ptr [rip + 0x1657]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E89EC5FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E9AF000000# ; jmp 0x1400044aa
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8B2C2FFFF# ; call 0x1400006ba
#4885C0# ; test rax, rax
#0F844D000000# ; je 0x14000445e
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x140004421
#5D# ; pop rbp
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E814DEFFFF# ; call 0x140002248
#50# ; push rax
#6A01# ; push 1
#E892F5FFFF# ; call 0x1400039ce
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#50# ; push rax
#488B05DA150000# ; mov rax, qword ptr [rip + 0x15da]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488905CF150000# ; mov qword ptr [rip + 0x15cf], rax
#E941000000# ; jmp 0x14000449f
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x14000446e
#5D# ; pop rbp
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E84CF5FFFF# ; call 0x1400039ce
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#50# ; push rax
#488B0594150000# ; mov rax, qword ptr [rip + 0x1594]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#48890589150000# ; mov qword ptr [rip + 0x1589], rax
#488B059A150000# ; mov rax, qword ptr [rip + 0x159a]
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E90F000000# ; jmp 0x1400044be
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D6C4FFFF# ; call 0x140000990
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E902000000# ; jmp 0x1400044c5
#5D# ; pop rbp
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x1400044e6
#E826DDFFFF# ; call 0x14000220c
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#48890547150000# ; mov qword ptr [rip + 0x1547], rax
#31C0# ; xor eax, eax
#C9# ; leave
#C21800# ; ret 0x18
#C8400000# ; enter 0x40, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#6A08# ; push 8
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E865C4FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E81AC3FFFF# ; call 0x140000851
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F823# ; cmp rax, 0x23
#0F8516000000# ; jne 0x14000455f
#6A08# ; push 8
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E835C4FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F845# ; cmp rax, 0x45
#0F8516000000# ; jne 0x140004583
#6A04# ; push 4
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E811C4FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F846# ; cmp rax, 0x46
#0F8516000000# ; jne 0x1400045a7
#6A02# ; push 2
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EDC3FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F844# ; cmp rax, 0x44
#0F8516000000# ; jne 0x1400045cb
#6A01# ; push 1
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8C9C3FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E87EC2FFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F85B2010000# ; jne 0x14000478f
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8ABFBFFFF# ; call 0x140004196
#488B0546140000# ; mov rax, qword ptr [rip + 0x1446]
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E83BE3FFFF# ; call 0x14000293c
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E880C3FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E84BC8FFFF# ; call 0x140000e67
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8C96000000# ; jl 0x1400046c4
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F808# ; cmp rax, 8
#0F850C000000# ; jne 0x140004648
#FF7520# ; push qword ptr [rbp + 0x20]
#E8CBC9FFFF# ; call 0x14000100f
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F801# ; cmp rax, 1
#0F850F000000# ; jne 0x140004665
#6888000000# ; push 0x88
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#E90A000000# ; jmp 0x14000466f
#6889000000# ; push 0x89
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B05BA130000# ; mov rax, qword ptr [rip + 0x13ba]
#4885C0# ; test rax, rax
#0F8420000000# ; je 0x14000469f
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B0596130000# ; mov rax, qword ptr [rip + 0x1396]
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8FAD8FFFF# ; call 0x140001f95
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B0566130000# ; mov rax, qword ptr [rip + 0x1366]
#50# ; push rax
#488B056E130000# ; mov rax, qword ptr [rip + 0x136e]
#50# ; push rax
#E8EBD5FFFF# ; call 0x140001cab
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E87CDBFFFF# ; call 0x140002248
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B0541130000# ; mov rax, qword ptr [rip + 0x1341]
#4883F800# ; cmp rax, 0
#0F8D38000000# ; jge 0x140004719
#FF7530# ; push qword ptr [rbp + 0x30]
#68C7000000# ; push 0xc7
#FF75E0# ; push qword ptr [rbp - 0x20]
#6A00# ; push 0
#488B0533130000# ; mov rax, qword ptr [rip + 0x1333]
#50# ; push rax
#E8C9D6FFFF# ; call 0x140001dc4
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A04# ; push 4
#E83BCCFFFF# ; call 0x140001347
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75E0# ; push qword ptr [rbp - 0x20]
#6A00# ; push 0
#488B05F0120000# ; mov rax, qword ptr [rip + 0x12f0]
#50# ; push rax
#6A00# ; push 0
#E85FCCFFFF# ; call 0x14000138f
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68C7000000# ; push 0xc7
#E8D9CBFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A00# ; push 0
#488B05BE120000# ; mov rax, qword ptr [rip + 0x12be]
#50# ; push rax
#488B05C6120000# ; mov rax, qword ptr [rip + 0x12c6]
#50# ; push rax
#E853D2FFFF# ; call 0x1400019bb
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A04# ; push 4
#E8C5CBFFFF# ; call 0x140001347
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E849CAFFFF# ; call 0x1400011e0
#4883F800# ; cmp rax, 0
#0F8C81000000# ; jl 0x140004822
#FF7520# ; push qword ptr [rbp + 0x20]
#E837CAFFFF# ; call 0x1400011e0
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E884E1FFFF# ; call 0x14000293c
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8C9C1FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8FFE0FFFF# ; call 0x1400028d2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#688E000000# ; push 0x8e
#E836CBFFFF# ; call 0x14000131a
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883E007# ; and rax, 7
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E805CBFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E904000000# ; jmp 0x14000482e
#637233# ; movsxd esi, dword ptr [rdx + 0x33]
#00488D# ; add byte ptr [rax - 0x73], cl
#05F5FFFFFF# ; add eax, 0xfffffff5
#50# ; push rax
#E837C5FFFF# ; call 0x140000d72
#4885C0# ; test rax, rax
#0F84A2000000# ; je 0x1400048e6
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EDE0FFFF# ; call 0x14000293c
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E832C1FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E868E0FFFF# ; call 0x1400028d2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#6A00# ; push 0
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A00# ; push 0
#E810CBFFFF# ; call 0x14000138f
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A0F# ; push 0xf
#E88DCAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A22# ; push 0x22
#E876CAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883E007# ; and rax, 7
#50# ; push rax
#6A03# ; push 3
#58# ; pop rax
#48C1E003# ; shl rax, 3
#50# ; push rax
#68C0000000# ; push 0xc0
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E841CAFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E8E4DFFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E815C7FFFF# ; call 0x14000100f
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E833E0FFFF# ; call 0x14000293c
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E878C0FFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E82DBFFFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F858A000000# ; jne 0x1400049b8
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E85AF8FFFF# ; call 0x140004196
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F801# ; cmp rax, 1
#0F850F000000# ; jne 0x140004959
#688A000000# ; push 0x8a
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#E90A000000# ; jmp 0x140004963
#688B000000# ; push 0x8b
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B05C6100000# ; mov rax, qword ptr [rip + 0x10c6]
#4885C0# ; test rax, rax
#0F8420000000# ; je 0x140004993
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05A2100000# ; mov rax, qword ptr [rip + 0x10a2]
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E806D6FFFF# ; call 0x140001f95
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#488B0572100000# ; mov rax, qword ptr [rip + 0x1072]
#50# ; push rax
#488B057A100000# ; mov rax, qword ptr [rip + 0x107a]
#50# ; push rax
#E8F7D2FFFF# ; call 0x140001cab
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E8A7C4FFFF# ; call 0x140000e67
#4883F800# ; cmp rax, 0
#0F8C4E000000# ; jl 0x140004a18
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F801# ; cmp rax, 1
#0F8520000000# ; jne 0x1400049f8
#FF7530# ; push qword ptr [rbp + 0x30]
#6888000000# ; push 0x88
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF7520# ; push qword ptr [rbp + 0x20]
#E87CC4FFFF# ; call 0x140000e67
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E830CAFFFF# ; call 0x140001424
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#6889000000# ; push 0x89
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF7520# ; push qword ptr [rbp + 0x20]
#E85CC4FFFF# ; call 0x140000e67
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E810CAFFFF# ; call 0x140001424
#C9# ; leave
#C22800# ; ret 0x28
#E902000000# ; jmp 0x140004a1f
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45200FB6005F4839# ; data
#F8# ; clc
#0F8548000000# ; jne 0x140004a83
#6A01# ; push 1
#58# ; pop rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E843BFFFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EFD7FFFF# ; call 0x140002248
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A0A# ; push 0xa
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A01# ; push 1
#E854EFFFFF# ; call 0x1400039ce
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E9CD000000# ; jmp 0x140004b50
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E82ABCFFFF# ; call 0x1400006ba
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x140004aa0
#6A01# ; push 1
#58# ; pop rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8DFDBFFFF# ; call 0x14000268a
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F800# ; cmp rax, 0
#0F8D0C000000# ; jge 0x140004ac9
#FF7520# ; push qword ptr [rbp + 0x20]
#E883D7FFFF# ; call 0x140002248
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E902000000# ; jmp 0x140004ad0
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F854B000000# ; jne 0x140004b37
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E902000000# ; jmp 0x140004afc
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E8BEEEFFFF# ; call 0x1400039ce
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B05250F0000# ; mov rax, qword ptr [rip + 0xf25]
#50# ; push rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A0A# ; push 0xa
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A01# ; push 1
#E8A0EEFFFF# ; call 0x1400039ce
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E919000000# ; jmp 0x140004b50
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A0A# ; push 0xa
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A01# ; push 1
#E882EEFFFF# ; call 0x1400039ce
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A00# ; push 0
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75C8# ; push qword ptr [rbp - 0x38]
#E8A9C9FFFF# ; call 0x14000150f
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E80DBEFFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E843DDFFFF# ; call 0x1400028d2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E874C4FFFF# ; call 0x14000100f
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E892DDFFFF# ; call 0x14000293c
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8D7BDFFFF# ; call 0x140000990
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E88CBCFFFF# ; call 0x140000851
#4883F832# ; cmp rax, 0x32
#0F8405000000# ; je 0x140004bd4
#E838D6FFFF# ; call 0x14000220c
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B4F5FFFF# ; call 0x140004196
#488B05470E0000# ; mov rax, qword ptr [rip + 0xe47]
#4885C0# ; test rax, rax
#0F8422000000# ; je 0x140004c14
#FF7530# ; push qword ptr [rbp + 0x30]
#688D000000# ; push 0x8d
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05210E0000# ; mov rax, qword ptr [rip + 0xe21]
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E885D3FFFF# ; call 0x140001f95
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#688D000000# ; push 0x8d
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05EF0D0000# ; mov rax, qword ptr [rip + 0xdef]
#50# ; push rax
#488B05F70D0000# ; mov rax, qword ptr [rip + 0xdf7]
#50# ; push rax
#E874D0FFFF# ; call 0x140001cab
#C9# ; leave
#C22800# ; ret 0x28
#C8600000# ; enter 0x60, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#488945B8# ; mov qword ptr [rbp - 0x48], rax
#488945B0# ; mov qword ptr [rbp - 0x50], rax
#488945A8# ; mov qword ptr [rbp - 0x58], rax
#488945A0# ; mov qword ptr [rbp - 0x60], rax
#6A01# ; push 1
#58# ; pop rax
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#E87A0F0000# ; call 0x140005bfa
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4881C000000100# ; add rax, 0x10000
#50# ; push rax
#E8650F0000# ; call 0x140005bfa
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#488905AC0D0000# ; mov qword ptr [rip + 0xdac], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4881C000000100# ; add rax, 0x10000
#50# ; push rax
#E8450F0000# ; call 0x140005bfa
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E861100000# ; call 0x140005d26
#4881E0FF000000# ; and rax, 0xff
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#4885C0# ; test rax, rax
#0F84480A0000# ; je 0x140005721
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A0A# ; push 0xa
#58# ; pop rax
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F95C2# ; setne dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F842E000000# ; je 0x140004d43
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F00F0000# ; call 0x140005d26
#4881E0FF000000# ; and rax, 0xff
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#EB9E# ; jmp 0x140004ce1
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A09# ; push 9
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A20# ; push 0x20
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F840E000000# ; je 0x140004d9f
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBB8# ; jmp 0x140004d57
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F825# ; cmp rax, 0x25
#0F85D7010000# ; jne 0x140004f87
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F864# ; cmp rax, 0x64
#0F8525000000# ; jne 0x140004df2
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4885C0# ; test rax, rax
#0F8413000000# ; je 0x140004ded
#6A00# ; push 0
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C008# ; add rax, 8
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E866D9FFFF# ; call 0x140002753
#E990010000# ; jmp 0x140004f82
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F869# ; cmp rax, 0x69
#0F85BB000000# ; jne 0x140004ebb
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883F83F# ; cmp rax, 0x3f
#0F8505000000# ; jne 0x140004e13
#E8F9D3FFFF# ; call 0x14000220c
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C003# ; add rax, 3
#0FB600# ; movzx eax, byte ptr [rax]
#4883F864# ; cmp rax, 0x64
#0F8529000000# ; jne 0x140004e51
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C007# ; add rax, 7
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E84DD8FFFF# ; call 0x14000268a
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#488945A0# ; mov qword ptr [rbp - 0x60], rax
#E924000000# ; jmp 0x140004e75
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C008# ; add rax, 8
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E824D8FFFF# ; call 0x14000268a
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9CC2# ; setl dl
#89D0# ; mov eax, edx
#488945A0# ; mov qword ptr [rbp - 0x60], rax
#FF75C0# ; push qword ptr [rbp - 0x40]
#488B45B0# ; mov rax, qword ptr [rbp - 0x50]
#48C1E001# ; shl rax, 1
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#488945B0# ; mov qword ptr [rbp - 0x50], rax
#FF75A0# ; push qword ptr [rbp - 0x60]
#488B45A8# ; mov rax, qword ptr [rbp - 0x58]
#48C1E001# ; shl rax, 1
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#488945A8# ; mov qword ptr [rbp - 0x58], rax
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883C001# ; add rax, 1
#488945B8# ; mov qword ptr [rbp - 0x48], rax
#FF75A0# ; push qword ptr [rbp - 0x60]
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#E9C7000000# ; jmp 0x140004f82
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F865# ; cmp rax, 0x65
#0F85A7000000# ; jne 0x140004f70
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883F800# ; cmp rax, 0
#0F8505000000# ; jne 0x140004edc
#E830D3FFFF# ; call 0x14000220c
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C002# ; add rax, 2
#0FB600# ; movzx eax, byte ptr [rax]
#4883F86C# ; cmp rax, 0x6c
#0F854A000000# ; jne 0x140004f3b
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45A8# ; mov rax, qword ptr [rbp - 0x58]
#4883E001# ; and rax, 1
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#488945A0# ; mov qword ptr [rbp - 0x60], rax
#FF75A0# ; push qword ptr [rbp - 0x60]
#488B45A8# ; mov rax, qword ptr [rbp - 0x58]
#48C1E801# ; shr rax, 1
#48C1E001# ; shl rax, 1
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#488945A8# ; mov qword ptr [rbp - 0x58], rax
#FF75A0# ; push qword ptr [rbp - 0x60]
#488B45B0# ; mov rax, qword ptr [rbp - 0x50]
#4883E001# ; and rax, 1
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#E930000000# ; jmp 0x140004f6b
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883E801# ; sub rax, 1
#488945B8# ; mov qword ptr [rbp - 0x48], rax
#488B45B0# ; mov rax, qword ptr [rbp - 0x50]
#4883E001# ; and rax, 1
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#488B45B0# ; mov rax, qword ptr [rbp - 0x50]
#48C1E801# ; shr rax, 1
#488945B0# ; mov qword ptr [rbp - 0x50], rax
#488B45A8# ; mov rax, qword ptr [rbp - 0x58]
#48C1E801# ; shr rax, 1
#488945A8# ; mov qword ptr [rbp - 0x58], rax
#E912000000# ; jmp 0x140004f82
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4885C0# ; test rax, rax
#0F8405000000# ; je 0x140004f82
#E88AD2FFFF# ; call 0x14000220c
#E995070000# ; jmp 0x14000571c
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4885C0# ; test rax, rax
#0F8488070000# ; je 0x14000571c
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E8F1B9FFFF# ; call 0x140000990
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4885C0# ; test rax, rax
#0F846C070000# ; je 0x14000571c
#FF75E8# ; push qword ptr [rbp - 0x18]
#E899B8FFFF# ; call 0x140000851
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#6A01# ; push 1
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841E000000# ; je 0x14000500e
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E87BD9FFFF# ; call 0x14000297c
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F838# ; cmp rax, 0x38
#0F851B000000# ; jne 0x140005037
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E874D9FFFF# ; call 0x14000299e
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F836# ; cmp rax, 0x36
#0F851B000000# ; jne 0x140005060
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E840B9FFFF# ; call 0x140000990
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E8ECD1FFFF# ; call 0x140002248
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A07# ; push 7
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A02# ; push 2
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841E000000# ; je 0x1400050b2
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E83CD9FFFF# ; call 0x1400029e1
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A0E# ; push 0xe
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A08# ; push 8
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8421000000# ; je 0x140005107
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CBD9FFFF# ; call 0x140002ac5
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A10# ; push 0x10
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A0F# ; push 0xf
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841E000000# ; je 0x140005159
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E88EDDFFFF# ; call 0x140002eda
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A18# ; push 0x18
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A11# ; push 0x11
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F841E000000# ; je 0x1400051ab
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E8AADCFFFF# ; call 0x140002e48
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F81B# ; cmp rax, 0x1b
#0F8521000000# ; jne 0x1400051da
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E869DEFFFF# ; call 0x140003036
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A1E# ; push 0x1e
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A1C# ; push 0x1c
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8424000000# ; je 0x140005232
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E87FDFFFFF# ; call 0x1400031a4
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A3D# ; push 0x3d
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A39# ; push 0x39
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8424000000# ; je 0x14000528a
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E827DFFFFF# ; call 0x1400031a4
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A55# ; push 0x55
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A52# ; push 0x52
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8424000000# ; je 0x1400052e2
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CFDEFFFF# ; call 0x1400031a4
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8521000000# ; jne 0x140005318
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E81EE2FFFF# ; call 0x140003529
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F820# ; cmp rax, 0x20
#0F852D000000# ; jne 0x140005353
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E85FB6FFFF# ; call 0x140000990
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E80DB5FFFF# ; call 0x140000851
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x140005353
#E8B9CEFFFF# ; call 0x14000220c
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F819# ; cmp rax, 0x19
#0F8521000000# ; jne 0x140005382
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#E882F1FFFF# ; call 0x1400044f7
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F81A# ; cmp rax, 0x1a
#0F8521000000# ; jne 0x1400053b1
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#E8C6F7FFFF# ; call 0x140004b6a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F81F# ; cmp rax, 0x1f
#0F8520000000# ; jne 0x1400053df
#FF7528# ; push qword ptr [rbp + 0x28]
#6A01# ; push 1
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E880DFFFFF# ; call 0x140003352
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F83E# ; cmp rax, 0x3e
#0F854F000000# ; jne 0x14000543c
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E898B5FFFF# ; call 0x140000990
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E844CEFFFF# ; call 0x140002248
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883E801# ; sub rax, 1
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4883F800# ; cmp rax, 0
#0F8419000000# ; je 0x14000543c
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#E8EDBEFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#EBCC# ; jmp 0x140005408
#6A41# ; push 0x41
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A3F# ; push 0x3f
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8434000000# ; je 0x1400054a4
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75D8# ; push qword ptr [rbp - 0x28]
#6A42# ; push 0x42
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#5F# ; pop rdi
#4889F9# ; mov rcx, rdi
#48D3E0# ; shl rax, cl
#50# ; push rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8BBDEFFFF# ; call 0x140003352
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F842# ; cmp rax, 0x42
#0F851B000000# ; jne 0x1400054cd
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E808E9FFFF# ; call 0x140003dc8
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F843# ; cmp rax, 0x43
#0F8521000000# ; jne 0x1400054fc
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#E8C2E9FFFF# ; call 0x140003eb1
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A49# ; push 0x49
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A47# ; push 0x47
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8444000000# ; je 0x140005574
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F847# ; cmp rax, 0x47
#0F850F000000# ; jne 0x14000554d
#68F4000000# ; push 0xf4
#58# ; pop rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#E90F000000# ; jmp 0x14000555c
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4881C0B2000000# ; add rax, 0xb2
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75C8# ; push qword ptr [rbp - 0x38]
#E8B3BDFFFF# ; call 0x14000131a
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A4B# ; push 0x4b
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A4A# ; push 0x4a
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F843E000000# ; je 0x1400055e6
#FF7528# ; push qword ptr [rbp + 0x28]
#6A48# ; push 0x48
#E868BDFFFF# ; call 0x14000131a
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#48C1E002# ; shl rax, 2
#50# ; push rax
#68F7010000# ; push 0x1f7
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#E848BDFFFF# ; call 0x14000131a
#50# ; push rax
#FF75C8# ; push qword ptr [rbp - 0x38]
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A4D# ; push 0x4d
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A4C# ; push 0x4c
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F842A000000# ; je 0x140005644
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883E84A# ; sub rax, 0x4a
#50# ; push rax
#E83CEAFFFF# ; call 0x140004073
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F84E# ; cmp rax, 0x4e
#0F8570000000# ; jne 0x1400056c2
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E833B3FFFF# ; call 0x140000990
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E869D2FFFF# ; call 0x1400028d2
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#6A0F# ; push 0xf
#E8A3BCFFFF# ; call 0x14000131a
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#E895BCFFFF# ; call 0x14000131a
#50# ; push rax
#488B45C8# ; mov rax, qword ptr [rbp - 0x38]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883E007# ; and rax, 7
#50# ; push rax
#68D8000000# ; push 0xd8
#58# ; pop rax
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E86CBCFFFF# ; call 0x14000131a
#50# ; push rax
#FF75C8# ; push qword ptr [rbp - 0x38]
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#6A50# ; push 0x50
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9EC2# ; setle dl
#89D0# ; mov eax, edx
#50# ; push rax
#6A4F# ; push 0x4f
#58# ; pop rax
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4885C0# ; test rax, rax
#0F8426000000# ; je 0x14000571c
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D8# ; push qword ptr [rbp - 0x28]
#6A50# ; push 0x50
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#E8C9E0FFFF# ; call 0x1400037d8
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#E99CF5FFFF# ; jmp 0x140004cbd
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883F800# ; cmp rax, 0
#0F8405000000# ; je 0x140005734
#E8D8CAFFFF# ; call 0x14000220c
#FF7510# ; push qword ptr [rbp + 0x10]
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF75F8# ; push qword ptr [rbp - 8]
#E8AF040000# ; call 0x140005bfa
#488B45C8# ; mov rax, qword ptr [rbp - 0x38]
#C9# ; leave
#C22000# ; ret 0x20
#C8000000# ; enter 0, 0
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C18000000# ; jl 0x14000577d
#FF7518# ; push qword ptr [rbp + 0x18]
#68CD000000# ; push 0xcd
#E81B060000# ; call 0x140005d8d
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E810060000# ; call 0x140005d8d
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8522000000# ; jne 0x1400057be
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8C0D000000# ; jl 0x1400057b7
#FF7510# ; push qword ptr [rbp + 0x10]
#68C3000000# ; push 0xc3
#E8D6050000# ; call 0x140005d8d
#6A01# ; push 1
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F801# ; cmp rax, 1
#0F8529000000# ; jne 0x1400057f5
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8C14000000# ; jl 0x1400057ee
#FF7510# ; push qword ptr [rbp + 0x10]
#6A0F# ; push 0xf
#E8A9050000# ; call 0x140005d8d
#FF7510# ; push qword ptr [rbp + 0x10]
#6A05# ; push 5
#E89F050000# ; call 0x140005d8d
#6A02# ; push 2
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C21000# ; ret 0x10
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F803# ; cmp rax, 3
#0F8F71000000# ; jg 0x140005886
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F807# ; cmp rax, 7
#0F8E2B000000# ; jle 0x14000584e
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C0A000000# ; jl 0x14000583b
#FF7518# ; push qword ptr [rbp + 0x18]
#6A41# ; push 0x41
#E852050000# ; call 0x140005d8d
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883E808# ; sub rax, 8
#48894510# ; mov qword ptr [rbp + 0x10], rax
#6A01# ; push 1
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C1E000000# ; jl 0x14000587a
#FF7518# ; push qword ptr [rbp + 0x18]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#48C1E003# ; shl rax, 3
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C040# ; add rax, 0x40
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E813050000# ; call 0x140005d8d
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#C9# ; leave
#C21800# ; ret 0x18
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F804# ; cmp rax, 4
#0F850A000000# ; jne 0x14000589e
#68E0000000# ; push 0xe0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F805# ; cmp rax, 5
#0F850A000000# ; jne 0x1400058b6
#68F0000000# ; push 0xf0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F806# ; cmp rax, 6
#0F850A000000# ; jne 0x1400058ce
#68D8000000# ; push 0xd8
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F807# ; cmp rax, 7
#0F850A000000# ; jne 0x1400058e6
#68D0000000# ; push 0xd0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C2B000000# ; jl 0x14000591f
#FF7518# ; push qword ptr [rbp + 0x18]
#6A48# ; push 0x48
#E88F040000# ; call 0x140005d8d
#FF7518# ; push qword ptr [rbp + 0x18]
#68F7000000# ; push 0xf7
#E882040000# ; call 0x140005d8d
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E86E040000# ; call 0x140005d8d
#6A03# ; push 3
#58# ; pop rax
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C5E000000# ; jl 0x14000599c
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4881C0E0000000# ; add rax, 0xe0
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#6A48# ; push 0x48
#E836040000# ; call 0x140005d8d
#FF7518# ; push qword ptr [rbp + 0x18]
#68D3000000# ; push 0xd3
#E829040000# ; call 0x140005d8d
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F80F# ; cmp rax, 0xf
#0F850B000000# ; jne 0x14000597d
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#E810040000# ; call 0x140005d8d
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F810# ; cmp rax, 0x10
#0F8511000000# ; jne 0x14000599c
#FF7518# ; push qword ptr [rbp + 0x18]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C008# ; add rax, 8
#50# ; push rax
#E8F1030000# ; call 0x140005d8d
#6A03# ; push 3
#58# ; pop rax
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F822# ; cmp rax, 0x22
#0F8438000000# ; je 0x140005a02
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C10000000# ; jl 0x1400059e8
#FF7518# ; push qword ptr [rbp + 0x18]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8A5030000# ; call 0x140005d8d
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBB7# ; jmp 0x1400059b9
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C21000# ; ret 0x10
*4E00 ; repeat 78 x 00
#4154# ; push r12
#4989E4# ; mov r12, rsp
#4883E4F0# ; and rsp, 0xfffffffffffffff0
#4883EC20# ; sub rsp, 0x20
#48FFD0# ; call rax
#4C89E4# ; mov rsp, r12
#415C# ; pop r12
#C3# ; ret
#488B0593030000# ; mov rax, qword ptr [rip + 0x393]
#4885C0# ; test rax, rax
#0F852F000000# ; jne 0x140005aad
#4831C9# ; xor rcx, rcx
#6800000008# ; push 0x8000000
#5A# ; pop rdx
#41B800300000# ; mov r8d, 0x3000
#41B904000000# ; mov r9d, 4
#488B0536040000# ; mov rax, qword ptr [rip + 0x436]
#E8B9FFFFFF# ; call 0x140005a58
#48890562030000# ; mov qword ptr [rip + 0x362], rax
#48890563030000# ; mov qword ptr [rip + 0x363], rax
#C3# ; ret
#4155# ; push r13
#4989CD# ; mov r13, rcx
#E8B6FFFFFF# ; call 0x140005a6e
#4983C507# ; add r13, 7
#4983E5F8# ; and r13, 0xfffffffffffffff8
#488B0549030000# ; mov rax, qword ptr [rip + 0x349]
#4889C2# ; mov rdx, rax
#4C01EA# ; add rdx, r13
#4889153C030000# ; mov qword ptr [rip + 0x33c], rdx
#415D# ; pop r13
#C3# ; ret
#4883F800# ; cmp rax, 0
#0F8415000000# ; je 0x140005af6
#4883F801# ; cmp rax, 1
#0F8415000000# ; je 0x140005b00
#4883F802# ; cmp rax, 2
#0F8415000000# ; je 0x140005b0a
#C3# ; ret
#B9F6FFFFFF# ; mov ecx, 0xfffffff6
#E90F000000# ; jmp 0x140005b0f
#B9F5FFFFFF# ; mov ecx, 0xfffffff5
#E905000000# ; jmp 0x140005b0f
#B9F4FFFFFF# ; mov ecx, 0xfffffff4
#488B05AA030000# ; mov rax, qword ptr [rip + 0x3aa]
#E83DFFFFFF# ; call 0x140005a58
#C3# ; ret
#53# ; push rbx
#56# ; push rsi
#57# ; push rdi
#4831C9# ; xor rcx, rcx
#488B0587030000# ; mov rax, qword ptr [rip + 0x387]
#E82AFFFFFF# ; call 0x140005a58
#4889C6# ; mov rsi, rax
#6800800000# ; push 0x8000
#59# ; pop rcx
#E872FFFFFF# ; call 0x140005aae
#4889C7# ; mov rdi, rax
#4889C2# ; mov rdx, rax
#31DB# ; xor ebx, ebx
#0FB606# ; movzx eax, byte ptr [rsi]
#83F820# ; cmp eax, 0x20
#0F8409000000# ; je 0x140005b59
#83F809# ; cmp eax, 9
#0F8506000000# ; jne 0x140005b5f
#4883C601# ; add rsi, 1
#EBE5# ; jmp 0x140005b44
#85C0# ; test eax, eax
#0F8488000000# ; je 0x140005bef
#83C301# ; add ebx, 1
#4531D2# ; xor r10d, r10d
#0FB606# ; movzx eax, byte ptr [rsi]
#85C0# ; test eax, eax
#0F8455000000# ; je 0x140005bcd
#83F822# ; cmp eax, 0x22
#0F8524000000# ; jne 0x140005ba5
#0FB64E01# ; movzx ecx, byte ptr [rsi + 1]
#83F922# ; cmp ecx, 0x22
#0F850D000000# ; jne 0x140005b9b
#408807# ; mov byte ptr [rdi], al
#4883C701# ; add rdi, 1
#4883C602# ; add rsi, 2
#EBD2# ; jmp 0x140005b6d
#4183F201# ; xor r10d, 1
#4883C601# ; add rsi, 1
#EBC8# ; jmp 0x140005b6d
#4585D2# ; test r10d, r10d
#0F8512000000# ; jne 0x140005bc0
#83F820# ; cmp eax, 0x20
#0F8416000000# ; je 0x140005bcd
#83F809# ; cmp eax, 9
#0F840D000000# ; je 0x140005bcd
#408807# ; mov byte ptr [rdi], al
#4883C701# ; add rdi, 1
#4883C601# ; add rsi, 1
#EBA0# ; jmp 0x140005b6d
#85C0# ; test eax, eax
#0F840E000000# ; je 0x140005be3
#31C0# ; xor eax, eax
#408807# ; mov byte ptr [rdi], al
#4883C701# ; add rdi, 1
#E961FFFFFF# ; jmp 0x140005b44
#408807# ; mov byte ptr [rdi], al
#4883C701# ; add rdi, 1
#E900000000# ; jmp 0x140005bef
#31C0# ; xor eax, eax
#408807# ; mov byte ptr [rdi], al
#89D8# ; mov eax, ebx
#5F# ; pop rdi
#5E# ; pop rsi
#5B# ; pop rbx
#C3# ; ret
#415A# ; pop r10
#59# ; pop rcx
#4152# ; push r10
#E86AFEFFFF# ; call 0x140005a6e
#4883F9FF# ; cmp rcx, -1
#0F840B000000# ; je 0x140005c19
#48890DFB010000# ; mov qword ptr [rip + 0x1fb], rcx
#4889C8# ; mov rax, rcx
#C3# ; ret
#488B05F0010000# ; mov rax, qword ptr [rip + 0x1f0]
#C3# ; ret
#415A# ; pop r10
#58# ; pop rax
#4152# ; push r10
#4889C2# ; mov rdx, rax
#83E201# ; and edx, 1
#0F851A000000# ; jne 0x140005c4c
#4883F802# ; cmp rax, 2
#0F8610000000# ; jbe 0x140005c4c
#4889C1# ; mov rcx, rax
#488B0552020000# ; mov rax, qword ptr [rip + 0x252]
#E80DFEFFFF# ; call 0x140005a58
#C3# ; ret
#31C0# ; xor eax, eax
#C3# ; ret
#4154# ; push r12
#4989E4# ; mov r12, rsp
#4883E4F0# ; and rsp, 0xfffffffffffffff0
#4883EC40# ; sub rsp, 0x40
#41B807000000# ; mov r8d, 7
#4531C9# ; xor r9d, r9d
#4489542420# ; mov dword ptr [rsp + 0x20], r10d
#44895C2428# ; mov dword ptr [rsp + 0x28], r11d
#48C744243000000000# ; mov qword ptr [rsp + 0x30], 0
#488B0521020000# ; mov rax, qword ptr [rip + 0x221]
#48FFD0# ; call rax
#4C89E4# ; mov rsp, r12
#415C# ; pop r12
#C3# ; ret
#415A# ; pop r10
#415D# ; pop r13
#5F# ; pop rdi
#4152# ; push r10
#53# ; push rbx
#4889F9# ; mov rcx, rdi
#488B051E020000# ; mov rax, qword ptr [rip + 0x21e]
#E8B9FDFFFF# ; call 0x140005a58
#83F8FF# ; cmp eax, -1
#0F8439000000# ; je 0x140005ce1
#83E010# ; and eax, 0x10
#0F8430000000# ; je 0x140005ce1
#6810040000# ; push 0x410
#59# ; pop rcx
#E8F2FDFFFF# ; call 0x140005aae
#4889C3# ; mov rbx, rax
#48C70344495200# ; mov qword ptr [rbx], 0x524944
#488D5310# ; lea rdx, [rbx + 0x10]
#0FB607# ; movzx eax, byte ptr [rdi]
#8802# ; mov byte ptr [rdx], al
#4883C701# ; add rdi, 1
#4883C201# ; add rdx, 1
#85C0# ; test eax, eax
#75EF# ; jne 0x140005cca
#488D4301# ; lea rax, [rbx + 1]
#5B# ; pop rbx
#C3# ; ret
#4889F9# ; mov rcx, rdi
#BA00000080# ; mov edx, 0x80000000
#4983FD02# ; cmp r13, 2
#0F8505000000# ; jne 0x140005cf8
#BA000000C0# ; mov edx, 0xc0000000
#41BA03000000# ; mov r10d, 3
#41BB80000000# ; mov r11d, 0x80
#E846FFFFFF# ; call 0x140005c4f
#5B# ; pop rbx
#C3# ; ret
#415A# ; pop r10
#59# ; pop rcx
#4152# ; push r10
#BA000000C0# ; mov edx, 0xc0000000
#41BA02000000# ; mov r10d, 2
#41BB80000000# ; mov r11d, 0x80
#E929FFFFFF# ; jmp 0x140005c4f
#415A# ; pop r10
#58# ; pop rax
#4152# ; push r10
#E8A7FDFFFF# ; call 0x140005ad7
#4889C1# ; mov rcx, rax
#488D15E2000000# ; lea rdx, [rip + 0xe2]
#41B801000000# ; mov r8d, 1
#4C8D0DD1000000# ; lea r9, [rip + 0xd1]
#41C70100000000# ; mov dword ptr [r9], 0
#4154# ; push r12
#4989E4# ; mov r12, rsp
#4883E4F0# ; and rsp, 0xfffffffffffffff0
#4883EC30# ; sub rsp, 0x30
#48C744242000000000# ; mov qword ptr [rsp + 0x20], 0
#488B055D010000# ; mov rax, qword ptr [rip + 0x15d]
#48FFD0# ; call rax
#4C89E4# ; mov rsp, r12
#415C# ; pop r12
#8B059F000000# ; mov eax, dword ptr [rip + 0x9f]
#85C0# ; test eax, eax
#0F8409000000# ; je 0x140005d8a
#31C0# ; xor eax, eax
#8A0593000000# ; mov al, byte ptr [rip + 0x93]
#C3# ; ret
#31C0# ; xor eax, eax
#C3# ; ret
#415A# ; pop r10
#5A# ; pop rdx
#58# ; pop rax
#4152# ; push r10
#881583000000# ; mov byte ptr [rip + 0x83], dl
#E839FDFFFF# ; call 0x140005ad7
#4889C1# ; mov rcx, rax
#488D1574000000# ; lea rdx, [rip + 0x74]
#41B801000000# ; mov r8d, 1
#4C8D0D63000000# ; lea r9, [rip + 0x63]
#41C70100000000# ; mov dword ptr [r9], 0
#4154# ; push r12
#4989E4# ; mov r12, rsp
#4883E4F0# ; and rsp, 0xfffffffffffffff0
#4883EC30# ; sub rsp, 0x30
#48C744242000000000# ; mov qword ptr [rsp + 0x20], 0
#488B05FF000000# ; mov rax, qword ptr [rip + 0xff]
#48FFD0# ; call rax
#4C89E4# ; mov rsp, r12
#415C# ; pop r12
#31C0# ; xor eax, eax
#8A0533000000# ; mov al, byte ptr [rip + 0x33]
#C3# ; ret
#415A# ; pop r10
#5A# ; pop rdx
#6A01# ; push 1
#52# ; push rdx
#4152# ; push r10
#EB99# ; jmp 0x140005d8d
#415A# ; pop r10
#59# ; pop rcx
#4152# ; push r10
#488B05A8000000# ; mov rax, qword ptr [rip + 0xa8]
#E853FCFFFF# ; call 0x140005a58
#F4# ; hlt
*1A00 ; repeat 26 x 00
#485E# ; pop rsi
*0A00 ; repeat 10 x 00
#E85E000098# ; call 0xd8005e8f
#5E# ; pop rsi
*1600 ; repeat 22 x 00
#F65E00# ; neg byte ptr [rsi]
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#00045F# ; add byte ptr [rdi + rbx*2], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#125F00# ; adc bl, byte ptr [rdi]
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0020# ; add byte ptr [rax], ah
#5F# ; pop rdi
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#325F00# ; xor bl, byte ptr [rdi]
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#00485F# ; add byte ptr [rax + 0x5f], cl
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#58# ; pop rax
#5F# ; pop rdi
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#645F# ; pop rdi
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#745F# ; je 0x140005ee9
*0E00 ; repeat 14 x 00
#F65E00# ; neg byte ptr [rsi]
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#00045F# ; add byte ptr [rdi + rbx*2], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#125F00# ; adc bl, byte ptr [rdi]
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0020# ; add byte ptr [rax], ah
#5F# ; pop rdi
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#325F00# ; xor bl, byte ptr [rdi]
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#00485F# ; add byte ptr [rax + 0x5f], cl
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#58# ; pop rax
#5F# ; pop rdi
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#645F# ; pop rdi
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#0000# ; add byte ptr [rax], al
#745F# ; je 0x140005f39
*0E00 ; repeat 14 x 00
'KERNEL32.dll' #00# ; text
#0000# ; add byte ptr [rax], al
#00436C# ; add byte ptr [rbx + 0x6c], al
'oseHandle' #00# ; text
#0000# ; add byte ptr [rax], al
'CreateFileA' #00# ; text
#0000# ; add byte ptr [rax], al
'ExitProcess' #00# ; text
#0000# ; add byte ptr [rax], al
'GetCommandLineA' #00# ; text
#0000# ; add byte ptr [rax], al
'GetFileAttributesA' #00# ; text
#0000# ; add byte ptr [rax], al
#004765# ; add byte ptr [rdi + 0x65], al
'tStdHandle' #00# ; text
#0000# ; add byte ptr [rax], al
#005265# ; add byte ptr [rdx + 0x65], dl
'adFile' #00# ; text
#0000# ; add byte ptr [rax], al
#005669# ; add byte ptr [rsi + 0x69], dl
'rtualAlloc' #00# ; text
#0000# ; add byte ptr [rax], al
#005772# ; add byte ptr [rdi + 0x72], dl
'iteFile' #00# ; text
*8000 ; repeat 128 x 00

!
