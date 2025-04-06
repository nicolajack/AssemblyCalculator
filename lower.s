	# header declaring intel syntax
	.intel_syntax noprefix
	# opening up the text section
	.section .text
	# starting the program
	.global lower_func

lower_func:
	xor rdi, rdi
	
loop_start:	
	# checks to see if first byte is 0
	cmp BYTE PTR [rbx + rdi], 0x0
	# if it is jumps to end of loop
	je loop_end

	# compares first byte to A
	cmp BYTE PTR [rbx + rdi], 'A'
	# if it is less than A its not uppercase letter, so moves to next byte
	jl next_byte
	# compares first byte to Z
	cmp BYTE PTR [rbx + rdi], 'Z'
	# if it is greater than Z its not upeprcase letter, so moves to next byte
	jg next_byte

	# at this point the character has to be uppercase letter, so alters it
	# add 20 to it to make it lowercase
	add BYTE PTR [rbx + rdi], 0x20
	# inc rdi to keep track of length of string
	inc rdi
	# jump back into loop
	jmp loop_start
	
next_byte:
	# at this point, the character is NOT an uppercase letter, so we move onto next byte
	# inc rdi to keep track of length of string and advance to next byte
	inc rdi
	# jump back into loop
	jmp loop_start
	
loop_end:
	# adds the length of the string into rax
	add rax, rdi
	# to end the program
	ret
