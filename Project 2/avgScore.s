.data 

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100

str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded up) with dropped scores removed: "

.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp -4
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	move $s0, $v0	# $s0 = numScores
	move $t0, $0
	la $s1, orig	# $s1 = orig
	la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	jal printArray	# Print sorted scores
	
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	move $a1, $v0
	sub $a1, $s0, $a1	# numScores - drop
	move $a0, $s2
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Your code here to compute average and print it
	div $v0, $a1
	mflo $t0
	mfhi $t1
	beq $t1, 0, zeroRem
	nop
	addi $t0, $t0, 1
zeroRem:
	la $a0, str5
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	li $v0, 11
    	li $a0, 10 # ASCII value of a newline is "10"
    	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10 
	syscall
	
	
# printList takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.
printArray:
	# Your implementation of printList here	
	# $a0 contains address of the array
	# $a1 contains array size
	add $t0, $zero, $zero
	move $t1, $a0
loop:	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	li $v0, 11
	li $a0, 32 # ASCII value of a space is " "
	syscall
		
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	bne $t0, $a1, loop
	nop
	
	li $v0, 11
    	li $a0, 10 # ASCII value of a newline is "10"
    	syscall

	jr $ra
	
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	# Your implementation of selSort here
	
	# When here, user has input every score on to the stack
	# First, copy unsorted array to sorted array
	la $t0, orig
	la $t1, sorted
	add $t2, $zero, $zero # t2 to keep track of how many function has copied over
	
	copyLoop:
		# If the number of grades copied is equal to the number input, don't loop again
		beq $t2, $s0, copied
		nop
		lw $t3, 0($t0) # load to $t3 the value stored at currently pointed to in orig
		sw $t3, 0($t1) # load to the respective spot in sorted currently pointed to in orig
		
		# Move orig and sorted pointers by one word
		addi $t0, $t0, 4 
		addi $t1, $t1, 4
		# Note that function has transfered a number
		addi $t2, $t2, 1
		j copyLoop
		nop
	
	copied:
	# Then sort the sorted arary in place
	la $t0, sorted # One copy of the beginning address to keep track of where func is when looking for max
	la $t1, sorted # One copy of the beginning address to keep track of the beginning of what isn't sorted yet
	add $t2, $zero, $zero # t2 to keep track of how many grades function has sorted
	add $t3, $zero, $zero # t3 to keep track of when function has hit the end of the unsorted array
	add $t4, $zero, $zero # t4 to keep track of the largest encountered so far
	add $t5, $zero, $zero # t5 to keep track of the location of the largest
	# t6 to store what's currently being looked at, and to store a value for swapping largest with where it needs to go
	
	sortLoop:
		beq $t2, $s0, sortLoopExit # If the number of sorted grades is equal to the number of grades; don't loop
		nop
		
		# Find the largest in the unsorted part of the array
		findLargestLoop:
			beq $t3, $s0, findLargestLoopExit # If past the end of the array, don't loop
			nop
			# Load number currently being looked at to $t6
			lw $t6, 0($t0)
			# Check if what's being looked at is larger
			blt $t6, $t4, isLesser # If what's being looked at is smaller, jump to pointer manipulation
			
			# If here, what's being looked at is larger
			# Copy new larger number into current largest
			add $t4, $t6, $zero
			# Copy location of the new largest  into current largest
			add $t5, $t0, $zero
			# Can fall through to pointer manipulation now
			
			isLesser:
			addi $t0, $t0, 4
			addi $t3, $t3, 1
			
			j findLargestLoop
			nop
			
		findLargestLoopExit:
		# Copy value from where largest needs to go to $t6
		lw $t6, 0($t1)
		# Copy value from largest to that location
		sw $t4, 0($t1)
		# Copy temp value into where the largest was
		sw $t6, 0($t5)
		
		# Move beginning of the unsorted part of the array up by a spot
		add $t1, $t1, 4
		# Reset $t0 to $t1
		add $t0, $t1, $zero
		# Add one to the count of the number of grades sorted
		add $t2, $t2, 1
		# Reset t3 for loop; change it to $t2
		add $t3, $t2, $zero
		# Reset t4 for loop
		add $t4, $zero, $zero
		
		
		j sortLoop
		nop
	
	sortLoopExit:
	
	jr $ra

# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	# Your implementation of calcSum here
	# $a0 = address of sorted array
	# $a1 = numScores - drop
	addi $v0, $zero, 0
	addi $sp, $sp, -4
	sw $a1, 0($sp)
recur:
	bgt $a1, 0, greater
	nop
	lw $a1, 0($sp)
	addi $sp, $sp, 4
	jr $ra
greater:
	addi $a1, $a1, -1
	mul $t0, $a1, 4
	add $t0, $a0, $t0
	lw $t0, 0($t0)
	add $v0, $v0, $t0
	j recur
	nop
