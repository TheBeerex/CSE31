	.data

n:	.word		25
str1: 	.asciiz 	"Less than\n"
str2: 	.asciiz 	"Less than or equal to\n"
str3: 	.asciiz 	"Greater than\n"
str4: 	.asciiz		"Greater than or equal to\n"

	.text
main:		
		# Getting user input
    		li $v0, 5
    		syscall

    		# Moving the integer input to another register
    		move $t0, $v0
    		
    		# Load n into #$t1
    		la $t2, n
    		lw $t1, 0($t2)
    		
    		# If integer is less than n
    		blt $t0, $t1, less
    		
    		# If integer is greater than or equal to n
    		bge $t0, $t1, grtrEq
    		
    		# If integer is greater than n
    		#bgt $t0, $t1, grtr
    		
    		# If integer is less than or equal to n
    		#ble $t0, $t1, lessEq
    		
    		j finish
    		
less:
		li      $v0, 4      	# code 4 == print string
		la      $a0, str1  	# $a0 == address of the string
		syscall            	# Ask the operating system to 
		j finish

grtrEq:
		li      $v0, 4      	# code 4 == print string
		la      $a0, str4  	# $a0 == address of the string
		syscall            	# Ask the operating system to 
		j finish

lessEq:
		li      $v0, 4      	# code 4 == print string
		la      $a0, str2  	# $a0 == address of the string
		syscall            	# Ask the operating system to 
		j finish

grtr:
		li      $v0, 4      	# code 4 == print string
		la      $a0, str3  	# $a0 == address of the string
		syscall            	# Ask the operating system to 
		j finish

finish:		li      $v0, 10	
		syscall	
