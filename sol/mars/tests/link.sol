sol 1

global sol_entry
global sol_end
extern asm_helper

sol_entry:
  enter 0
  addr b, asm_helper
  call b
  ret 0
sol_end:
