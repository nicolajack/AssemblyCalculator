	# setting up the file w intel syntax
	.intel_syntax noprefix
	# opening up the data section
	.section .data
	.global SUM_POSITIVE
	.global SUM_NEGATIVE
SUM_POSITIVE:
	.quad 0x0
SUM_NEGATIVE:
	.quad 0x0
	# opening up the text section
	.section .text
	# declaring the start of shl
	.global shl_func
shl_func:	
	# preparing to shift by rbx by storing the value of rbx in rcx
	MOV rcx, QWORD PTR [rbx]
	# shifting rax by the value in rbx
	SHL rax, cl
	# test to see if y is positive
	CMP rcx, 0x0
	# if it is, then there is no sign flag, so jump to if_pos code
	JNS if_pos
	# if there is a sign flag y is positive, so jump to if_neg code
	JS if_neg
if_pos:
	# done, so jump to exit program
	ADD QWORD PTR [SUM_POSITIVE], rcx
	JMP all_done
if_neg:
	# done, so jump to exit program
	ADD QWORD PTR [SUM_NEGATIVE], rcx
	JMP all_done

all_done:
	# adds 8 to rbx to advance
	add rbx, 8
	# returning the call
	ret
