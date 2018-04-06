#------- DATA SEGMENT ----------------
	.data
msg1:   .asciiz "Please input A:"
msg2:   .asciiz "Please input B:"

#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:

# Main function starts here

# Ask the user to input A
	


# Read the input and assign to $a0



# preserve $a0 as it will be overwritten by the start address of string


# Ask the user to input B



# Read the input and assign to $a1



# restore the value of $a0



    
	jal addNum       # call a function that adds two numbers 
	add $a0, $v0, $zero      # output the return value 
	li $v0, 1
	syscall

# Terminate the program
	li $v0, 10
	syscall

### void addNum(int, int)
addNum:
# add $a0 and $a1 

# return the value to main function

