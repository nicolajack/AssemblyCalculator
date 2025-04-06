	# header declaring intel syntax
	.intel_syntax noprefix
	# opening up text section
	.section .text
	# declaring the start label, OR_FRAG
	.global or_func
or_func:
	# bitwise or rax and the value stored in rbx
	OR rax, QWORD PTR [rbx]
	# adds 8 to rbx to advance
	add rbx, 8
	# returning the call
	ret
