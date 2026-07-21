sol 1
org 8392704
enter 4

extern open
extern read

global orgone_image_base
orgone_image_base:
  push c
  push d

  addr a, orgone_end
  ld d, [a]
  add a, a, 8
  mov c, a
  add c, c, d
  st [fp - 1w], c

  push a
  push c
  addr a, dict_path
  push a
  mov d, 0
  push d
  call open
  pop c
  pop d
  push d
  push c
  push a
  push c
  mov d, 8192
  push d
  call read
  pop c
  pop a

  addr b, orgone_image_base
  mov d, 0
  push d

loop:
  ldb c, [a]
  add a, a, 1
  mov d, c
  sub d, d, 128
  bnz d, emit
  ldb c, [a]
  add a, a, 1
  mov d, c
  sub d, d, 254
  bz d, emit_80
  mov d, c
  sub d, d, 253
  bz d, ret_rule
  push a
  shl c, c, 5
  ld d, [fp - 1w]
  mov a, d
  add a, a, c
  jmp loop

emit_80:
  mov c, 128

emit:
  stb [b], c
  add b, b, 1
  jmp loop

ret_rule:
  pop a
  bnz a, loop

enter_payload:
  pop d
  pop c
  mov b, 1330073137
  addr a, orgone_image_base
  jmp a

dict_path: db "/lib/orgone.dct", 0

global orgone_end
orgone_end:
