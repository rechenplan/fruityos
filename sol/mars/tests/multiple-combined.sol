sol 1
org 0x100000000
enter 0
mov a, 41
call helper
ret 0
helper:
enter 0
add a, a, 1
ret 0
