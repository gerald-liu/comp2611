#------- DATA SEGMENT ----------------
	.data


#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:


# Main function starts here
	li $a0, 7          
	li $a1, 4
     
	jal compute        # call a function that adds its two argument numbers and their difference together
	add $a0, $v0, $zero      # output the return value (14)
	li $v0, 1
	syscall

# Terminate the program
	li $v0, 10
	syscall

### void compute(int, int)
compute:
	addi $sp, $sp, -4  # preserve ra since this function will call another function
	sw $ra, 0($sp)

	addi $sp, $sp, -4  # save "non-preserve" register (in caller function) whose value will still be needed after calling a function.
	sw $a0, 0($sp)
	sub $a0, $a0, $a1  # a0 is overwritten by a0 - a1 (i.e. ($a0 = 7-4 = 3)
	
	jal addNum  

	lw $a0, 0($sp)     # restore the original value of a0 ($a0 = 7)
	addi $sp, $sp, 4


	add $a1, $v0, $zero      # #a1 = $v0 = 7 is returned from calling addNum
	
	jal addNum         # no need to preserve a0 or a1 since they are not needed after this call

	lw $ra, 0($sp)     
	addi $sp, $sp, 4
	jr $ra            # function returns


### void addNum(int, int)
addNum:
	add $v0, $a0, $a1  # First time call addNum $v0=3+4=7; Second time call addNum $v0=7+7=14
	jr $ra            # function returns
