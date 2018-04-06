#------- DATA SEGMENT ----------------
	.data
msg1: .asciiz "This is caller function 1\n"
msg2: .asciiz "This is callee function 1\n"


#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:


# Main function (caller function 1) starts here
	la $a0, msg1
	li $v0, 4
	syscall
	jal callee1       # call function callee1

# Terminate the program
	li $v0, 10
	syscall

### End of main function

### void callee1( )
callee1:
	la $a0, msg2
	li $v0, 4
	syscall
	jr $ra # return to caller function 1 (main)

### End of function callee1


