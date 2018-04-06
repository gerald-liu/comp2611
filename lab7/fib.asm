.data
msgI: .asciiz "Enter the index n (-1 to exit):"
msgO: .asciiz "The Fibonacci number fib(n) = "
endl: .asciiz "\n"
msgE: .asciiz "Program exited."

.text
.globl main

main:
	# ask for index n                 
	li	$v0, 4                
	la	$a0, msgI
	syscall

	# print n
	li	$v0, 5
	syscall

	li	$t0, -1
	beq	$v0, $t0, exit

	addi	$a0, $v0, 0
	jal	fibonacci

	# output the result
	addi	$sp, $sp, -4
	sw	$v0, 0($sp)

	li	$v0, 4                
	la	$a0, msgO
	syscall

	lw	$v0, 0($sp)
	addi	$sp, $sp, 4
	add	$a0, $v0, $zero
	li	$v0, 1
	syscall
	
	li	$v0, 4                
	la	$a0, endl
	syscall
	
	j	main

exit:
	# terminate
	li	$v0, 4                
	la	$a0, msgE
	syscall
	
	li	$v0, 10
	syscall

fibonacci:
	beq	$a0, $0, base		# if n == 0
	addi	$t0, $0, 1		# $t0 = 1
	beq	$a0, $t0, base		# else if n == 1
	
	# push to stack
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	sw	$a0, 0($sp)
	
	addi	$a0, $a0, -1		# $a0 = n - 1
	jal	fibonacci		# $v0 = fib(n-1)
	addi	$sp, $sp, -4
	sw	$v0, 0($sp)		# store fib(n-1)
	
	lw	$a0, 4($sp)		# $a0 = n
	addi	$a0, $a0, -2		# $a0 = n - 2
	jal	fibonacci		# $v0 = fib(n-2)
	
	# pop from stack
	lw	$t0, 0($sp)		# $t0 = fib(n-1)
	lw	$a0, 4($sp)		# $a0 = n
	lw	$ra, 8($sp)
	addi	$sp, $sp, 12
	
	add	$v0, $t0, $v0		# $v0 = fib(n-1) + pascal(n-2)
	jr	$ra
	
	base:
	addi	$v0, $a0, 0		# $v0 = n
	jr	$ra
