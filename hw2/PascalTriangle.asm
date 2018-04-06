#------- Data Segment ----------
.data

mesg: .asciiz "Please enter the row number(range:1~9) of Pascal Triangle(enter 0 to end the program):"
newline: .asciiz "\n"
space: .asciiz " "
doublespace: .asciiz "  "

#------- Text Segment ----------
.text 
.globl main
main:

	# Print starting message to ask for row number input
	la 	$a0 mesg						
	li 	$v0 4
	syscall					

	# $t0 stores number of lines to print
	li 	$v0, 5
	syscall					
	addi 	$t0, $v0, 0			

	# if input integer is 0, then end the program
	beq 	$t0, $zero, endprogram

	addi 	$t1, $zero, 0			# i = 0
	addi 	$t2, $zero, 0			# j = 0
        
        # $t4 indicates whether row number is smaller than 6 (2-digit number appears from row 6)
	slti 	$t4, $t0, 6	
			
LWhile:
	beq 	$t1, $t0, main
	sub 	$t3, $t0, $t1
	addi 	$t3, $t3, -1
	j 	Spacesfor
	
Spacesfor:	 
	beq 	$t3, $t2, endSpaces		# j = lines-1-i
	
	beq 	$t4, $zero, DoubleSpace	
	
	li 	$v0, 4				# print space
	la 	$a0, space
	syscall
	j 	NextSpaceLoop
	
	DoubleSpace:
	li 	$v0, 4				# print double space
	la 	$a0, doublespace
	syscall
	
	NextSpaceLoop:
	addi 	$t2, $t2, 1			# j++
	j 	Spacesfor
endSpaces:
	addi 	$t2, $zero, 0
	j 	Pascalfor
	
Pascalfor:
	bgt 	$t2, $t1, endpfor
	
	addi 	$a0, $t1, 0			# $a0 = i
	addi 	$a1, $t2, 0			# $a1 = j
	
	jal 	pascal		# pascal function is what you should implement	
	
	beq 	$t4, $zero, RowNumNotSmallerThanSix
	
	# print int
	addi 	$a0, $v0, 0
	li 	$v0, 1
	syscall				
	
	# print a space
	li 	$v0, 4
	la 	$a0, space
	syscall				
	
	j NextPascalLoop
	
RowNumNotSmallerThanSix:
	addi 	$t5, $v0, 0			# move result to $t5
	
	slti 	$t6, $t5, 10
	beq 	$t6, $zero, PrintNum 
	li 	$v0, 4
	la 	$a0, space
	syscall					# print a space
	
PrintNum:
	addi 	$a0, $t5, 0			# move result to $a0
	li 	$v0, 1
	syscall					# print int
	
	li 	$v0, 4
	la 	$a0, doublespace
	syscall					# print double space
	
NextPascalLoop:
	addi 	$t2, $t2, 1			# j++
	j Pascalfor
		
endpfor:
	li 	$v0, 4				# print new line
	la 	$a0, newline
	syscall
	
	addi 	$t1, $t1, 1			# i++
	addi 	$t2, $zero, 0
	
	j 	LWhile
	
endprogram:
	addi     $v0, $zero, 10     		# System call code 10 for exit
	syscall 


# Implement pascal function
# What pascal function should do: given row number $a0, column number $a1, calculate C(row, col)
# C(row,col) = C(row-1, col-1) + C(row-1, col)
# return C(row col) in $v0					
pascal:
# TODO below
	beq	$a1, $0, base		# if column == 0
	beq	$a1, $a0, base		# else if column == row
	
	addi	$sp, $sp, -4
	sw	$t0, 0($sp)		# preserve the $t0 outside
	
	# push $a0, $a1, $ra to stack
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$a1, 0($sp)
	
	addi	$a0, $a0, -1		# $a0 = row - 1
	addi	$a1, $a1, -1		# $a1 = column - 1
	jal	pascal			# $v0 = pascal(row-1, column-1)
	addi	$sp, $sp, -4
	sw	$v0, 0($sp)		# store pascal(row-1, column-1)
	
	lw	$a1, 4($sp)		# $a1 = column
	lw	$a0, 8($sp)		# $a0 = row
	addi	$a0, $a0, -1		# $a0 = row - 1
	jal	pascal			# $v0 = pascal(row-1, column)
	
	# pop from stack
	lw	$t0, 0($sp)		# $t0 = pascal(row-1, column-1)
	lw	$a1, 4($sp)		# $a1 = column
	lw	$a0, 8($sp)		# $a0 = row
	lw	$ra, 12($sp)
	addi	$sp, $sp, 16
	
	add	$v0, $t0, $v0		# $v0 = pascal(row-1, column-1) + pascal(row-1, column)
	
	lw	$t0, 0($sp)		# restore the $t0 outside
	addi	$sp, $sp, 4
	
	jr	$ra
	
	base:
	li	$v0, 1			# $v0 = 1
	jr	$ra
# TODO above
