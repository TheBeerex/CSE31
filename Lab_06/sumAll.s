	.data

input:	.asciiz 	"Please enter a number: "
evens:	.asciiz 	"Sum of even numbers is: "
odds:	.asciiz 	"Sum of odd numbers is: "
endl:	.asciiz		"\n"
	.text

main:		
		
		
		j while
		nop
		
while:		# $t1 odds, $t2 evens
		li      $v0, 4 
		la      $a0, input
		syscall
		
		# get input from user
		li 	$v0, 5
    		syscall
    		move 	$t3, $v0
    		
    		beq	$t3, 0, finish # ends if input is 0
    		
		abs	$t4, $t3
    		
		j evenOrOdd
		nop

evenOrOdd:
		beq $t4, 0, even
		nop
		
		beq $t4, 1, odd
		nop
		
		subi $t4, $t4, 2
		
		j evenOrOdd
		nop
		
even:
		add $t2, $t2, $t3
		j while
		nop
		
odd:
		add $t1, $t1, $t3
		j while
		nop
		
finish:		
		li      $v0, 4 
		la      $a0, endl
		syscall
		
		# Print sums
		li      $v0, 4 
		la      $a0, evens
		syscall
		li	$v0, 1
		add 	$a0, $zero, $t2
		syscall
		li      $v0, 4 
		la      $a0, endl
		syscall
		
		li      $v0, 4 
		la      $a0, odds
		syscall
		li	$v0, 1
		add 	$a0, $zero, $t1
		syscall
		li      $v0, 4 
		la      $a0, endl
		syscall
		
		
		# Ends program
		li      $v0, 10	
		syscall	