#------- DATA SEGMENT ----------------
	.data
msgIA:   .asciiz "Please input A:"
msgIB:   .asciiz "Please input B:"

#------- TEXT SEGMENT ----------------
	.text
	.globl main

main:
	# ask for input A
	li	$v0, 4                
	la	$a0, msgIA
	syscall
	# read A
	li	$v0, 5
	syscall
	addi	$t0, $v0, 0	# $t0 = A
	
	# ask for input B
	li	$v0, 4                
	la	$a0, msgIB
	syscall
	# read B
	li	$v0, 5
	syscall
	addi	$a1, $v0, 0	# $a1 = B
	addi	$a0, $t0, 0	# $a0 = A
    
	jal addNum		# $v0 = A + B
	
	# output the return value
	addi	$a0, $v0, 0	# $a0 = A + B
	li	$v0, 1
	syscall

	# terminate the program
	li	$v0, 10
	syscall

# void addNum(int, int)
addNum:
	add	$v0, $a0, $a1	# $v0 = A + B
	jr	$ra