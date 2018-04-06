#------- Data Segment ----------
.data
# Define the string messages and the array
msg1:           .asciiz "The original list of random points are "
msg2:		.asciiz "\nThe ascending sorted point array are  "
space:		.asciiz " "
newline:	.asciiz "\n" 
leftbracket:	.asciiz "("
rightbracket: 	.asciiz ")"

#                      x  y
# point:  	.word 20 20

#                       x_1 y_1 x_2 y_2 x_3 y_3 x_4 y_4  x_5 y_5  x_6 y_6  x_7 y_7 x_8 y_8  x_9 y_9 x_10  y_10
# point_array:   .word   20  3  35  173  0  68   0   0   650 456  124 124  16  45  23  14   16  15   20    1
point_array:    .word 0:20

#------- Text Segment ----------
.text
.globl main
main:

	# $s1 is the array size
	addi 	$s1,$zero,20

	# set random seed
	li 	$v0, 30
	syscall            
	addi 	$a1, $a0, 0
	li 	$a0, 0
	li 	$v0, 40
	syscall

	# load the starting address of the pointarray to $s0
	la 	$s0, point_array
	addi 	$t0, $zero, 0
	
# fill the array with $s1 random elements within range [1, 100]
array_filling:	
	jal 	random_number_generate	
	sll 	$t1, $t0, 2
	add 	$t1, $s0, $t1
	sw 	$v1, 0($t1)
	addi	$t0, $t0, 1 
	bne 	$t0, $s1, array_filling
	
	# Print the original array
 	jal 	printoriginal
	
	# Sort array	
	jal 	sortarray	# sortarry function is what you should implement
	
	# Print the sorted array
	jal 	printresult
 	
	# Terminate the program
	li 	$v0, 10 
	syscall

# Implement sortarray function 
# What sortarray should do: Sort the point_array
# $s1 stores the array size
# $s0 stores the starting address of the point_array
sortarray:
# TODO below:
	li	$t0, 0		# $t0 = i = 0
	
	sort_loop:
	addi	$t1, $s1, -2	# $t1 = n - 2
	slt	$t2, $t0, $t1	# $t2 = (i < n - 2) ? 1 : 0
	beq	$t2, $0, exit	# while i < n - 2
	li	$t1, 0		# $t1 = j = 0	
	
	sort_loop_inner:
	addi	$t2, $s1, -2	# $t2 = n - 2
	sub	$t2, $t2, $t0	# $t2 = n - 2 - i
	slt	$t3, $t1, $t2	# $t3 = (j < n - 2 - i) ? 1 : 0
	beq	$t3, $0, exit_inner # while j < n - 2 - i
	
	sll	$t2, $t1, 2
	add	$t2, $s0, $t2	# $t2 = address of a[j]
	lw	$t3, 0($t2)	# $t3 = a[j]
	lw	$t4, 4($t2)	# $t4 = a[j+1]
	lw	$t5, 8($t2)	# $t5 = a[j+2]
	lw	$t6, 12($t2)	# $t6 = a[j+3]
	
	slt	$t7, $t5, $t3	# $t7 = (a[j+2] < a[j]) ? 1 : 0
	bne	$t7, $0, swap	# swap if a[j+2] < a[j]
	
	bne	$t5, $t3, no_swap # else if a[j+2] == a[j]
	slt	$t7, $t6, $t4	# $t7 = (a[j+3] < a[j+1]) ? 1 : 0
	beq	$t7, $0, no_swap # swap if a[j+3] < a[j+1]
	
	swap:
	addi	$t7, $t3, 0	# $t7 = temp = a[j]
	addi	$t3, $t5, 0	# a[j] = a[j+2]
	addi	$t5, $t7, 0	# a[j+2] = temp
	addi	$t7, $t4, 0	# $t7 = temp = a[j+1]
	addi	$t4, $t6, 0	# a[j+1] = a[j+3]
	addi	$t6, $t7, 0	# a[j+3] = temp
	sw	$t3, 0($t2)	# a[j] = $t3
	sw	$t4, 4($t2)	# a[j+1] = $t4
	sw	$t5, 8($t2)	# a[j+2] = $t5
	sw	$t6, 12($t2)	# a[j+3] = $t6
	
	no_swap:
	addi	$t1, $t1, 2	# j = j + 2
	j	sort_loop_inner
	
	exit_inner:
	addi	$t0, $t0, 2	# i = i + 2
	j	sort_loop
	
	exit:
	jr 	$ra
# TODO above

# print original array
printoriginal:
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)
	
	la 	$a0, msg1
	li 	$v0, 4
	syscall
	
        jal 	printmain
        
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra
        
         
#print the sorted array
printresult:
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)

	la 	$a0, msg2
	li 	$v0, 4
	syscall
	
        jal 	printmain
        
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra

# print array     
printmain:
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)

	#Print a new line
	la 	$a0, newline
	li 	$v0, 4
	syscall
	
        addi	$t1, $zero, 0  			#$t1 is the index for printing sorted A[i]
        
printloop:
        slt  	$t0, $t1, $s1     		#check to see if $t1 (i) is still within the correct range 
        
        beq  	$t0, $zero, endprintloop 	#if i>=20 end print numbers
        
        addi	$t2, $zero, 2
        div	$t1, $t2					
	mfhi	$t3
	bne	$t3, $zero, printY	
	
	printX:
	la 	$a0, leftbracket
	li 	$v0, 4
	syscall
	
	sll  	$t2, $t1, 2       		#$t1*4 to get the byte offset
	add  	$t3, $s0, $t2     		#base+byte offset to get address of A[i]
	lw   	$a0, 0($t3)
	li   	$v0, 1
	syscall
	j 	printSpace
	
	printY:
	sll  	$t2, $t1, 2       		#$t1*4 to get the byte offset
	add  	$t3, $s0, $t2    		#base+byte offset to get address of A[i]
	lw   	$a0, 0($t3)
	li   	$v0, 1
	syscall
	
	la 	$a0, rightbracket
	li 	$v0, 4
	syscall
	
	#Print a space to separate the numbers
	printSpace:
	la 	$a0, space
	li 	$v0, 4
	syscall
	
	#i=i+1 and start another iteration of the loop	
	addi 	$t1,$t1,1      
	j 	printloop

endprintloop:	
#Print a new line
	la 	$a0, newline
	li 	$v0, 4
	syscall
	lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra

#no input paramter
#output result in $v0
random_number_generate:
	addi  	$sp, $sp, -8
	sw    	$ra, 0($sp)
	sw    	$a0, 4($sp)
	
	addi 	$a1, $zero, 100  #set upper bound to be 100	
	li 	$a0, 0
	li 	$v0, 42
	syscall
	
	addi 	$v1, $a0, 1	
	
	lw 	$a0, 4($sp)
	lw 	$ra, 0($sp)
	addi 	$sp, $sp, 8
	jr 	$ra		


