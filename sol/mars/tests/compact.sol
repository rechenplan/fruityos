sol 1
org 0

global compact
compact:
enter 4
st [fp - 2w], z
st [fp - 3w], z
mov a, 7
eq a, a, b
bz a, done
addr a, done
jmp done
done:
ret 0
