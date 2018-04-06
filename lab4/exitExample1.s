

#------- Text Segment ----------
        .text

        .globl __start
__start:

# Execute the "exit" system call
        li $v0, 10
        syscall

