.data

msg: .asciiz "2 + 3 + 4 = "
list: .word 2 3 4

.text

li $v0, 4
la $a0, msg
syscall

li $s1, 0
la $s0, list
li $t0, 3
loop:
	beq $t0, $zero, loopEnd
	lw $t1, 0($s0)
	add $s1, $s1, $t1
	addi $t0, $t0, -1
	addi $s0, $s0, 4
	j loop
	
loopEnd:
	
li $v0, 1
move $a0, $s1
syscall
	
li $v0, 10
syscall	
		 
