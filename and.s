	# header declaring intel syntax
	.intel_syntax noprefix
	# opening up the data section
	.section .text
	# starting the program
	.global and_func
and_func:
	# ands the VALUE stored in rbx and rax and stores in rax
	AND rax, QWORD PTR [rbx]
	# adds 8 to rbx to advance
	add rbx, 8
	# to end the program
	ret
