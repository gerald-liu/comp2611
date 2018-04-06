          	.data
 msg0:   	.asciiz "Adding numbers:\n"
 msg1:   	.asciiz "A? "
 msg2:   	.asciiz "B? "
 result:   	.asciiz "Sum = "
 newline:	.asciiz "\n"
          	.text
          	.globl __start
 __start:

 # Print "Adding numbers\n"
         la $a0, msg0
         li $v0, 4
         syscall

 # Print "A? "
         la $a0, msg1
         li $v0, 4
         syscall

 # Get the value for A (store in $v0)
         li $v0, 5
         syscall

 # Move $v0 to $t0: $t0 = 0 + $v0
         add $t0, $zero, $v0
 
 # Print "B? "
         la $a0, msg2
         li $v0, 4
         syscall
 
 # Get the value for B (store in $v0)
         li $v0, 5
         syscall
 
 # Add A and B: $t0 = $t0 + $v0
         add $t0, $t0, $v0
 
 # Print "The sum is "
         la $a0, result
         li $v0, 4
         syscall
 
 # Print result ($t0 is the result)
         add $a0, $zero, $t0 
         li $v0, 1
         syscall
 
 # Print a new line
         la $a0, newline
         li $v0, 4
         syscall
 
 # Terminate the program
         li $v0, 10
         syscall

