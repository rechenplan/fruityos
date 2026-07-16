bits 64
org 0x801000

_start:
	jmp __jabara_fap_start

__jabara_alloc:
	jmp jc_alloc
