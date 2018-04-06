#------- Data Segment ----------
.data
# Define the string messages and the primes array
mesg1:		.asciiz "Please enter an integer number(range: 1~100, enter 0 to end the program):"
mesg2:		.asciiz "-th prime is:"
mesg3: 		.asciiz "Sorry, input range should be 1~100.\n"
newline:	.asciiz "\n"

primes: 	.word 0:100
	
#------- Text Segment ----------
.text 
.globl main
main:
	# Put 2 as the 1st element in primes array
	addi	$t1, $zero, 2
	la	$t2, primes
	sw	$t1, 0($t2) 
	
ask_input:
	# Print starting message to ask input
	la 	$a0 mesg1						
	li 	$v0 4
	syscall					

	# $s0 stores the input integer
	li 	$v0, 5
	syscall	
	addi 	$s0, $v0, 0					

	# if input integer is 0, then end the program
	beq 	$s0, $zero, endmain
	
	# if input integer is larger than 100, then ask another input
	addi	$t1, $zero, 101
	slt 	$t2, $s0, $t1
	bne	$t2, $zero, start
	la 	$a0 mesg3						
	li 	$v0 4
	syscall	
	j	ask_input
		
start:	  
	# Otherwise, call nth_prime procedure to calculate n-th prime, $a0=n
	addi 	$a0, $s0, 0
	jal 	FindNthPrime	# FindNthPrime is what you should implement	  
	# $t0 stores the calculated n-th prime   
	addi 	$t0, $v0, 0  

	# Print result message and result of n-th prime
	addi 	$a0, $s0, 0
	li 	$v0, 1
	syscall	 
	la 	$a0, mesg2 
	li 	$v0, 4
	syscall				
	addi 	$a0, $t0, 0
	li 	$v0, 1
	syscall				
	la 	$a0, newline
	li 	$v0, 4
	syscall	

	# Another loop 
	j 	ask_input

# Terminate the program
endmain:
	li    	$v0, 10     	
	syscall 

# Implement function FindNthPrime
# What FindNthPrime should do: calculate n-th prime, $a0=n, return n-th prime in $v0	
FindNthPrime:
# TODO below
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)
	
	la	$t0, primes	# $t0 = address of primes[cnt-1]
	addi	$t1, $a0, -1	# $t1 = num - 1 = index
	sll	$t1, $t1, 2
	add	$t1, $t0, $t1	# $t1 = address of primes[num-1]
	lw	$t2, 0($t1)	# $t2 = primes[num-1]
	bne	$t2, 0, found	# n-th prime already found, exit
	
	lw	$t2, 0($t0)	# $t2 = primes[cnt-1]
	addi	$t2, $t2, 1	# $t2 = i = primes[cnt-1] + 1
	
	n_prime_loop:
	slt	$t3, $t0, $t1	# $t3 = (addr(cnt-1) < addr(num-1)) ? 1 : 0
	beq	$t3, $0, exit_n_prime_loop # while cnt < num
	addi	$a0, $t2, 0	# is_prime(i)
	
	# push $t0, $t1, $t2 to stack
	addi 	$sp, $sp, -12
	sw 	$t0, 8($sp)
	sw 	$t1, 4($sp)
	sw 	$t2, 0($sp)
	
	jal	is_prime
	
	# pop $t0, $t1, $t2 from stack
	lw 	$t2, 0($sp)
	lw 	$t1, 4($sp)
        lw 	$t0, 8($sp)
        addi 	$sp, $sp, 12
	
	beq	$v0, $0, i_not_prime # if i is prime
	addi	$t0, $t0, 4	# $t0 = address of primes[cnt] (new prime)
	sw	$t2, 0($t0)	# primes[cnt] = i
	
	i_not_prime:
	addi	$t2, $t2, 1	# i++
	j	n_prime_loop
	
	exit_n_prime_loop:
	addi	$t2, $t2, -1	# $t2 = primes[cnt-1] = primes[num-1]
	
	found:
	addi	$v0, $t2, 0	# return $t2 = primes[num-1]
	
	lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra
# TODO above

# Implement function is_prime, which would be used in FindNthPrime function
# What is_prime should do: Given a value in $a0, check whether it is a prime
# if $a0 is prime, then return $v0=1, otherwise, return $v0=0
is_prime:
# TODO below
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)
	
	li	$t0, 2		# $t0 = j = 2
	div	$a0, $t0
	mflo	$t1		# $t1 = i / 2 
	
	is_prime_loop:
	slt	$t2, $t1, $t0	# $t2 = (j > i/2) ? 1 : 0
	bne	$t2, $0, exit_is_prime_loop # while j <= i/2
	
	div	$a0, $t0
	mfhi	$t2		# $t2 = i % j
	beq	$t2, $0, not_prime # i % j == 0
	
	addi	$t0, $t0, 1	# j = j + 1
	j	is_prime_loop
	
	exit_is_prime_loop:
	li	$v0, 1		# return 1
	j	exit_is_prime
	
	not_prime:
	li	$v0, 0		# return 0
	
	exit_is_prime:
	lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra
# TODO above

# Given value in $a1 and $a2, this function calculate the remainder of $a1 / $a2
# return remainder($a1 % $a2) in $v1  
Remainder: 
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	div	$a1, $a2
	mfhi	$v1
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
