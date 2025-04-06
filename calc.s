	# header declaring intel syntax
	.intel_syntax noprefix
	# opening up the data section
	.section .data
	# initialize somewhere in memory to hold the final value of rax
finalRax:
	.quad 0x0
	# opening up the text section
	.section .text
	.global _start
	.global CALC_DATA_BEGIN, CALC_DATA_END, and_func, or_func, shl_func, lower_func

_start:
	#intialize rax to zero
	xor rax, rax
	# initializes the value of sumneg and sumpos to zero
	mov QWORD PTR [SUM_POSITIVE], 0
	mov QWORD PTR [SUM_NEGATIVE], 0
	# initializes rbx to address of CALC_DATA_BEGIN
	mov rbx, OFFSET [CALC_DATA_BEGIN]
	# begin the loop
	jmp loop_start

	# start of the loop
loop_start:
	# checks if the first byte of the current command is zero
	cmp BYTE PTR [rbx], 0x0
	# if it is zero, jump to exit loop and program
	je loop_end

	#checks if command is lower
	cmp BYTE PTR [rbx], 'U'
	je if_lower
	
	# checks if command is and
	cmp BYTE PTR [rbx], '&'
	# jumps to call and if it is
	je if_and
	# checks if command is or
	cmp BYTE PTR [rbx], '|'
	# jumps to call or if it is
	je if_or
	# checks if command is shl
	cmp BYTE PTR [rbx], '<'
	# jumps to call shl if it is
	je if_shl
	

	# end of the loop
loop_end:
	# writing to stdout
	
	# to write the final value of rax
	mov QWORD PTR [finalRax], rax
	# start write syscall
	mov rax, 1
	# stdout should be 1
	mov rdi, 1
	# address of data to send
	mov rsi, OFFSET [finalRax]
	# length of data
	mov rdx, 8
	syscall

	# to write the final value of SUM_POSITIVE
	# to start write syscall
	mov rax, 1
	# stdout should be 1
	mov rdi, 1
	# address of data to send
	mov rsi, OFFSET [SUM_POSITIVE]
	# length of data
	mov rdx, 8
	syscall

	# to write the final value of SUM_NEGATIVE
	# to start write syscall
	mov rax, 1
	# stdout should be 1
	mov rdi, 1
	# address of data to send
	mov rsi, OFFSET [SUM_NEGATIVE]
	# length of data
	mov rdx, 8
	syscall

	
	# to write the memory between CALC_DATA_BEGIN and CALC_DATA_END
	mov r9, OFFSET [CALC_DATA_END]
	mov r8, OFFSET [CALC_DATA_BEGIN]
	sub r9, r8
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET [CALC_DATA_BEGIN]
	mov rdx, r9
	syscall
	
	# to exit program
	# exit syscall w a retun value of 0
	mov rax, 60
	mov rdi, 0
	syscall

	
	# call to and
if_and:
	# advances to the argument
	add rbx, 8
	# calls the function
	call and_func
	# jumps back to the start of the loop
	jmp loop_start
# call to or
if_or:
	add rbx, 8
	call or_func
	jmp loop_start
# call to shl
if_shl:
	add rbx, 8
	call shl_func
	jmp loop_start

# call to lower
if_lower:
	# moves the current address into finalrax to hold it
	mov QWORD PTR [finalRax], rbx
	add rbx, 8
	# finds address
	mov rbx, QWORD PTR [rbx]
	call lower_func
	# puts the current address back in rbx
	mov rbx, QWORD PTR [finalRax]
	# advances rbx
	add rbx, 16
	jmp loop_start
