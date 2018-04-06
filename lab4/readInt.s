
#------- Text Segment ----------
        .text

        .globl __start
__start:

# Execute the "read_int" system call
        li $v0, 5
        syscall        # v0 has the input integer after this syscall
