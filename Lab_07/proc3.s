		.data

x:		.word 2
y:		.word 3
z:		.word 4

		.text
MAIN:	# z = x + y + z + foo(x, y, z);
    	# printf("%d\n", z);
    	
	la $t0, x
	lw $s0, 0($t0)		# s0 = x
	la $t0, y
	lw $s1, 0($t0)		# s1 = y
	la $t0, z
	lw $s2, 0($t0)		# s2 = z
	
	add $a0, $zero, $s0	# $a0 = $s0
	add $a1, $zero, $s1	# $a1 = $s1
	add $a2, $zero, $s2	# $a2 = $s2
	
	# save $s0, $s1, $s2 to memory
	addi $sp, $sp, -4
	sw $a0, 0($sp)		# Backup a0 from MAIN
	addi $sp, $sp, -4	
	sw $a1, 0($sp)		# Backup a1 from MAIN
	addi $sp, $sp, -4	
	sw $a2, 0($sp)		# Backup a2 from MAIN
	
	jal FOO			# $v0 = foo(x, y, z)
	
	# reload $s0, $s1, $s2 from memory
	lw $s2, 0($sp)		# Load a2 from MAIN
	addi $sp, $sp, 4
	lw $s1, 0($sp)		# Load a1 from MAIN
	addi $sp, $sp, 4
	lw $s0, 0($sp)		# Load a0 from MAIN
	addi $sp, $sp, 4
	
	# z = x + y + z + foo(x, y, z);
	# $s2 = $s0 + $s1 + $s2 + $v0
	add $s2, $s2, $s0
	add $s2, $s2, $s1
	add $s2, $s2, $v0
	
	move $a0, $s2 		# print z
	addi $v0, $zero, 1
	syscall
	
	j END

FOO:	# int p = bar(m + n, n + o, o + m);
    	# int q = bar(m - o, n - m, 2 * n);
    	# return p + q;
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)		# Backup ra from MAIN
	
	# m = $a0
	# n = $a1
	# o = $a2
	
	add $t0, $a0, $a1	# $t0 = m+n
	add $t1, $a1, $a2	# $t1 = n+o
	add $t2, $a2, $a0	# $t2 = o+m
	
	move $a0, $t0 		# $a0 = $t0
	move $a1, $t1 		# $a1 = $t1
	move $a2, $t2 		# $a2 = $t2
	
	jal BAR
	move $s0, $v1		# p = $s0
	
	# reload m, n, o
	lw $a2, 4($sp)		# Load a2 from MAIN
	lw $a1, 8($sp)		# Load a1 from MAIN
	lw $a0, 12($sp)		# Load a0 from MAIN
	
	sub $t0, $a0, $a2 	# $t0 = m-o
	sub $t1, $a1, $a0	# $t1 = n-m
	mul $t2, $a1, 2		# $t2 = 2*n
	
	move $a0, $t0 		# $a0 = $t0
	move $a1, $t1 		# $a1 = $t1
	move $a2, $t2 		# $a2 = $t2
	
	jal BAR
	move $s1, $v1		# q = $s1

	add $v0, $s0, $s1 	# $v0 = p+q
	
	
	lw $ra, 0($sp)		# Restore ra from MAIN
	addi $sp, $sp, 4
	
	jr $ra

BAR:	# "return c - a << b"

	# a = $a0
	# b = $a1
	# c = $a2
	
	sub $v1, $a2, $a0 	# $v1 = c - a
	sllv $v1, $v1, $a1 	# $v1 = $v1 << b
	
	jr $ra

END:
