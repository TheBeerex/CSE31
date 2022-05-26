        .data

str1: .asciiz "Please enter an integer: "

        .text
main: 		addi 	$sp, $sp, -4	# Moving stack pointer to make room for storing local variables (push the stack frame)
		# display input prompt
		la 	$a0, str1
		addi 	$v0, $zero, 4
		syscall
		# read user input
		addi 	$v0, $zero, 5
		syscall
		move 	$a0, $v0
		addi	$v0, $zero,0
		jal recursion	# Call recursion(x)
		# print out returned value
		move 	$a0, $v0
		addi 	$v0, $zero, 1
		syscall
		j end		# Jump to end of program


recursion:	addi 	$sp, $sp, -12	# Push stack frame for local storage

		# save $ra
		sw 	$ra, 0($sp)
		
		bne 	$a0, 10, not_equal_ten
		
		# update returned value
		addi	$v0, $v0, 2
		
		j end_recur
			
not_equal_ten:	bne 	$a0, 11, not_equal_eleven

		# update returned value
		addi 	$v0, $v0, 1
		
		j end_recur		

not_equal_eleven:sw 	$a0, 4($sp) 	
		# Prepare new input argument, i.e. m + 2
		addi 	$a0, $a0, 2
		
		
		jal recursion	# Call recursion(m + 2)
		
		lw 	$a0, 4($sp)
		
		# Prepare new input argument, i.e. m + 1
		addi 	$a0, $a0, 1
		
		jal recursion	# Call recursion(m + 1)
		
		# TPS 2 #14 (update returned value)
		lw 	$a0, 4($sp)
		
		add $v0, $v0, $a0
		
		j end_recur
		

# End of recursion function	
end_recur:	# TPS 2 #15 
		lw 	$ra, 0($sp)
		addi 	$sp, $sp, 12	# Pop stack frame 
		jr 	$ra

# Terminating the program
end:		addi 	$sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li 	$v0, 10 
		syscall
