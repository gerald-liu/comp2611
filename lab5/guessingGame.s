# A program to randomly pick a lucky number (between 1 to 100) and to ask the user to guess it.  
# You may assume the user always gives valid input

.data
# lower and upper bounds of the lucky number
lowBound: .word 1
highBound: .word 100


# your code begins here

# define the strings for any output messages


# your code ends here
 

.text
.globl main

main:	# use syscall of code 30 to get the current time as the number of milliseconds from Jan. 1, 1970. The returned number is in 64 bits (lower 32 bits in $a0 and higher 32 bits in $a1)
	# you don't need to know the syscall code 30 but can see the MIPS->Syscalls tab in MARS help manual for its details. 
	li $v0, 30
	syscall 

	# use syscall of code 40 to set the seed of a random number generator. The lower 32 bits of the current time is used for the seed.
	# you don't need to know the syscall code 40 but can see the MIPS->Syscalls tab in MARS help manual for its details. 
	li $v0, 40
	addi $a1, $a0, 0
	li $a0, 1
	syscall

	la $t0, lowBound
	lw $s0, 0($t0)
	la $t1, highBound
	lw $s1, 0($t1)
	li $s5, 0            # keep the number of guesses input so far

	# get the range of the bounds  
	sub $t0, $s1, $s0
	addi $t0, $t0, 1

	# use syscall of code 42 to get a random number (returned in $a0) from the range [0, $a1).
	# you don't need to know the syscall code 42 but can see the MIPS->Syscalls tab in MARS help manual for its details. 
	li $v0, 42
	li $a0, 1
	addi $a1, $t0, 0
	syscall

	add $s2, $a0, $s0   # (random number + lower bound) yields the lucky number in the specified bounds.

guessLoop: 
	# your code begins here

	# ouput the number of guesses ($s5) input so far;


	# output the possible range (s0 and s1) of the lucky number as the guess hint for the user;
	

	# ask the user to enter a guess of the lucky number;


	# read the input number and store it in $v0.


	# update the number of guesses ($5)



	# assuming the input number is within the range in output, update the range for the next output   
	# if input number ($v0) less than lucky number, update the lower bound
	# if input number ($v0) greater than lucky number, update upper bound
	# then goto guessLoop to ask user input again
	


	# if the user's guess is correct	
	# output congratulation message and exit the program.


	

	# further work if you work out the basic guessingGame.s successfully and want more challenge
	# user input validation
	# two-player mode	  
