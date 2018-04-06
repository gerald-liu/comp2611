#------- Data Segment ----------
        .data
# declare the string mesg
mesg1:   .asciiz "Before executing syscall 'exit'\n"
mesg2:   .asciiz "After executing syscall 'exit'\n"

#------- Text Segment ----------
        .text

        .globl __start
__start:


        li $v0, 4
        la $a0, mesg1
        syscall

        li $v0, 10
        syscall

        li $v0, 4       # this code will not even be executed
        la $a0, mesg2
        syscall
