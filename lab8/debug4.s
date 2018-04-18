# A program to prompt the user to input a number to search in the array [2, 3, 4, 5], and output whether the number is found or not.

.data

msg: .asciiz "Enter a number to search in series 2 3 4 5: "
foundMsg: .asciiz "\nNumber found!\n"
notFoundMsg: .asciiz "\nNumber not found!\n"
list: .word 2 3 4 5

.text 
	la $t0, list

	move $a0, $t0
	li $a1, 4
	jal searchInput

	beq $v0, $0, notFound

	li $v0, 4
	la $a0, foundMsg
	syscall
	j end

notFound:
	li $v0, 4
	la $a0, notFoundMsg
	syscall

end:
	li $v0, 10
	syscall

### prompt the user to input a number to search in the array (its base address in a0 and size in a1), and return 1 if the number is found or else return 0.
### int searchInput(int[], int) 
searchInput: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	move $t0, $a0   # keep the array base address

	li $v0, 4
	la $a0, msg
	syscall

	li $v0, 5
	syscall

	move $a0, $t0
	move $a2, $v0
	jal search

	lw $ra, 0($sp)
	addi $sp, $sp, 4 
	jr $ra

### search a number ($a2) in the array (its base address in a0 and size in a1), and return 1 if the number is found or else return 0.
### int search(int[], int, int) 
search: 
	beq $a1, $0, loopEnd
	lw $t0, 0($a0)
	bne $t0, $a2, loopIncrement # number is not found yet
	li $v0, 1		    # number is found
	jr $ra

loopIncrement:
	addi $a1, $a1, -1
	addi $a0, $a0, 4
	j search
	
loopEnd:
	li $v0, 0
	jr $ra
