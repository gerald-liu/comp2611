#------- Data Segment ----------
        .data
# declare the string mesg
mesg:   .asciiz "Hello World\n"

#------- Text Segment ----------
        .text

        .globl main
main:

# Execute the "print_string" system call
        li $v0, 4
        la $a0, mesg
        syscall
