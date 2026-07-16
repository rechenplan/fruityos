; Seed Orgasm for Linux ELF64
; Petit emits the bytes exactly as written below.
; Each comment describes the adjacent instruction, string, header field, or table.

; ---- ELF64 header ----
#7F454C46020101000000000000000000# ; ELF64 header
#02003E00010000008500400000000000# ; ELF64 header
#40000000000000000000000000000000# ; ELF64 header
#00000000400038000100000000000000# ; ELF64 header

; ---- ELF64 program header ----
#01000000070000000000000000000000# ; ELF64 program header
#00004000000000000000400000000000# ; ELF64 program header
#58590000000000005859000000000000# ; ELF64 program header
#0010000000000000# ; ELF64 program header

'linux-x86_64' #00# ; text
#488D05ECFFFFFF# ; lea rax, [rip - 0x14]
#488905F5570000# ; mov qword ptr [rip + 0x57f5], rax
#488B0424# ; mov rax, qword ptr [rsp]
#488B542408# ; mov rdx, qword ptr [rsp + 8]
#50# ; push rax
#52# ; push rdx
#E8FB000000# ; call 0x40019e
#50# ; push rax
#E84E580000# ; call 0x4058f7
#C8000000# ; enter 0, 0
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F840E000000# ; je 0x4000cb
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBE2# ; jmp 0x4000ad
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
#0F8D96000000# ; jge 0x400196
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#E818580000# ; call 0x405922
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8F37000000# ; jg 0x400153
#E90F000000# ; jmp 0x400130
'error opening ' #00# ; text
#488D05EAFFFFFF# ; lea rax, [rip - 0x16]
#50# ; push rax
#E8750A0000# ; call 0x400bb2
#FF7528# ; push qword ptr [rbp + 0x28]
#E86D0A0000# ; call 0x400bb2
#6A0A# ; push 0xa
#E8E2570000# ; call 0x40592e
#6A01# ; push 1
#E8A4570000# ; call 0x4058f7
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7510# ; push qword ptr [rbp + 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E851490000# ; call 0x404ab5
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#E862570000# ; call 0x4058db
#FF7528# ; push qword ptr [rbp + 0x28]
#E828FFFFFF# ; call 0x4000a9
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#E959FFFFFF# ; jmp 0x4000ef
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
#0F8D4F000000# ; jge 0x40021d
#E92F000000# ; jmp 0x400202
'usage: orgasm input.asm [input.asm ...] output' #00# ; text
#488D05CAFFFFFF# ; lea rax, [rip - 0x36]
#50# ; push rax
#E8A3090000# ; call 0x400bb2
#6A0A# ; push 0xa
#E818570000# ; call 0x40592e
#6A01# ; push 1
#E8DA560000# ; call 0x4058f7
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#E8A7560000# ; call 0x4058d0
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4881C000000800# ; add rax, 0x80000
#50# ; push rax
#E892560000# ; call 0x4058d0
#6A00# ; push 0
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4881F800200000# ; cmp rax, 0x2000
#0F8D2A000000# ; jge 0x400280
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
#EBC5# ; jmp 0x400245
#FF7510# ; push qword ptr [rbp + 0x10]
#E821FEFFFF# ; call 0x4000a9
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
#0F8D1A000000# ; jge 0x4002cc
#FF75E0# ; push qword ptr [rbp - 0x20]
#E8EFFDFFFF# ; call 0x4000a9
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBCF# ; jmp 0x40029b
#FF75E0# ; push qword ptr [rbp - 0x20]
#E812560000# ; call 0x4058e6
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F800# ; cmp rax, 0
#0F8F36000000# ; jg 0x40031c
#E916000000# ; jmp 0x400301
'error creating output' #00# ; text
#488D05E3FFFFFF# ; lea rax, [rip - 0x1d]
#50# ; push rax
#E8A4080000# ; call 0x400bb2
#6A0A# ; push 0xa
#E819560000# ; call 0x40592e
#6A01# ; push 1
#E8DB550000# ; call 0x4058f7
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E8A0FDFFFF# ; call 0x4000d7
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
#E881FDFFFF# ; call 0x4000d7
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF75D0# ; push qword ptr [rbp - 0x30]
#488B45C8# ; mov rax, qword ptr [rbp - 0x38]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8D29000000# ; jge 0x400394
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
#E849FDFFFF# ; call 0x4000d7
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#EBC6# ; jmp 0x40035a
#FF75E8# ; push qword ptr [rbp - 0x18]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E802# ; sub rax, 2
#50# ; push rax
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75F8# ; push qword ptr [rbp - 8]
#E82CFDFFFF# ; call 0x4000d7
#FF75D8# ; push qword ptr [rbp - 0x28]
#E828550000# ; call 0x4058db
#31C0# ; xor eax, eax
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#E969010000# ; jmp 0x40052b
'ret$syscall$push$pop$mul$div$neg$not$add$sub$and$xor$or$test$cmp$shl$shr$sete$setne$setz$setnz$setg$setl$setge$setle$mov$lea$call$jmp$jnz$jz$db$extern$global$bits$qword$rax$rcx$rdx$rbx$rsp$rbp$rsi$rdi$r8$r9$r10$cl$dl$,$[$]$-$+$org$al$int$jne$jbe$je$jb$jc$align$dq$dd$dw$imul$movzx$byte$dword$word$hlt$cli$sti$iretq$retfq$lgdt$lidt$ltr$in$out$equ$jge$jg$jle$jl$' #00# ; text
#488D0590FEFFFF# ; lea rax, [rip - 0x170]
#C9# ; leave
#C3# ; ret
#C8000000# ; enter 0, 0
#E902000000# ; jmp 0x40053f
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
#E902000000# ; jmp 0x400561
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
#E902000000# ; jmp 0x40058e
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
#E902000000# ; jmp 0x4005b0
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
#E902000000# ; jmp 0x4005d2
#7A00# ; jp 0x4005d2
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
#E902000000# ; jmp 0x4005f4
#6100488D05F7FFFFFF0FB60050488B45# ; data
#105F31# ; adc byte ptr [rdi + 0x31], bl
#D24839# ; ror byte ptr [rax + 0x39], cl
#F8# ; clc
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#50# ; push rax
#E902000000# ; jmp 0x40061a
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
#E902000000# ; jmp 0x40063c
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
#E90B000000# ; jmp 0x40067e
',[]-+*&|()' #00# ; text
#488D05EEFFFFFF# ; lea rax, [rip - 0x12]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F842B000000# ; je 0x4006c4
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x4006b6
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBC5# ; jmp 0x400689
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
#E8D3FCFFFF# ; call 0x4003b9
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F8406010000# ; je 0x400800
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
#0F841A000000# ; je 0x400762
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883C001# ; add rax, 1
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883C001# ; add rax, 1
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#EBA8# ; jmp 0x40070a
#E902000000# ; jmp 0x400769
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
#0F8408000000# ; je 0x4007b2
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x4007b9
#2400# ; and al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F840E000000# ; je 0x4007e3
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBCF# ; jmp 0x4007b2
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E9EAFEFFFF# ; jmp 0x4006ea
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
#0F8473030000# ; je 0x400bab
#E902000000# ; jmp 0x40083f
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
#0F856E000000# ; jne 0x4008ed
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
#0F8420000000# ; je 0x4008da
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBAC# ; jmp 0x400886
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#4883E801# ; sub rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF75F8# ; push qword ptr [rbp - 8]
#E88EFCFFFF# ; call 0x400583
#4885C0# ; test rax, rax
#0F84B3000000# ; je 0x4009b1
#E902000000# ; jmp 0x400905
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
#E902000000# ; jmp 0x400927
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
#E8EAFBFFFF# ; call 0x400534
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E830FCFFFF# ; call 0x400583
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8435000000# ; je 0x40099d
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
#E961FFFFFF# ; jmp 0x4008fe
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
#0F858A000000# ; jne 0x400a49
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
#0F8427000000# ; je 0x400a20
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
#EBC4# ; jmp 0x4009e4
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
#E8E3FAFFFF# ; call 0x400534
#4885C0# ; test rax, rax
#0F8464000000# ; je 0x400abe
#FF75F8# ; push qword ptr [rbp - 8]
#E821FBFFFF# ; call 0x400583
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E8C9FAFFFF# ; call 0x400534
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8432000000# ; je 0x400aaa
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
#EBB0# ; jmp 0x400a5a
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
#E890FBFFFF# ; call 0x40066a
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8429000000# ; je 0x400b10
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
#E902000000# ; jmp 0x400b17
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
#E902000000# ; jmp 0x400b39
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
#0F843A000000# ; je 0x400b9a
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
#E979FCFFFF# ; jmp 0x400824
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
#0F8416000000# ; je 0x400be6
#FF75F8# ; push qword ptr [rbp - 8]
#E8564D0000# ; call 0x40592e
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBD6# ; jmp 0x400bbc
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
#0F8532000000# ; jne 0x400c3b
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F800# ; cmp rax, 0
#0F8507000000# ; jne 0x400c21
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
#EBB5# ; jmp 0x400bf0
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
#0F841A000000# ; je 0x400c9e
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883C001# ; add rax, 1
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#EBA8# ; jmp 0x400c46
#E902000000# ; jmp 0x400ca5
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
#E905010000# ; jmp 0x400df9
'rax$eax$ax$al$rcx$ecx$cx$cl$rdx$edx$dx$dl$rbx$ebx$bx$bl$rsp$esp$sp$spl$rbp$ebp$bp$bpl$rsi$esi$si$sil$rdi$edi$di$dil$r8$r8d$r8w$r8b$r9$r9d$r9w$r9b$r10$r10d$r10w$r10b$r11$r11d$r11w$r11b$r12$r12d$r12w$r12b$r13$r13d$r13w$r13b$r14$r14d$r14w$r14b$r15$r15d$r15w$r15b$' #00# ; text
#488D05F4FEFFFF# ; lea rax, [rip - 0x10c]
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F846B000000# ; je 0x400e7f
#FF7510# ; push qword ptr [rbp + 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E823FEFFFF# ; call 0x400c42
#4885C0# ; test rax, rax
#0F840C000000# ; je 0x400e34
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48C1E802# ; shr rax, 2
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x400e3b
#2400# ; and al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F840E000000# ; je 0x400e65
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBCF# ; jmp 0x400e34
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EB85# ; jmp 0x400e04
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
#0F840E000000# ; je 0x400eb7
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBDE# ; jmp 0x400e95
#E902000000# ; jmp 0x400ebe
#6200488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x400ee1
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x400ee8
#7700# ; ja 0x400ee8
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x400f0b
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x400f12
#6400488D# ; add byte ptr fs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x400f35
#6A04# ; push 4
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x400f3c
#6500488D# ; add byte ptr gs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x400f5f
#6A04# ; push 4
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x400f66
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
#0F8407000000# ; je 0x400fb0
#6A01# ; push 1
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x400fb7
#6900488D05F7# ; imul eax, dword ptr [rax], 0xf7058d48
#FFFFFF0FB60050488B45F80FB6005F31# ; data
#D24839# ; ror byte ptr [rax + 0x39], cl
#F8# ; clc
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x400fdc
#7000# ; jo 0x400fdc
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
#E902000000# ; jmp 0x401001
#7800# ; js 0x401001
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
#0F8407000000# ; je 0x401053
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
#E902000000# ; jmp 0x401080
#7300# ; jae 0x401080
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
#0F840A000000# ; je 0x4010b8
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x4010bf
#6500488D# ; add byte ptr gs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x4010e2
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x4010e9
#7300# ; jae 0x4010e9
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x40110c
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x401113
#6400488D# ; add byte ptr fs:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x401136
#6A03# ; push 3
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x40113d
#6600488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x401160
#6A04# ; push 4
#58# ; pop rax
#C9# ; leave
#C20800# ; ret 8
#E902000000# ; jmp 0x401167
#6700488D# ; add byte ptr [eax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x40118a
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
#0F8C14000000# ; jl 0x4011ba
#FF7518# ; push qword ptr [rbp + 0x18]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4881E0FF000000# ; and rax, 0xff
#50# ; push rax
#E88A470000# ; call 0x405944
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
#0F8D25000000# ; jge 0x401201
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8ADFFFFFF# ; call 0x401194
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#48C1E808# ; shr rax, 8
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBCA# ; jmp 0x4011cb
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#6A40# ; push 0x40
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F808# ; cmp rax, 8
#0F850C000000# ; jne 0x40122e
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C808# ; or rax, 8
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x401248
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C804# ; or rax, 4
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x401262
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
#0F8412000000# ; je 0x401297
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F8# ; push qword ptr [rbp - 8]
#E804FFFFFF# ; call 0x401194
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
#0F8517000000# ; jne 0x4012cd
#FF7530# ; push qword ptr [rbp + 0x30]
#6A66# ; push 0x66
#E8D4FEFFFF# ; call 0x401194
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
#E8E7FEFFFF# ; call 0x401209
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E85AFEFFFF# ; call 0x401194
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
#E820FEFFFF# ; call 0x401194
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
#0F854C020000# ; jne 0x4015f1
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
#0F84D8000000# ; je 0x4014dd
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
#0F842B000000# ; je 0x40146a
#FF7538# ; push qword ptr [rbp + 0x38]
#6A6A# ; push 0x6a
#E84BFDFFFF# ; call 0x401194
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#E83CFDFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E928000000# ; jmp 0x401492
#FF7538# ; push qword ptr [rbp + 0x38]
#6A68# ; push 0x68
#E820FDFFFF# ; call 0x401194
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A04# ; push 4
#E83CFDFFFF# ; call 0x4011c1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F808# ; cmp rax, 8
#0F8C17000000# ; jl 0x4014b7
#FF7538# ; push qword ptr [rbp + 0x38]
#6A41# ; push 0x41
#E8EAFCFFFF# ; call 0x401194
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
#E8C4FCFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x401502
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E89FFCFFFF# ; call 0x401194
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
#E8CBFCFFFF# ; call 0x401209
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F801# ; cmp rax, 1
#0F852E000000# ; jne 0x401587
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#50# ; push rax
#68B0000000# ; push 0xb0
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E81FFCFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E929000000# ; jmp 0x4015b0
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883E007# ; and rax, 7
#50# ; push rax
#68B8000000# ; push 0xb8
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E8F1FBFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F801# ; cmp rax, 1
#0F8518000000# ; jne 0x4015d6
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CBFBFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7528# ; push qword ptr [rbp + 0x28]
#E8DDFBFFFF# ; call 0x4011c1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#E902000000# ; jmp 0x4015f8
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7530# ; push qword ptr [rbp + 0x30]
#E908000000# ; jmp 0x401613
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
#0F8517000000# ; jne 0x40164e
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E853FBFFFF# ; call 0x401194
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
#E8A9FBFFFF# ; call 0x401209
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
#0F841F000000# ; je 0x4016c6
#FF7538# ; push qword ptr [rbp + 0x38]
#6883000000# ; push 0x83
#E8E0FAFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E91A000000# ; jmp 0x4016e0
#FF7538# ; push qword ptr [rbp + 0x38]
#6881000000# ; push 0x81
#E8C1FAFFFF# ; call 0x401194
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
#E88BFAFFFF# ; call 0x401194
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
#0F8418000000# ; je 0x401768
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#E839FAFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F851A000000# ; jne 0x401790
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A02# ; push 2
#E83EFAFFFF# ; call 0x4011c1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C23000# ; ret 0x30
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A04# ; push 4
#E824FAFFFF# ; call 0x4011c1
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
#0F8407000000# ; je 0x4017ed
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
#0F8407000000# ; je 0x40182e
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
#E854FFFFFF# ; call 0x4017aa
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
#E811F9FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F804# ; cmp rax, 4
#0F8517000000# ; jne 0x4018b5
#FF7528# ; push qword ptr [rbp + 0x28]
#6A24# ; push 0x24
#E8ECF8FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F801# ; cmp rax, 1
#0F8518000000# ; jne 0x4018db
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8C6F8FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F802# ; cmp rax, 2
#0F851A000000# ; jne 0x401903
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#E8CBF8FFFF# ; call 0x4011c1
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
#E883FEFFFF# ; call 0x4017aa
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x401950
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E851F8FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F808# ; cmp rax, 8
#0F850C000000# ; jne 0x40196a
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C808# ; or rax, 8
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x401984
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C804# ; or rax, 4
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B050D3F0000# ; mov rax, qword ptr [rip + 0x3f0d]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x4019a1
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C802# ; or rax, 2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F808# ; cmp rax, 8
#0F8C0C000000# ; jl 0x4019bb
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C801# ; or rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A04# ; push 4
#58# ; pop rax
#50# ; push rax
#488B05D23E0000# ; mov rax, qword ptr [rip + 0x3ed2]
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
#0F8418000000# ; je 0x401a52
#FF7538# ; push qword ptr [rbp + 0x38]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E84FF7FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E837F7FFFF# ; call 0x401194
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
#E804F7FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883E007# ; and rax, 7
#50# ; push rax
#488B05E83D0000# ; mov rax, qword ptr [rip + 0x3de8]
#4883E007# ; and rax, 7
#48C1E003# ; shl rax, 3
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#50# ; push rax
#E8D2F6FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F801# ; cmp rax, 1
#0F8518000000# ; jne 0x401af5
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8ACF6FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F802# ; cmp rax, 2
#0F851A000000# ; jne 0x401b1d
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#E8B1F6FFFF# ; call 0x4011c1
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
#488B05623D0000# ; mov rax, qword ptr [rip + 0x3d62]
#4883F800# ; cmp rax, 0
#0F8C1B000000# ; jl 0x401b5b
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8B4FDFFFF# ; call 0x40190b
#C9# ; leave
#C23000# ; ret 0x30
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8D18000000# ; jge 0x401b81
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8C1000000# ; call 0x401c3e
#C9# ; leave
#C23000# ; ret 0x30
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x401ba6
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E8FBF5FFFF# ; call 0x401194
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
#E80EF6FFFF# ; call 0x401209
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E881F5FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E804FCFFFF# ; call 0x401835
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
#0F8517000000# ; jne 0x401c6d
#FF7530# ; push qword ptr [rbp + 0x30]
#6A66# ; push 0x66
#E834F5FFFF# ; call 0x401194
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
#E860F5FFFF# ; call 0x401209
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E8D3F4FFFF# ; call 0x401194
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
#E8A9F4FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A25# ; push 0x25
#E892F4FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A04# ; push 4
#E8A5F4FFFF# ; call 0x4011c1
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
#0F841F000000# ; je 0x401de3
#FF7528# ; push qword ptr [rbp + 0x28]
#68EB000000# ; push 0xeb
#E8C3F3FFFF# ; call 0x401194
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F8# ; push qword ptr [rbp - 8]
#E8B8F3FFFF# ; call 0x401194
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8A6F3FFFF# ; call 0x401194
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E805# ; sub rax, 5
#50# ; push rax
#6A04# ; push 4
#E8B9F3FFFF# ; call 0x4011c1
#6A05# ; push 5
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F802# ; cmp rax, 2
#0F8517000000# ; jne 0x401e3e
#FF7538# ; push qword ptr [rbp + 0x38]
#6A66# ; push 0x66
#E863F3FFFF# ; call 0x401194
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
#E88FF3FFFF# ; call 0x401209
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E802F3FFFF# ; call 0x401194
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
#E8DCF2FFFF# ; call 0x401194
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
#E8DBF2FFFF# ; call 0x4011c1
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
#0F8425000000# ; je 0x401fa0
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#6A70# ; push 0x70
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E806F2FFFF# ; call 0x401194
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F8# ; push qword ptr [rbp - 8]
#E8FBF1FFFF# ; call 0x401194
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#6A0F# ; push 0xf
#E8EAF1FFFF# ; call 0x401194
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#6880000000# ; push 0x80
#58# ; pop rax
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E8D4F1FFFF# ; call 0x401194
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E806# ; sub rax, 6
#50# ; push rax
#6A04# ; push 4
#E8E7F1FFFF# ; call 0x4011c1
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
#E8FBF1FFFF# ; call 0x401209
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#6A0F# ; push 0xf
#E86FF1FFFF# ; call 0x401194
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
#E84CF1FFFF# ; call 0x401194
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
#E823F1FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C21800# ; ret 0x18
#C8000000# ; enter 0, 0
#E907000000# ; jmp 0x402096
'error ' #00# ; text
#488D05F2FFFFFF# ; lea rax, [rip - 0xe]
#50# ; push rax
#E80FEBFFFF# ; call 0x400bb2
#488B051E380000# ; mov rax, qword ptr [rip + 0x381e]
#50# ; push rax
#E802EBFFFF# ; call 0x400bb2
#6A0A# ; push 0xa
#E877380000# ; call 0x40592e
#6A01# ; push 1
#E839380000# ; call 0x4058f7
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
#0F840E000000# ; je 0x402101
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883C001# ; add rax, 1
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#EBE2# ; jmp 0x4020e3
#E902000000# ; jmp 0x402108
#6200488D05F7FFFFFF0FB60050488B45# ; data
#D84883# ; fmul dword ptr [rax - 0x7d]
#E8010FB600# ; call 0xf6301f
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
#0F8407000000# ; je 0x402150
#6A02# ; push 2
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E902000000# ; jmp 0x402162
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
#E902000000# ; jmp 0x40218b
#7800# ; js 0x40218b
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
#E902000000# ; jmp 0x4021b8
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
#0F841E000000# ; je 0x4021fd
#6A10# ; push 0x10
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C002# ; add rax, 2
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E902000000# ; jmp 0x402204
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
#E902000000# ; jmp 0x402226
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
#E902000000# ; jmp 0x40224c
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
#E902000000# ; jmp 0x40226e
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
#E89FE2FFFF# ; call 0x400534
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F8441010000# ; je 0x4023e7
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
#E902000000# ; jmp 0x4022c8
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
#0F8408000000# ; je 0x40230f
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#C9# ; leave
#C20800# ; ret 8
#FF75F8# ; push qword ptr [rbp - 8]
#E81DE2FFFF# ; call 0x400534
#4885C0# ; test rax, rax
#0F8423000000# ; je 0x402343
#E902000000# ; jmp 0x402327
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E969000000# ; jmp 0x4023ac
#E902000000# ; jmp 0x40234a
#6100488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8C27000000# ; jl 0x40238a
#E902000000# ; jmp 0x40236a
#6100488D05F7FFFFFF0FB60050488B45# ; data
#F8# ; clc
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883C00A# ; add rax, 0xa
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E922000000# ; jmp 0x4023ac
#E902000000# ; jmp 0x402391
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
#E916FEFFFF# ; jmp 0x4021fd
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
#0F8443000000# ; je 0x402455
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F83A# ; cmp rax, 0x3a
#0F8508000000# ; jne 0x402428
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
#EBA8# ; jmp 0x4023fd
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
#0F8438000000# ; je 0x4024c6
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
#EBA2# ; jmp 0x402468
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
#E8D1FEFFFF# ; call 0x4023ef
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4881F800200000# ; cmp rax, 0x2000
#0F8D90000000# ; jge 0x4025c3
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
#0F850A000000# ; jne 0x402572
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#C9# ; leave
#C21000# ; ret 0x10
#FF7518# ; push qword ptr [rbp + 0x18]
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C008# ; add rax, 8
#50# ; push rax
#E8DAFEFFFF# ; call 0x40245d
#4885C0# ; test rax, rax
#0F8413000000# ; je 0x40259f
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48890529330000# ; mov qword ptr [rip + 0x3329], rax
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
#E95FFFFFFF# ; jmp 0x402522
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
#E804FEFFFF# ; call 0x4023ef
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4881F800200000# ; cmp rax, 0x2000
#0F8D12010000# ; jge 0x402712
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
#0F85C1000000# ; jne 0x4026ee
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
#0F843C000000# ; je 0x4026b8
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F83A# ; cmp rax, 0x3a
#0F8420000000# ; je 0x4026aa
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
#EB89# ; jmp 0x402641
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F840# ; cmp rax, 0x40
#0F8D21000000# ; jge 0x4026e7
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
#EBD1# ; jmp 0x4026b8
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
#E9DDFEFFFF# ; jmp 0x4025ef
#E86FF9FFFF# ; call 0x402086
#31C0# ; xor eax, eax
#C9# ; leave
#C21800# ; ret 0x18
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8D8FDFFFF# ; call 0x402504
#4883F800# ; cmp rax, 0
#0F8C10000000# ; jl 0x402746
#488B0583310000# ; mov rax, qword ptr [rip + 0x3183]
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#31C0# ; xor eax, eax
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#FF7510# ; push qword ptr [rbp + 0x10]
#E889E5FFFF# ; call 0x400ce1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F800# ; cmp rax, 0
#0F8D05000000# ; jge 0x40276f
#E817F9FFFF# ; call 0x402086
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C20800# ; ret 8
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E884E0FFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8416000000# ; je 0x4027ae
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F80A# ; cmp rax, 0xa
#0F8405000000# ; je 0x4027ae
#E8D8F8FFFF# ; call 0x402086
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E845E0FFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8417000000# ; je 0x4027ee
#FF7510# ; push qword ptr [rbp + 0x10]
#E8ECDEFFFF# ; call 0x4006cb
#4883F831# ; cmp rax, 0x31
#0F8405000000# ; je 0x4027ee
#E898F8FFFF# ; call 0x402086
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C21000# ; ret 0x10
#C8000000# ; enter 0, 0
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E872FFFFFF# ; call 0x402777
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EA2D0000# ; call 0x4055fe
#C9# ; leave
#C22000# ; ret 0x20
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8DDDFFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E889F8FFFF# ; call 0x4020c2
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E82FFFFFFF# ; call 0x402777
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#E8762D0000# ; call 0x4055cd
#C9# ; leave
#C21800# ; ret 0x18
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E892DFFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8ABDCFFFF# ; call 0x400534
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
#0F8468000000# ; je 0x402912
#FF7510# ; push qword ptr [rbp + 0x10]
#E810F8FFFF# ; call 0x4020c2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F87F# ; cmp rax, 0x7f
#0F8F26000000# ; jg 0x4028ea
#FF7520# ; push qword ptr [rbp + 0x20]
#6A6A# ; push 0x6a
#E8C6E8FFFF# ; call 0x401194
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E8B7E8FFFF# ; call 0x401194
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#FF7520# ; push qword ptr [rbp + 0x20]
#6A68# ; push 0x68
#E8A0E8FFFF# ; call 0x401194
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A04# ; push 4
#E8BCE8FFFF# ; call 0x4011c1
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#FF7510# ; push qword ptr [rbp + 0x10]
#E832FEFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E84EFEFFFF# ; call 0x402777
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#E83C2D0000# ; call 0x405677
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
#E89EDEFFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E853DDFFFF# ; call 0x4006cb
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
#0F841B010000# ; je 0x402afb
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F844# ; cmp rax, 0x44
#0F8507000000# ; jne 0x4029f5
#6A01# ; push 1
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F846# ; cmp rax, 0x46
#0F8507000000# ; jne 0x402a0a
#6A02# ; push 2
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F845# ; cmp rax, 0x45
#0F8507000000# ; jne 0x402a1f
#6A04# ; push 4
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#4883F823# ; cmp rax, 0x23
#0F8507000000# ; jne 0x402a34
#6A08# ; push 8
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CBDDFFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E880DCFFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F8405000000# ; je 0x402a5a
#E82CF6FFFF# ; call 0x402086
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A8150000# ; call 0x404010
#488B05412E0000# ; mov rax, qword ptr [rip + 0x2e41]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E83EFDFFFF# ; call 0x4027b6
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E883DDFFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B9FCFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#4883F80E# ; cmp rax, 0xe
#0F8556000000# ; jne 0x402afb
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F801# ; cmp rax, 1
#0F8524000000# ; jne 0x402ad7
#FF7528# ; push qword ptr [rbp + 0x28]
#6A38# ; push 0x38
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05CB2D0000# ; mov rax, qword ptr [rip + 0x2dcb]
#50# ; push rax
#488B05D32D0000# ; mov rax, qword ptr [rip + 0x2dd3]
#50# ; push rax
#E852F0FFFF# ; call 0x401b25
#C9# ; leave
#C22800# ; ret 0x28
#FF7528# ; push qword ptr [rbp + 0x28]
#6A39# ; push 0x39
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05A72D0000# ; mov rax, qword ptr [rip + 0x2da7]
#50# ; push rax
#488B05AF2D0000# ; mov rax, qword ptr [rip + 0x2daf]
#50# ; push rax
#E82EF0FFFF# ; call 0x401b25
#C9# ; leave
#C22800# ; ret 0x28
#FF7518# ; push qword ptr [rbp + 0x18]
#E849FCFFFF# ; call 0x40274c
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E87AE3FFFF# ; call 0x400e89
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E898FCFFFF# ; call 0x4027b6
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8DDDCFFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8F6D9FFFF# ; call 0x400534
#50# ; push rax
#E902000000# ; jmp 0x402b46
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F31D2# ; data
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#5F# ; pop rdi
#4809F8# ; or rax, rdi
#4885C0# ; test rax, rax
#0F84AD000000# ; je 0x402c1d
#E902000000# ; jmp 0x402b77
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F4839# ; data
#F8# ; clc
#0F8528000000# ; jne 0x402bbb
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E86CDCFFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E818F5FFFF# ; call 0x4020c2
#50# ; push rax
#6A00# ; push 0
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E90C000000# ; jmp 0x402bc7
#FF7518# ; push qword ptr [rbp + 0x18]
#E8FFF4FFFF# ; call 0x4020c2
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#E902000000# ; jmp 0x402bce
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7530# ; push qword ptr [rbp + 0x30]
#E908000000# ; jmp 0x402be9
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
#E870E7FFFF# ; call 0x401389
#C9# ; leave
#C22800# ; ret 0x28
#FF7518# ; push qword ptr [rbp + 0x18]
#E827FBFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E843FBFFFF# ; call 0x402777
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#4883F80D# ; cmp rax, 0xd
#0F851A000000# ; jne 0x402c60
#FF7528# ; push qword ptr [rbp + 0x28]
#6885000000# ; push 0x85
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E842E6FFFF# ; call 0x40129e
#C9# ; leave
#C22800# ; ret 0x28
#E902000000# ; jmp 0x402c67
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7530# ; push qword ptr [rbp + 0x30]
#E908000000# ; jmp 0x402c82
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
#E8E0E5FFFF# ; call 0x40129e
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E82FDBFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E865FAFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E881FAFFFF# ; call 0x402777
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F814# ; cmp rax, 0x14
#0F8F19000000# ; jg 0x402d21
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883E001# ; and rax, 1
#50# ; push rax
#6A05# ; push 5
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E921000000# ; jmp 0x402d42
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883E80A# ; sub rax, 0xa
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F815# ; cmp rax, 0x15
#0F8507000000# ; jne 0x402d42
#6A0F# ; push 0xf
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E891F2FFFF# ; call 0x401fe1
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
#E88DDAFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8C3F9FFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8F4E0FFFF# ; call 0x400e89
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E812FAFFFF# ; call 0x4027b6
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E857DAFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E870D7FFFF# ; call 0x400534
#4885C0# ; test rax, rax
#0F84AB000000# ; je 0x402e78
#FF7510# ; push qword ptr [rbp + 0x10]
#E8EDF2FFFF# ; call 0x4020c2
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F80F# ; cmp rax, 0xf
#0F850C000000# ; jne 0x402df3
#6A04# ; push 4
#58# ; pop rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#E907000000# ; jmp 0x402dfa
#6A05# ; push 5
#58# ; pop rax
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A00# ; push 0
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#E8FDE3FFFF# ; call 0x401209
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#68C1000000# ; push 0xc1
#E877E3FFFF# ; call 0x401194
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
#E841E3FFFF# ; call 0x401194
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75E0# ; push qword ptr [rbp - 0x20]
#E829E3FFFF# ; call 0x401194
#50# ; push rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#FF7510# ; push qword ptr [rbp + 0x10]
#E84BD8FFFF# ; call 0x4006cb
#4883F82F# ; cmp rax, 0x2f
#0F8405000000# ; je 0x402e8f
#E8F7F1FFFF# ; call 0x402086
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8DDF8FFFF# ; call 0x402777
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#E8F4280000# ; call 0x4057a0
#C9# ; leave
#C22000# ; ret 0x20
#C8200000# ; enter 0x20, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E83DD9FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F2D7FFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F8570000000# ; jne 0x402f53
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E81CD9FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E852F8FFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#6A00# ; push 0
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#E8FAE2FFFF# ; call 0x401209
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68FF000000# ; push 0xff
#E874E2FFFF# ; call 0x401194
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
#E84EE2FFFF# ; call 0x401194
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E886DDFFFF# ; call 0x400ce1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F800# ; cmp rax, 0
#0F8C67000000# ; jl 0x402fd4
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8FFF7FFFF# ; call 0x402777
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#6A00# ; push 0
#FF75F8# ; push qword ptr [rbp - 8]
#6A00# ; push 0
#E87CE2FFFF# ; call 0x401209
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68FF000000# ; push 0xff
#E8F6E1FFFF# ; call 0x401194
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
#E8CDE1FFFF# ; call 0x401194
#50# ; push rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7510# ; push qword ptr [rbp + 0x10]
#E825F5FFFF# ; call 0x402504
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8D07000000# ; jge 0x402ff8
#6A00# ; push 0
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E874F7FFFF# ; call 0x402777
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68E8000000# ; push 0xe8
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7518# ; push qword ptr [rbp + 0x18]
#E80FEDFFFF# ; call 0x401d29
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8D7D7FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E885D6FFFF# ; call 0x4006cb
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x403055
#E831F0FFFF# ; call 0x402086
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A4F4FFFF# ; call 0x402504
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
#0F8405000000# ; je 0x4030a3
#E8E3EFFFFF# ; call 0x402086
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8505000000# ; jne 0x4030bd
#E8C9EFFFFF# ; call 0x402086
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F81C# ; cmp rax, 0x1c
#0F8517000000# ; jne 0x4030e2
#FF7530# ; push qword ptr [rbp + 0x30]
#68E9000000# ; push 0xe9
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E84BECFFFF# ; call 0x401d29
#C9# ; leave
#C23000# ; ret 0x30
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F852# ; cmp rax, 0x52
#0F8C48000000# ; jl 0x403138
#FF7530# ; push qword ptr [rbp + 0x30]
#E902000000# ; jmp 0x4030fa
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7538# ; push qword ptr [rbp + 0x38]
#E905000000# ; jmp 0x403112
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
#E8C7EDFFFF# ; call 0x401efb
#C9# ; leave
#C23000# ; ret 0x30
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F839# ; cmp rax, 0x39
#0F8D1D000000# ; jge 0x403163
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7538# ; push qword ptr [rbp + 0x38]
#6A22# ; push 0x22
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E89CEDFFFF# ; call 0x401efb
#C9# ; leave
#C23000# ; ret 0x30
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F83C# ; cmp rax, 0x3c
#0F8C14000000# ; jl 0x403185
#FF7530# ; push qword ptr [rbp + 0x30]
#6A02# ; push 2
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#E87AEDFFFF# ; call 0x401efb
#C9# ; leave
#C23000# ; ret 0x30
#FF7530# ; push qword ptr [rbp + 0x30]
#E902000000# ; jmp 0x40318f
#3000# ; xor byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7538# ; push qword ptr [rbp + 0x38]
#E904000000# ; jmp 0x4031a6
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
#E833EDFFFF# ; call 0x401efb
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
#0F84A9010000# ; je 0x40339b
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E80DD6FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F822# ; cmp rax, 0x22
#0F852C000000# ; jne 0x40323e
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E800260000# ; call 0x40581d
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D5D5FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E92E010000# ; jmp 0x40336c
#E902000000# ; jmp 0x403245
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F855B000000# ; jne 0x4032bc
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x403271
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E8C3050000# ; call 0x403848
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B0528260000# ; mov rax, qword ptr [rip + 0x2628]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x40329e
#2C00# ; sub al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A01# ; push 1
#E895050000# ; call 0x403848
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E95F000000# ; jmp 0x40331b
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E83DF2FFFF# ; call 0x402504
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F800# ; cmp rax, 0
#0F8C0D000000# ; jl 0x4032e6
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E90C000000# ; jmp 0x4032f2
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D4EDFFFF# ; call 0x4020c2
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x403302
#2C00# ; sub al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A01# ; push 1
#E831050000# ; call 0x403848
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B0596250000# ; mov rax, qword ptr [rip + 0x2596]
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4528# ; mov rax, qword ptr [rbp + 0x28]
#4883F801# ; cmp rax, 1
#0F851D000000# ; jne 0x403351
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#E855DEFFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E91B000000# ; jmp 0x40336c
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7528# ; push qword ptr [rbp + 0x28]
#E862DEFFFF# ; call 0x4011c1
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#E902000000# ; jmp 0x403373
#2C00# ; sub al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8407000000# ; je 0x403396
#6A00# ; push 0
#58# ; pop rax
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E94AFEFFFF# ; jmp 0x4031e5
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
#E80B250000# ; call 0x4058d0
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C040# ; add rax, 0x40
#50# ; push rax
#E8F9240000# ; call 0x4058d0
#6A00# ; push 0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF75F8# ; push qword ptr [rbp - 8]
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#0FB600# ; movzx eax, byte ptr [rax]
#4885C0# ; test rax, rax
#0F842C000000# ; je 0x403421
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
#EBBD# ; jmp 0x4033de
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
#0F8534000000# ; jne 0x403485
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A1F0FFFF# ; call 0x402504
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x403472
#E814ECFFFF# ; call 0x402086
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E84DF1FFFF# ; call 0x4025cd
#E923000000# ; jmp 0x4034a8
#6A02# ; push 2
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F850E000000# ; jne 0x4034a8
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E875F2FFFF# ; call 0x40271d
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E857D3FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F800# ; cmp rax, 0
#0F8507000000# ; jne 0x4034cc
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#FF7518# ; push qword ptr [rbp + 0x18]
#E8F7D1FFFF# ; call 0x4006cb
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
#0F8410000000# ; je 0x403542
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4889058B230000# ; mov qword ptr [rip + 0x238b], rax
#E844EBFFFF# ; call 0x402086
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F851# ; cmp rax, 0x51
#0F8567000000# ; jne 0x4035b7
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#6A0A# ; push 0xa
#6A00# ; push 0
#6A00# ; push 0
#E8E4020000# ; call 0x403848
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
#0F840E000000# ; je 0x4035b0
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF7510# ; push qword ptr [rbp + 0x10]
#E86DF1FFFF# ; call 0x40271d
#6A00# ; push 0
#58# ; pop rax
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F81F# ; cmp rax, 0x1f
#0F8517000000# ; jne 0x4035dc
#FF7530# ; push qword ptr [rbp + 0x30]
#6A01# ; push 1
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8F4FBFFFF# ; call 0x4031cc
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F83F# ; cmp rax, 0x3f
#0F8517000000# ; jne 0x403601
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8CFFBFFFF# ; call 0x4031cc
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F840# ; cmp rax, 0x40
#0F8517000000# ; jne 0x403626
#FF7530# ; push qword ptr [rbp + 0x30]
#6A04# ; push 4
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E8AAFBFFFF# ; call 0x4031cc
#C9# ; leave
#C22800# ; ret 0x28
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F841# ; cmp rax, 0x41
#0F8517000000# ; jne 0x40364b
#FF7530# ; push qword ptr [rbp + 0x30]
#6A02# ; push 2
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E885FBFFFF# ; call 0x4031cc
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
#E897D1FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E862D6FFFF# ; call 0x400ce1
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F800# ; cmp rax, 0
#0F8D0C000000# ; jge 0x40369d
#FF7518# ; push qword ptr [rbp + 0x18]
#E829EAFFFF# ; call 0x4020c2
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E80EF1FFFF# ; call 0x4027b6
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E853D1FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E81ED6FFFF# ; call 0x400ce1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4885C0# ; test rax, rax
#0F844E000000# ; je 0x403722
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F802# ; cmp rax, 2
#0F8511000000# ; jne 0x4036f3
#FF7528# ; push qword ptr [rbp + 0x28]
#68EC000000# ; push 0xec
#E8A5DAFFFF# ; call 0x401194
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#68E4000000# ; push 0xe4
#E894DAFFFF# ; call 0x401194
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B3E9FFFF# ; call 0x4020c2
#50# ; push rax
#E87FDAFFFF# ; call 0x401194
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883F802# ; cmp rax, 2
#0F8511000000# ; jne 0x403741
#FF7528# ; push qword ptr [rbp + 0x28]
#68EE000000# ; push 0xee
#E857DAFFFF# ; call 0x401194
#C9# ; leave
#C22000# ; ret 0x20
#FF7528# ; push qword ptr [rbp + 0x28]
#68E6000000# ; push 0xe6
#E846DAFFFF# ; call 0x401194
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E837DAFFFF# ; call 0x401194
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22000# ; ret 0x20
#C8000000# ; enter 0, 0
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F801# ; cmp rax, 1
#0F850F000000# ; jne 0x40378b
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F802# ; cmp rax, 2
#0F850F000000# ; jne 0x4037a8
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F803# ; cmp rax, 3
#0F8510000000# ; jne 0x4037c6
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F804# ; cmp rax, 4
#0F8512000000# ; jne 0x4037e6
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4889F9# ; mov rcx, rdi
#48D3E0# ; shl rax, cl
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F805# ; cmp rax, 5
#0F8512000000# ; jne 0x403806
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4889F9# ; mov rcx, rdi
#48D3E8# ; shr rax, cl
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F806# ; cmp rax, 6
#0F850F000000# ; jne 0x403823
#FF7510# ; push qword ptr [rbp + 0x10]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#C9# ; leave
#C21800# ; ret 0x18
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F807# ; cmp rax, 7
#0F850F000000# ; jne 0x403840
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
#0F84C7030000# ; je 0x403c2f
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#E897CFFFFF# ; call 0x40080a
#48894538# ; mov qword ptr [rbp + 0x38], rax
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4883F800# ; cmp rax, 0
#0F8512000000# ; jne 0x403897
#6A00# ; push 0
#58# ; pop rax
#48890529200000# ; mov qword ptr [rip + 0x2029], rax
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
#0F8413000000# ; je 0x4038e3
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#488905DD1F0000# ; mov qword ptr [rip + 0x1fdd], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#C9# ; leave
#C23000# ; ret 0x30
#E902000000# ; jmp 0x4038ea
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F856C000000# ; jne 0x403972
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E902000000# ; jmp 0x403916
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E81EFFFFFF# ; call 0x403848
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B05831F0000# ; mov rax, qword ptr [rip + 0x1f83]
#48894538# ; mov qword ptr [rbp + 0x38], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8514000000# ; jne 0x40395b
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#48894518# ; mov qword ptr [rbp + 0x18], rax
#6A01# ; push 1
#58# ; pop rax
#48894510# ; mov qword ptr [rbp + 0x10], rax
#E912000000# ; jmp 0x40396d
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E801FEFFFF# ; call 0x40376a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#E9B8020000# ; jmp 0x403c2a
#E902000000# ; jmp 0x403979
#7C00# ; jl 0x403979
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
#E902000000# ; jmp 0x40399e
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
#E902000000# ; jmp 0x4039c3
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
#E902000000# ; jmp 0x4039e8
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
#E902000000# ; jmp 0x403a0d
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
#E902000000# ; jmp 0x403a32
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45300FB6005F31D2# ; data
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x403a57
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
#0F842B010000# ; je 0x403bc0
#E902000000# ; jmp 0x403a9c
#2B00# ; sub eax, dword ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x403abf
#6A01# ; push 1
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x403ac6
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45300FB6005F4839# ; data
#F8# ; clc
#0F8507000000# ; jne 0x403ae9
#6A02# ; push 2
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x403af0
#2A00# ; sub al, byte ptr [rax]
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x403b13
#6A03# ; push 3
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x403b1a
#3C00# ; cmp al, 0
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x403b3d
#6A04# ; push 4
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x403b44
#3E00488D# ; add byte ptr ds:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x403b67
#6A05# ; push 5
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x403b6e
#2600488D# ; add byte ptr es:[rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x403b91
#6A06# ; push 6
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E902000000# ; jmp 0x403b98
#7C00# ; jl 0x403b98
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4530# ; mov rax, qword ptr [rbp + 0x30]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8507000000# ; jne 0x403bbb
#6A07# ; push 7
#58# ; pop rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#E96A000000# ; jmp 0x403c2a
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#E839E9FFFF# ; call 0x402504
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F800# ; cmp rax, 0
#0F8C0D000000# ; jl 0x403bea
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#488945F8# ; mov qword ptr [rbp - 8], rax
#E90C000000# ; jmp 0x403bf6
#FF7530# ; push qword ptr [rbp + 0x30]
#E8D0E4FFFF# ; call 0x4020c2
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8514000000# ; jne 0x403c18
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#48894518# ; mov qword ptr [rbp + 0x18], rax
#6A01# ; push 1
#58# ; pop rax
#48894510# ; mov qword ptr [rbp + 0x10], rax
#E912000000# ; jmp 0x403c2a
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#E844FBFFFF# ; call 0x40376a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#E92BFCFFFF# ; jmp 0x40385a
#488B4538# ; mov rax, qword ptr [rbp + 0x38]
#4889057E1C0000# ; mov qword ptr [rip + 0x1c7e], rax
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
#E8A7CBFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8DDEAFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E80ED2FFFF# ; call 0x400e89
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E82CEBFFFF# ; call 0x4027b6
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E871CBFFFF# ; call 0x40080a
#48894518# ; mov qword ptr [rbp + 0x18], rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8A7EAFFFF# ; call 0x40274c
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A00# ; push 0
#E84DD5FFFF# ; call 0x401209
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#6A0F# ; push 0xf
#E8CAD4FFFF# ; call 0x401194
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#68AF000000# ; push 0xaf
#E8B0D4FFFF# ; call 0x401194
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
#E876D4FFFF# ; call 0x401194
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
#E8BECAFFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F4E9FFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E825D1FFFF# ; call 0x400e89
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E843EAFFFF# ; call 0x4027b6
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E888CAFFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E905000000# ; jmp 0x403d93
#6279746500488D05F4FFFFFF50E84CCE# ; data
#FFFF4885C00F840F000000FF7528FF75# ; data
#20E8# ; and al, ch
#56# ; push rsi
#CAFFFF# ; retf 0xffff
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E80BC9FFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F8583000000# ; jne 0x403e4d
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E838020000# ; call 0x404010
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05A81A0000# ; mov rax, qword ptr [rip + 0x1aa8]
#50# ; push rax
#6A00# ; push 0
#E819D4FFFF# ; call 0x401209
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A0F# ; push 0xf
#E896D3FFFF# ; call 0x401194
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68B6000000# ; push 0xb6
#E87CD3FFFF# ; call 0x401194
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75F8# ; push qword ptr [rbp - 8]
#488B055E1A0000# ; mov rax, qword ptr [rip + 0x1a5e]
#50# ; push rax
#488B05661A0000# ; mov rax, qword ptr [rip + 0x1a66]
#50# ; push rax
#E8F5D9FFFF# ; call 0x401835
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E8F7E8FFFF# ; call 0x40274c
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
#E88BD3FFFF# ; call 0x401209
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A0F# ; push 0xf
#E808D3FFFF# ; call 0x401194
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68B6000000# ; push 0xb6
#E8EED2FFFF# ; call 0x401194
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
#E8B4D2FFFF# ; call 0x401194
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
#E808C9FFFF# ; call 0x40080a
#48894530# ; mov qword ptr [rbp + 0x30], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#E8BDC7FFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F8405000000# ; je 0x403f1d
#E869E1FFFF# ; call 0x402086
#FF7530# ; push qword ptr [rbp + 0x30]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8E5000000# ; call 0x404010
#488B055E190000# ; mov rax, qword ptr [rip + 0x195e]
#4883F800# ; cmp rax, 0
#0F8C1A000000# ; jl 0x403f56
#FF7538# ; push qword ptr [rbp + 0x38]
#6A04# ; push 4
#6A00# ; push 0
#488B0546190000# ; mov rax, qword ptr [rip + 0x1946]
#50# ; push rax
#6A00# ; push 0
#E8B7D2FFFF# ; call 0x401209
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#6A0F# ; push 0xf
#E834D2FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#6A01# ; push 1
#E81DD2FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B0505190000# ; mov rax, qword ptr [rip + 0x1905]
#4883F800# ; cmp rax, 0
#0F8C28000000# ; jl 0x403fbd
#FF7538# ; push qword ptr [rbp + 0x38]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B05EE180000# ; mov rax, qword ptr [rip + 0x18ee]
#50# ; push rax
#488B05F6180000# ; mov rax, qword ptr [rip + 0x18f6]
#50# ; push rax
#E885D8FFFF# ; call 0x401835
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
#E8C2D1FFFF# ; call 0x401194
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7538# ; push qword ptr [rbp + 0x38]
#FF75F8# ; push qword ptr [rbp - 8]
#FF7518# ; push qword ptr [rbp + 0x18]
#488B05B1180000# ; mov rax, qword ptr [rip + 0x18b1]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#4883E804# ; sub rax, 4
#50# ; push rax
#6A04# ; push 4
#E8BED1FFFF# ; call 0x4011c1
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
#48890562180000# ; mov qword ptr [rip + 0x1862], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#4889055D180000# ; mov qword ptr [rip + 0x185d], rax
#6A00# ; push 0
#58# ; pop rax
#4889055B180000# ; mov qword ptr [rip + 0x185b], rax
#6A00# ; push 0
#58# ; pop rax
#48890559180000# ; mov qword ptr [rip + 0x1859], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B0C7FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E904000000# ; jmp 0x40406a
#7265# ; jb 0x4040cd
#6C# ; insb byte ptr [rdi], dx
#00488D# ; add byte ptr [rax - 0x73], cl
#05F5FFFFFF# ; add eax, 0xfffffff5
#50# ; push rax
#E875CBFFFF# ; call 0x400bec
#4885C0# ; test rax, rax
#0F8455000000# ; je 0x4040d5
#6A01# ; push 1
#58# ; pop rax
#4889051E180000# ; mov qword ptr [rip + 0x181e], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E875C7FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E860E4FFFF# ; call 0x402504
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8C0B000000# ; jl 0x4040c1
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#488905DF170000# ; mov qword ptr [rip + 0x17df], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E83EC7FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E963020000# ; jmp 0x404338
#FF7518# ; push qword ptr [rbp + 0x18]
#E804CCFFFF# ; call 0x400ce1
#488905AC170000# ; mov qword ptr [rip + 0x17ac], rax
#488B05A5170000# ; mov rax, qword ptr [rip + 0x17a5]
#4883F800# ; cmp rax, 0
#0F8D3C000000# ; jge 0x404131
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E804E4FFFF# ; call 0x402504
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8C10000000# ; jl 0x404122
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#48890583170000# ; mov qword ptr [rip + 0x1783], rax
#E90F000000# ; jmp 0x404131
#FF7518# ; push qword ptr [rbp + 0x18]
#E898DFFFFF# ; call 0x4020c2
#4889056F170000# ; mov qword ptr [rip + 0x176f], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CEC6FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E902000000# ; jmp 0x404147
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F31D2# ; data
#4839F8# ; cmp rax, rdi
#0F94C2# ; sete dl
#89D0# ; mov eax, edx
#50# ; push rax
#E902000000# ; jmp 0x40416c
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
#0F84A2010000# ; je 0x404338
#E902000000# ; jmp 0x40419d
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45180FB6005F4839# ; data
#F8# ; clc
#0F850A000000# ; jne 0x4041c3
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E83CC6FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E807CBFFFF# ; call 0x400ce1
#488905B7160000# ; mov qword ptr [rip + 0x16b7], rax
#488B05B0160000# ; mov rax, qword ptr [rip + 0x16b0]
#4883F800# ; cmp rax, 0
#0F8D37010000# ; jge 0x404329
#E902000000# ; jmp 0x4041f9
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8560000000# ; jne 0x404275
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x404225
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E80FF6FFFF# ; call 0x403848
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#50# ; push rax
#488B054F160000# ; mov rax, qword ptr [rip + 0x164f]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#48890544160000# ; mov qword ptr [rip + 0x1644], rax
#488B0555160000# ; mov rax, qword ptr [rip + 0x1655]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E89EC5FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E9AF000000# ; jmp 0x404324
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8B2C2FFFF# ; call 0x400534
#4885C0# ; test rax, rax
#0F844D000000# ; je 0x4042d8
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x40429b
#5D# ; pop rbp
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E814DEFFFF# ; call 0x4020c2
#50# ; push rax
#6A01# ; push 1
#E892F5FFFF# ; call 0x403848
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#50# ; push rax
#488B05D8150000# ; mov rax, qword ptr [rip + 0x15d8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488905CD150000# ; mov qword ptr [rip + 0x15cd], rax
#E941000000# ; jmp 0x404319
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E902000000# ; jmp 0x4042e8
#5D# ; pop rbp
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E84CF5FFFF# ; call 0x403848
#50# ; push rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#480FAFC7# ; imul rax, rdi
#50# ; push rax
#488B0592150000# ; mov rax, qword ptr [rip + 0x1592]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#48890587150000# ; mov qword ptr [rip + 0x1587], rax
#488B0598150000# ; mov rax, qword ptr [rip + 0x1598]
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E90F000000# ; jmp 0x404338
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8D6C4FFFF# ; call 0x40080a
#48894520# ; mov qword ptr [rbp + 0x20], rax
#E902000000# ; jmp 0x40433f
#5D# ; pop rbp
#00488D# ; add byte ptr [rax - 0x73], cl
#05F7FFFFFF# ; add eax, 0xfffffff7
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x404360
#E826DDFFFF# ; call 0x402086
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#48890545150000# ; mov qword ptr [rip + 0x1545], rax
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
#E865C4FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E81AC3FFFF# ; call 0x4006cb
#488945C0# ; mov qword ptr [rbp - 0x40], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F823# ; cmp rax, 0x23
#0F8516000000# ; jne 0x4043d9
#6A08# ; push 8
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E835C4FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F845# ; cmp rax, 0x45
#0F8516000000# ; jne 0x4043fd
#6A04# ; push 4
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E811C4FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F846# ; cmp rax, 0x46
#0F8516000000# ; jne 0x404421
#6A02# ; push 2
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EDC3FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4883F844# ; cmp rax, 0x44
#0F8516000000# ; jne 0x404445
#6A01# ; push 1
#58# ; pop rax
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8C9C3FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E87EC2FFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F85B2010000# ; jne 0x404609
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8ABFBFFFF# ; call 0x404010
#488B0544140000# ; mov rax, qword ptr [rip + 0x1444]
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E83BE3FFFF# ; call 0x4027b6
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E880C3FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E84BC8FFFF# ; call 0x400ce1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883F800# ; cmp rax, 0
#0F8C96000000# ; jl 0x40453e
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F808# ; cmp rax, 8
#0F850C000000# ; jne 0x4044c2
#FF7520# ; push qword ptr [rbp + 0x20]
#E8CBC9FFFF# ; call 0x400e89
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F801# ; cmp rax, 1
#0F850F000000# ; jne 0x4044df
#6888000000# ; push 0x88
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#E90A000000# ; jmp 0x4044e9
#6889000000# ; push 0x89
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B05B8130000# ; mov rax, qword ptr [rip + 0x13b8]
#4885C0# ; test rax, rax
#0F8420000000# ; je 0x404519
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B0594130000# ; mov rax, qword ptr [rip + 0x1394]
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E8FAD8FFFF# ; call 0x401e0f
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F0# ; push qword ptr [rbp - 0x10]
#488B0564130000# ; mov rax, qword ptr [rip + 0x1364]
#50# ; push rax
#488B056C130000# ; mov rax, qword ptr [rip + 0x136c]
#50# ; push rax
#E8EBD5FFFF# ; call 0x401b25
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E87CDBFFFF# ; call 0x4020c2
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B053F130000# ; mov rax, qword ptr [rip + 0x133f]
#4883F800# ; cmp rax, 0
#0F8D38000000# ; jge 0x404593
#FF7530# ; push qword ptr [rbp + 0x30]
#68C7000000# ; push 0xc7
#FF75E0# ; push qword ptr [rbp - 0x20]
#6A00# ; push 0
#488B0531130000# ; mov rax, qword ptr [rip + 0x1331]
#50# ; push rax
#E8C9D6FFFF# ; call 0x401c3e
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A04# ; push 4
#E83BCCFFFF# ; call 0x4011c1
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75E0# ; push qword ptr [rbp - 0x20]
#6A00# ; push 0
#488B05EE120000# ; mov rax, qword ptr [rip + 0x12ee]
#50# ; push rax
#6A00# ; push 0
#E85FCCFFFF# ; call 0x401209
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#68C7000000# ; push 0xc7
#E8D9CBFFFF# ; call 0x401194
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A00# ; push 0
#488B05BC120000# ; mov rax, qword ptr [rip + 0x12bc]
#50# ; push rax
#488B05C4120000# ; mov rax, qword ptr [rip + 0x12c4]
#50# ; push rax
#E853D2FFFF# ; call 0x401835
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A04# ; push 4
#E8C5CBFFFF# ; call 0x4011c1
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E849CAFFFF# ; call 0x40105a
#4883F800# ; cmp rax, 0
#0F8C81000000# ; jl 0x40469c
#FF7520# ; push qword ptr [rbp + 0x20]
#E837CAFFFF# ; call 0x40105a
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E884E1FFFF# ; call 0x4027b6
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8C9C1FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8FFE0FFFF# ; call 0x40274c
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#688E000000# ; push 0x8e
#E836CBFFFF# ; call 0x401194
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
#E805CBFFFF# ; call 0x401194
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E904000000# ; jmp 0x4046a8
#637233# ; movsxd esi, dword ptr [rdx + 0x33]
#00488D# ; add byte ptr [rax - 0x73], cl
#05F5FFFFFF# ; add eax, 0xfffffff5
#50# ; push rax
#E837C5FFFF# ; call 0x400bec
#4885C0# ; test rax, rax
#0F84A2000000# ; je 0x404760
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EDE0FFFF# ; call 0x4027b6
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E832C1FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E868E0FFFF# ; call 0x40274c
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A08# ; push 8
#6A00# ; push 0
#FF75F0# ; push qword ptr [rbp - 0x10]
#6A00# ; push 0
#E810CBFFFF# ; call 0x401209
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A0F# ; push 0xf
#E88DCAFFFF# ; call 0x401194
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A22# ; push 0x22
#E876CAFFFF# ; call 0x401194
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
#E841CAFFFF# ; call 0x401194
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E8E4DFFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E815C7FFFF# ; call 0x400e89
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E833E0FFFF# ; call 0x4027b6
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E878C0FFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E82DBFFFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F858A000000# ; jne 0x404832
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E85AF8FFFF# ; call 0x404010
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F801# ; cmp rax, 1
#0F850F000000# ; jne 0x4047d3
#688A000000# ; push 0x8a
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#E90A000000# ; jmp 0x4047dd
#688B000000# ; push 0x8b
#58# ; pop rax
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B05C4100000# ; mov rax, qword ptr [rip + 0x10c4]
#4885C0# ; test rax, rax
#0F8420000000# ; je 0x40480d
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05A0100000# ; mov rax, qword ptr [rip + 0x10a0]
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E806D6FFFF# ; call 0x401e0f
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#488B0570100000# ; mov rax, qword ptr [rip + 0x1070]
#50# ; push rax
#488B0578100000# ; mov rax, qword ptr [rip + 0x1078]
#50# ; push rax
#E8F7D2FFFF# ; call 0x401b25
#C9# ; leave
#C22800# ; ret 0x28
#FF7520# ; push qword ptr [rbp + 0x20]
#E8A7C4FFFF# ; call 0x400ce1
#4883F800# ; cmp rax, 0
#0F8C4E000000# ; jl 0x404892
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#4883F801# ; cmp rax, 1
#0F8520000000# ; jne 0x404872
#FF7530# ; push qword ptr [rbp + 0x30]
#6888000000# ; push 0x88
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF7520# ; push qword ptr [rbp + 0x20]
#E87CC4FFFF# ; call 0x400ce1
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E830CAFFFF# ; call 0x40129e
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#6889000000# ; push 0x89
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF7520# ; push qword ptr [rbp + 0x20]
#E85CC4FFFF# ; call 0x400ce1
#50# ; push rax
#FF75F8# ; push qword ptr [rbp - 8]
#E810CAFFFF# ; call 0x40129e
#C9# ; leave
#C22800# ; ret 0x28
#E902000000# ; jmp 0x404899
#2D00488D05# ; sub eax, 0x58d4800
#F7FF# ; idiv edi
#FFFF0FB60050488B45200FB6005F4839# ; data
#F8# ; clc
#0F8548000000# ; jne 0x4048fd
#6A01# ; push 1
#58# ; pop rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E843BFFFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8EFD7FFFF# ; call 0x4020c2
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
#E854EFFFFF# ; call 0x403848
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E9CD000000# ; jmp 0x4049ca
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E82ABCFFFF# ; call 0x400534
#4885C0# ; test rax, rax
#0F8407000000# ; je 0x40491a
#6A01# ; push 1
#58# ; pop rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8DFDBFFFF# ; call 0x402504
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4883F800# ; cmp rax, 0
#0F8D0C000000# ; jge 0x404943
#FF7520# ; push qword ptr [rbp + 0x20]
#E883D7FFFF# ; call 0x4020c2
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E902000000# ; jmp 0x40494a
#2800# ; sub byte ptr [rax], al
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#0FB600# ; movzx eax, byte ptr [rax]
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F854B000000# ; jne 0x4049b1
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E902000000# ; jmp 0x404976
#2900# ; sub dword ptr [rax], eax
#488D05F7FFFFFF# ; lea rax, [rip - 9]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#6A00# ; push 0
#6A00# ; push 0
#E8BEEEFFFF# ; call 0x403848
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B05230F0000# ; mov rax, qword ptr [rip + 0xf23]
#50# ; push rax
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A0A# ; push 0xa
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A01# ; push 1
#E8A0EEFFFF# ; call 0x403848
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#E919000000# ; jmp 0x4049ca
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#6A0A# ; push 0xa
#FF75E8# ; push qword ptr [rbp - 0x18]
#6A01# ; push 1
#E882EEFFFF# ; call 0x403848
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#FF7530# ; push qword ptr [rbp + 0x30]
#6A00# ; push 0
#FF75E0# ; push qword ptr [rbp - 0x20]
#FF75F8# ; push qword ptr [rbp - 8]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75C8# ; push qword ptr [rbp - 0x38]
#E8A9C9FFFF# ; call 0x401389
#C9# ; leave
#C22800# ; ret 0x28
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E80DBEFFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E843DDFFFF# ; call 0x40274c
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E874C4FFFF# ; call 0x400e89
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E892DDFFFF# ; call 0x4027b6
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#E8D7BDFFFF# ; call 0x40080a
#48894528# ; mov qword ptr [rbp + 0x28], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E88CBCFFFF# ; call 0x4006cb
#4883F832# ; cmp rax, 0x32
#0F8405000000# ; je 0x404a4e
#E838D6FFFF# ; call 0x402086
#FF7528# ; push qword ptr [rbp + 0x28]
#FF7520# ; push qword ptr [rbp + 0x20]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8B4F5FFFF# ; call 0x404010
#488B05450E0000# ; mov rax, qword ptr [rip + 0xe45]
#4885C0# ; test rax, rax
#0F8422000000# ; je 0x404a8e
#FF7530# ; push qword ptr [rbp + 0x30]
#688D000000# ; push 0x8d
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#488B051F0E0000# ; mov rax, qword ptr [rip + 0xe1f]
#50# ; push rax
#FF7510# ; push qword ptr [rbp + 0x10]
#E885D3FFFF# ; call 0x401e0f
#C9# ; leave
#C22800# ; ret 0x28
#FF7530# ; push qword ptr [rbp + 0x30]
#688D000000# ; push 0x8d
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75F8# ; push qword ptr [rbp - 8]
#488B05ED0D0000# ; mov rax, qword ptr [rip + 0xded]
#50# ; push rax
#488B05F50D0000# ; mov rax, qword ptr [rip + 0xdf5]
#50# ; push rax
#E874D0FFFF# ; call 0x401b25
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
#E8D60D0000# ; call 0x4058d0
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4881C000000100# ; add rax, 0x10000
#50# ; push rax
#E8C10D0000# ; call 0x4058d0
#488945E8# ; mov qword ptr [rbp - 0x18], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#488905AA0D0000# ; mov qword ptr [rip + 0xdaa], rax
#488B45E8# ; mov rax, qword ptr [rbp - 0x18]
#4881C000000100# ; add rax, 0x10000
#50# ; push rax
#E8A10D0000# ; call 0x4058d0
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8C30D0000# ; call 0x405902
#4881E0FF000000# ; and rax, 0xff
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#4885C0# ; test rax, rax
#0F84480A0000# ; je 0x40559b
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
#0F842E000000# ; je 0x404bbd
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#50# ; push rax
#488B45E0# ; mov rax, qword ptr [rbp - 0x20]
#5F# ; pop rdi
#488907# ; mov qword ptr [rdi], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF7520# ; push qword ptr [rbp + 0x20]
#E8520D0000# ; call 0x405902
#4881E0FF000000# ; and rax, 0xff
#488945E0# ; mov qword ptr [rbp - 0x20], rax
#EB9E# ; jmp 0x404b5b
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
#0F840E000000# ; je 0x404c19
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#EBB8# ; jmp 0x404bd1
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#4883F825# ; cmp rax, 0x25
#0F85D7010000# ; jne 0x404e01
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C001# ; add rax, 1
#0FB600# ; movzx eax, byte ptr [rax]
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F864# ; cmp rax, 0x64
#0F8525000000# ; jne 0x404c6c
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4885C0# ; test rax, rax
#0F8413000000# ; je 0x404c67
#6A00# ; push 0
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C008# ; add rax, 8
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E866D9FFFF# ; call 0x4025cd
#E990010000# ; jmp 0x404dfc
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F869# ; cmp rax, 0x69
#0F85BB000000# ; jne 0x404d35
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883F83F# ; cmp rax, 0x3f
#0F8505000000# ; jne 0x404c8d
#E8F9D3FFFF# ; call 0x402086
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C003# ; add rax, 3
#0FB600# ; movzx eax, byte ptr [rax]
#4883F864# ; cmp rax, 0x64
#0F8529000000# ; jne 0x404ccb
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C007# ; add rax, 7
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E84DD8FFFF# ; call 0x402504
#5F# ; pop rdi
#31D2# ; xor edx, edx
#4839F8# ; cmp rax, rdi
#0F9DC2# ; setge dl
#89D0# ; mov eax, edx
#488945A0# ; mov qword ptr [rbp - 0x60], rax
#E924000000# ; jmp 0x404cef
#6A00# ; push 0
#58# ; pop rax
#50# ; push rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C008# ; add rax, 8
#50# ; push rax
#FF7518# ; push qword ptr [rbp + 0x18]
#E824D8FFFF# ; call 0x402504
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
#E9C7000000# ; jmp 0x404dfc
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F865# ; cmp rax, 0x65
#0F85A7000000# ; jne 0x404dea
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883F800# ; cmp rax, 0
#0F8505000000# ; jne 0x404d56
#E830D3FFFF# ; call 0x402086
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4883C002# ; add rax, 2
#0FB600# ; movzx eax, byte ptr [rax]
#4883F86C# ; cmp rax, 0x6c
#0F854A000000# ; jne 0x404db5
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
#E930000000# ; jmp 0x404de5
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
#E912000000# ; jmp 0x404dfc
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4885C0# ; test rax, rax
#0F8405000000# ; je 0x404dfc
#E88AD2FFFF# ; call 0x402086
#E995070000# ; jmp 0x405596
#488B45C0# ; mov rax, qword ptr [rbp - 0x40]
#4885C0# ; test rax, rax
#0F8488070000# ; je 0x405596
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E8F1B9FFFF# ; call 0x40080a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#488B45F0# ; mov rax, qword ptr [rbp - 0x10]
#4885C0# ; test rax, rax
#0F846C070000# ; je 0x405596
#FF75E8# ; push qword ptr [rbp - 0x18]
#E899B8FFFF# ; call 0x4006cb
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
#0F841E000000# ; je 0x404e88
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E87BD9FFFF# ; call 0x4027f6
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F838# ; cmp rax, 0x38
#0F851B000000# ; jne 0x404eb1
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E874D9FFFF# ; call 0x402818
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F836# ; cmp rax, 0x36
#0F851B000000# ; jne 0x404eda
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E840B9FFFF# ; call 0x40080a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E8ECD1FFFF# ; call 0x4020c2
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
#0F841E000000# ; je 0x404f2c
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E83CD9FFFF# ; call 0x40285b
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
#0F8421000000# ; je 0x404f81
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CBD9FFFF# ; call 0x40293f
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
#0F841E000000# ; je 0x404fd3
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E88EDDFFFF# ; call 0x402d54
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
#0F841E000000# ; je 0x405025
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E8AADCFFFF# ; call 0x402cc2
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F81B# ; cmp rax, 0x1b
#0F8521000000# ; jne 0x405054
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E869DEFFFF# ; call 0x402eb0
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
#0F8424000000# ; je 0x4050ac
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E87FDFFFFF# ; call 0x40301e
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
#0F8424000000# ; je 0x405104
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E827DFFFFF# ; call 0x40301e
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
#0F8424000000# ; je 0x40515c
#FF75D8# ; push qword ptr [rbp - 0x28]
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF7518# ; push qword ptr [rbp + 0x18]
#E8CFDEFFFF# ; call 0x40301e
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
#0F8521000000# ; jne 0x405192
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75D0# ; push qword ptr [rbp - 0x30]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E81EE2FFFF# ; call 0x4033a3
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F820# ; cmp rax, 0x20
#0F852D000000# ; jne 0x4051cd
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E85FB6FFFF# ; call 0x40080a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#6A01# ; push 1
#58# ; pop rax
#48F7D8# ; neg rax
#50# ; push rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E80DB5FFFF# ; call 0x4006cb
#5F# ; pop rdi
#4839F8# ; cmp rax, rdi
#0F8405000000# ; je 0x4051cd
#E8B9CEFFFF# ; call 0x402086
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F819# ; cmp rax, 0x19
#0F8521000000# ; jne 0x4051fc
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#E882F1FFFF# ; call 0x404371
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F81A# ; cmp rax, 0x1a
#0F8521000000# ; jne 0x40522b
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#E8C6F7FFFF# ; call 0x4049e4
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F81F# ; cmp rax, 0x1f
#0F8520000000# ; jne 0x405259
#FF7528# ; push qword ptr [rbp + 0x28]
#6A01# ; push 1
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#E880DFFFFF# ; call 0x4031cc
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F83E# ; cmp rax, 0x3e
#0F854F000000# ; jne 0x4052b6
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E898B5FFFF# ; call 0x40080a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E844CEFFFF# ; call 0x4020c2
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883E801# ; sub rax, 1
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4821F8# ; and rax, rdi
#4883F800# ; cmp rax, 0
#0F8419000000# ; je 0x4052b6
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#E8EDBEFFFF# ; call 0x401194
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#EBCC# ; jmp 0x405282
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
#0F8434000000# ; je 0x40531e
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
#E8BBDEFFFF# ; call 0x4031cc
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F842# ; cmp rax, 0x42
#0F851B000000# ; jne 0x405347
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E808E9FFFF# ; call 0x403c42
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F843# ; cmp rax, 0x43
#0F8521000000# ; jne 0x405376
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#E8C2E9FFFF# ; call 0x403d2b
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
#0F8444000000# ; je 0x4053ee
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F847# ; cmp rax, 0x47
#0F850F000000# ; jne 0x4053c7
#68F4000000# ; push 0xf4
#58# ; pop rax
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#E90F000000# ; jmp 0x4053d6
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4881C0B2000000# ; add rax, 0xb2
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75C8# ; push qword ptr [rbp - 0x38]
#E8B3BDFFFF# ; call 0x401194
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
#0F843E000000# ; je 0x405460
#FF7528# ; push qword ptr [rbp + 0x28]
#6A48# ; push 0x48
#E868BDFFFF# ; call 0x401194
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
#E848BDFFFF# ; call 0x401194
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
#0F842A000000# ; je 0x4054be
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75D0# ; push qword ptr [rbp - 0x30]
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883E84A# ; sub rax, 0x4a
#50# ; push rax
#E83CEAFFFF# ; call 0x403eed
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#488B45D8# ; mov rax, qword ptr [rbp - 0x28]
#4883F84E# ; cmp rax, 0x4e
#0F8570000000# ; jne 0x40553c
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#E833B3FFFF# ; call 0x40080a
#488945F0# ; mov qword ptr [rbp - 0x10], rax
#FF75E8# ; push qword ptr [rbp - 0x18]
#E869D2FFFF# ; call 0x40274c
#488945D8# ; mov qword ptr [rbp - 0x28], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#6A0F# ; push 0xf
#E8A3BCFFFF# ; call 0x401194
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF7528# ; push qword ptr [rbp + 0x28]
#6A00# ; push 0
#E895BCFFFF# ; call 0x401194
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
#E86CBCFFFF# ; call 0x401194
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
#0F8426000000# ; je 0x405596
#FF7528# ; push qword ptr [rbp + 0x28]
#FF75F0# ; push qword ptr [rbp - 0x10]
#FF75E8# ; push qword ptr [rbp - 0x18]
#FF75D8# ; push qword ptr [rbp - 0x28]
#6A50# ; push 0x50
#58# ; pop rax
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#50# ; push rax
#E8C9E0FFFF# ; call 0x403652
#50# ; push rax
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#488945D0# ; mov qword ptr [rbp - 0x30], rax
#E99CF5FFFF# ; jmp 0x404b37
#488B45B8# ; mov rax, qword ptr [rbp - 0x48]
#4883F800# ; cmp rax, 0
#0F8405000000# ; je 0x4055ae
#E8D8CAFFFF# ; call 0x402086
#FF7510# ; push qword ptr [rbp + 0x10]
#488B45D0# ; mov rax, qword ptr [rbp - 0x30]
#5F# ; pop rdi
#4829F8# ; sub rax, rdi
#488945C8# ; mov qword ptr [rbp - 0x38], rax
#FF75F8# ; push qword ptr [rbp - 8]
#E80B030000# ; call 0x4058d0
#488B45C8# ; mov rax, qword ptr [rbp - 0x38]
#C9# ; leave
#C22000# ; ret 0x20
#C8000000# ; enter 0, 0
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C18000000# ; jl 0x4055f7
#FF7518# ; push qword ptr [rbp + 0x18]
#68CD000000# ; push 0xcd
#E858030000# ; call 0x405944
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#E84D030000# ; call 0x405944
#6A02# ; push 2
#58# ; pop rax
#C9# ; leave
#C21000# ; ret 0x10
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8522000000# ; jne 0x405638
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8C0D000000# ; jl 0x405631
#FF7510# ; push qword ptr [rbp + 0x10]
#68C3000000# ; push 0xc3
#E813030000# ; call 0x405944
#6A01# ; push 1
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F801# ; cmp rax, 1
#0F8529000000# ; jne 0x40566f
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F800# ; cmp rax, 0
#0F8C14000000# ; jl 0x405668
#FF7510# ; push qword ptr [rbp + 0x10]
#6A0F# ; push 0xf
#E8E6020000# ; call 0x405944
#FF7510# ; push qword ptr [rbp + 0x10]
#6A05# ; push 5
#E8DC020000# ; call 0x405944
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
#0F8F71000000# ; jg 0x405700
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883F807# ; cmp rax, 7
#0F8E2B000000# ; jle 0x4056c8
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C0A000000# ; jl 0x4056b5
#FF7518# ; push qword ptr [rbp + 0x18]
#6A41# ; push 0x41
#E88F020000# ; call 0x405944
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883E808# ; sub rax, 8
#48894510# ; mov qword ptr [rbp + 0x10], rax
#6A01# ; push 1
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C1E000000# ; jl 0x4056f4
#FF7518# ; push qword ptr [rbp + 0x18]
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#48C1E003# ; shl rax, 3
#50# ; push rax
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C040# ; add rax, 0x40
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E850020000# ; call 0x405944
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#C9# ; leave
#C21800# ; ret 0x18
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F804# ; cmp rax, 4
#0F850A000000# ; jne 0x405718
#68E0000000# ; push 0xe0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F805# ; cmp rax, 5
#0F850A000000# ; jne 0x405730
#68F0000000# ; push 0xf0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F806# ; cmp rax, 6
#0F850A000000# ; jne 0x405748
#68D8000000# ; push 0xd8
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F807# ; cmp rax, 7
#0F850A000000# ; jne 0x405760
#68D0000000# ; push 0xd0
#58# ; pop rax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C2B000000# ; jl 0x405799
#FF7518# ; push qword ptr [rbp + 0x18]
#6A48# ; push 0x48
#E8CC010000# ; call 0x405944
#FF7518# ; push qword ptr [rbp + 0x18]
#68F7000000# ; push 0xf7
#E8BF010000# ; call 0x405944
#FF7518# ; push qword ptr [rbp + 0x18]
#FF7510# ; push qword ptr [rbp + 0x10]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#5F# ; pop rdi
#4801F8# ; add rax, rdi
#50# ; push rax
#E8AB010000# ; call 0x405944
#6A03# ; push 3
#58# ; pop rax
#C9# ; leave
#C21800# ; ret 0x18
#C8100000# ; enter 0x10, 0
#31C0# ; xor eax, eax
#488945F8# ; mov qword ptr [rbp - 8], rax
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C5E000000# ; jl 0x405816
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4881C0E0000000# ; add rax, 0xe0
#488945F8# ; mov qword ptr [rbp - 8], rax
#FF7518# ; push qword ptr [rbp + 0x18]
#6A48# ; push 0x48
#E873010000# ; call 0x405944
#FF7518# ; push qword ptr [rbp + 0x18]
#68D3000000# ; push 0xd3
#E866010000# ; call 0x405944
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F80F# ; cmp rax, 0xf
#0F850B000000# ; jne 0x4057f7
#FF7518# ; push qword ptr [rbp + 0x18]
#FF75F8# ; push qword ptr [rbp - 8]
#E84D010000# ; call 0x405944
#488B4520# ; mov rax, qword ptr [rbp + 0x20]
#4883F810# ; cmp rax, 0x10
#0F8511000000# ; jne 0x405816
#FF7518# ; push qword ptr [rbp + 0x18]
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C008# ; add rax, 8
#50# ; push rax
#E82E010000# ; call 0x405944
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
#0F8438000000# ; je 0x40587c
#488B4518# ; mov rax, qword ptr [rbp + 0x18]
#4883F800# ; cmp rax, 0
#0F8C10000000# ; jl 0x405862
#FF7518# ; push qword ptr [rbp + 0x18]
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#0FB600# ; movzx eax, byte ptr [rax]
#50# ; push rax
#E8E2000000# ; call 0x405944
#488B4510# ; mov rax, qword ptr [rbp + 0x10]
#4883C001# ; add rax, 1
#48894510# ; mov qword ptr [rbp + 0x10], rax
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#4883C001# ; add rax, 1
#488945F8# ; mov qword ptr [rbp - 8], rax
#EBB7# ; jmp 0x405833
#488B45F8# ; mov rax, qword ptr [rbp - 8]
#C9# ; leave
#C21000# ; ret 0x10
*4C00 ; repeat 76 x 00
#415A# ; pop r10
#5F# ; pop rdi
#4152# ; push r10
#6A0C# ; push 0xc
#58# ; pop rax
#0F05# ; syscall
#C3# ; ret
#415A# ; pop r10
#5F# ; pop rdi
#4152# ; push r10
#6A03# ; push 3
#58# ; pop rax
#0F05# ; syscall
#C3# ; ret
#415A# ; pop r10
#5F# ; pop rdi
#4152# ; push r10
#6A55# ; push 0x55
#58# ; pop rax
#68FF010000# ; push 0x1ff
#5E# ; pop rsi
#0F05# ; syscall
#C3# ; ret
#415A# ; pop r10
#5F# ; pop rdi
#4152# ; push r10
#6A3C# ; push 0x3c
#58# ; pop rax
#0F05# ; syscall
#F4# ; hlt
'AZ_ARj' #00# ; text
#4889E6# ; mov rsi, rsp
#6A01# ; push 1
#5A# ; pop rdx
#4831C0# ; xor rax, rax
#0F05# ; syscall
#5A# ; pop rdx
#4885C0# ; test rax, rax
#0F8403000000# ; je 0x405921
#4889D0# ; mov rax, rdx
#C3# ; ret
#415A# ; pop r10
#5E# ; pop rsi
#5F# ; pop rdi
#4152# ; push r10
#6A02# ; push 2
#58# ; pop rax
#0F05# ; syscall
#C3# ; ret
#415A# ; pop r10
#5E# ; pop rsi
#4152# ; push r10
#56# ; push rsi
#4889E6# ; mov rsi, rsp
#6A01# ; push 1
#5A# ; pop rdx
#6A01# ; push 1
#5F# ; pop rdi
#6A01# ; push 1
#58# ; pop rax
#0F05# ; syscall
#58# ; pop rax
#C3# ; ret
#415A# ; pop r10
#5E# ; pop rsi
#5F# ; pop rdi
#4152# ; push r10
#56# ; push rsi
#4889E6# ; mov rsi, rsp
#6A01# ; push 1
#5A# ; pop rdx
#6A01# ; push 1
#58# ; pop rax
#0F05# ; syscall
#58# ; pop rax
#C3# ; ret

!
