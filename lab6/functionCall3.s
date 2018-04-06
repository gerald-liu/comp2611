#------- DATA SEGMENT ----------------
	.data


#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:


# Main function (caller function) starts here
	li $s0, 4          # saving "preserve" registers is not needed in the very first function (main)
	li $s1, 3
	li $t0, 10
	add $t1, $s0, $t0   #$t1 = 14

	addi $sp, $sp, -4  # save "non-preserve" register (in caller function) whose value will still be needed after calling another function. t0 is not needed.
	sw $t1, 0($sp)
     
	jal callee              # call a function
	addi $t2, $v0, 0   # function returned 25 in v0 and 50 in v1   $t2=25
	add $t3, $v1, $zero      # t3 = 50

	lw $t1, 0($sp)     # restore saved register
	addi $sp, $sp, 4
	
	add $s2, $s1, $t1  # s2 = 17 (3 + 14)

# Terminate the program
	li $v0, 10
	syscall

### void callee( )
callee:
	addi $sp, $sp, -8  # save "preserve" registers (in callee function) that will be modified in this function
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	li $s0, 2
	li $s1, 3
	li $t0, 20
	add $t1, $s0, $t0  #$t1 = 22
	add $v0, $s1, $t1  #$v0 = 25
	add $v1, $v0, $v0  #$v1 = 50

	lw $s0, 0($sp)     # restore saved registers
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra             # function returns

