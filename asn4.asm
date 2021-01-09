		.data
	
prompt1:	.asciiz "Enter the multiplicand: "
prompt2:	.asciiz "Enter the multiplier: "
times:		.asciiz " * "
equals:		.asciiz " = "

		.text
main:
		la $a0, prompt1
		li $v0, 4		# Prompt to enter multiplicand
		syscall
		
		li $v0, 5		# Read multiplicand
		syscall
		move $t0, $v0
	
		la $a0, prompt2	
		li $v0, 4		# Prompt to enter multiplier
		syscall
		
		li $v0, 5		# Read multiplier
		syscall
		move $a1, $v0		# Load in arguments
		move $a0, $t0	
		
		move $t1, $a1		# save original multiplier to print later	
		
		jal multiply		# call multiply
		
		move $t3, $v0		# store product
		
		la $a0, ($t0)		# print result
		li $v0, 1
		syscall
		la $a0, times
		li $v0, 4
		syscall
		la $a0, ($t1)
		li $v0, 1
		syscall
		la $a0, equals
		li $v0, 4
		syscall
		la $a0, ($t3)
		li $v0, 1
		syscall
		
		li $v0, 10		# exit program
		syscall
		
multiply:
		bnez $a1, recurse	# base condition: recur if the multiplier != 0
		li $v0, 0
		jr $ra			# return
		
recurse:
		sub $sp, $sp, 12	# store registers
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		addi $a1, $a1, -1	# subtract 1 from multiplier and recur
		jal multiply
		lw $a0, 4($sp)
		add $v0, $v0, $a0	# for each recursion, add multiplicand
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		jr $ra			# return
		
		
		
		
		
		
		
		
		
		
		
		
		