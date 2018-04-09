.data

msg: .asciiz "loop ended!"

.text

li $t0, 2
li $t1, 3
add $t2, $t0, $t1

loop: 
	addi $t2, $t2, -1
	bne $t2, $zero, loop
	
li $v0, 4
la $a0, msg
syscall
