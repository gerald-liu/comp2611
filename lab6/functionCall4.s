#------- DATA SEGMENT ----------------
	.data


#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:


# Main function starts here
	li $s0, 5
	li $s1, 6
	li $a0, 1    # pass function arguments
	li $a1, 2
	li $a2, 3
	li $a3, 4	

	addi $sp, $sp, -8  # pass extra function arguments using the stack 
	sw $s0, 0($sp)
	sw $s1, 4($sp)
     
	jal addNum         
	add $a0, $v0, $zero      # output the return value ($v0 = 21)
	li $v0, 1
	syscall

# Terminate the program
	li $v0, 10
	syscall

### void addNum(int, int, int, int, int, int)
addNum:
	lw $t0, 0($sp)  # load the extra arguments from stack
	lw $t1, 4($sp)
	
	# restore sp to remove the stack frame of the function call
	# no need to load the arguments back to registers (s0 and s1)
	addi $sp, $sp, 8   

	add $t2, $a0, $a1  # $t2 = 1+2 = 3
	add $t3, $a2, $a3  # $t3 = 3+4 = 7
	add $t4, $t0, $t1  # $t4 = 5+6 = 11
	add $v0, $t2, $t3  # $v0 = 3+7 = 10
	add $v0, $v0, $t4  # $v0 = 10 + 11 = 21

	jr $ra            

