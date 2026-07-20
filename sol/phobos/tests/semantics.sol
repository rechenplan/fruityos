sol 1
org 0x100000000
enter 4

; mov must not use the abstract stack as hidden scratch memory
mov a, 85
st [sp - 8], a
mov a, 7
ld b, [sp - 8]
ne d, b, 85
bnz d, fail35

; arithmetic and aliasing
mov a, 20
mov b, 22
add c, a, b
ne d, c, 42
bnz d, fail1
add a, a, a
ne d, a, 40
bnz d, fail2
sub a, c, 2
ne d, a, 40
bnz d, fail3
mul a, 6, 7
ne d, a, 42
bnz d, fail4
div a, 127, 3
ne d, a, 42
bnz d, fail5
rem a, 128, 43
ne d, a, 42
bnz d, fail6
and a, 0x2a, 0x7f
ne d, a, 42
bnz d, fail7
or a, 40, 2
ne d, a, 42
bnz d, fail8
xor a, 40, 2
ne d, a, 42
bnz d, fail9
shl a, 21, 1
ne d, a, 42
bnz d, fail10
shr a, 84, 1
ne d, a, 42
bnz d, fail11

; comparisons
lt a, -1, 0
ne d, a, 1
bnz d, fail12
le a, 42, 42
ne d, a, 1
bnz d, fail13
gt a, 43, 42
ne d, a, 1
bnz d, fail14
ge a, 42, 42
ne d, a, 1
bnz d, fail15
eq a, 42, 42
ne d, a, 1
bnz d, fail16
ne a, 41, 42
ne d, a, 1
bnz d, fail17

; z destination must not clobber visible a or d
mov a, 100
mov d, 77
div z, 20, 3
ne b, a, 100
bnz b, fail18
ne b, d, 77
bnz b, fail19

; word and byte memory
mov a, 0x1122334455667788
st [fp - 8], a
ld b, [fp - 8]
ne d, a, b
bnz d, fail20
mov c, 42
stb [fp - 8], c
ldb b, [fp - 8]
ne d, b, 42
bnz d, fail21

; push captures pre-update sp
mov a, sp
push sp
pop b
ne d, a, b
bnz d, fail22

; pop sp commits after its implicit increment
mov a, sp
sub a, a, 8
push a
pop sp
add sp, sp, 8

; direct and indirect calls
mov a, 41
call add_one
ne d, a, 42
bnz d, fail23
addr d, add_one
mov a, 41
call d
ne d, a, 42
bnz d, fail24

; ip is the address of the next Sol operation
mov a, ip
after_ip:
addr b, after_ip
ne d, a, b
bnz d, fail25

; writing ip transfers control
addr a, ip_target
mov ip, a
jmp fail26
ip_target:

; jmp ip is fallthrough
jmp ip

; direct branch
bz z, direct_branch
jmp fail27
direct_branch:

; indirect branch
addr d, indirect_branch
bnz z, fail28
bz z, d
jmp fail29
indirect_branch:

; address and static data
addr a, data_word
ld b, [a]
ne d, b, 42
bnz d, fail30
addr a, data_bytes
ldb b, [a + 1]
ne d, b, 42
bnz d, fail31

; pseudo operations
neg a, -42
ne d, a, 42
bnz d, fail32
not a, -43
ne d, a, 42
bnz d, fail33
bool a, 42
ne d, a, 1
bnz d, fail34
nop

mov a, 0
ret 0

add_one:
enter 0
add a, a, 1
ret 0

fail1: mov a, 1
ret 0
fail2: mov a, 2
ret 0
fail3: mov a, 3
ret 0
fail4: mov a, 4
ret 0
fail5: mov a, 5
ret 0
fail6: mov a, 6
ret 0
fail7: mov a, 7
ret 0
fail8: mov a, 8
ret 0
fail9: mov a, 9
ret 0
fail10: mov a, 10
ret 0
fail11: mov a, 11
ret 0
fail12: mov a, 12
ret 0
fail13: mov a, 13
ret 0
fail14: mov a, 14
ret 0
fail15: mov a, 15
ret 0
fail16: mov a, 16
ret 0
fail17: mov a, 17
ret 0
fail18: mov a, 18
ret 0
fail19: mov a, 19
ret 0
fail20: mov a, 20
ret 0
fail21: mov a, 21
ret 0
fail22: mov a, 22
ret 0
fail23: mov a, 23
ret 0
fail24: mov a, 24
ret 0
fail25: mov a, 25
ret 0
fail26: mov a, 26
ret 0
fail27: mov a, 27
ret 0
fail28: mov a, 28
ret 0
fail29: mov a, 29
ret 0
fail30: mov a, 30
ret 0
fail31: mov a, 31
ret 0
fail32: mov a, 32
ret 0
fail33: mov a, 33
ret 0
fail34: mov a, 34
ret 0
fail35: mov a, 35
ret 0

align 8
data_word:
dq 42
data_bytes:
db 1, 42, 3
