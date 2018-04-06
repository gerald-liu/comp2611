
#------- Text Segment ----------
        .text

        .globl __start
__start:

# Execute the "print_int" system call
        li $v0, 1
        li $a0, 100
        syscall
