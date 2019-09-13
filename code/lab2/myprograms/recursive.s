# File: recursive.s
# Name: Nishant Aswani
# Instructor: Cristoforos Vasilatos
# Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
# Due: Sep 11 2019

# this  is a recursive implementation of power to the three
# the program asks for an input; 10<= n <20
# returns 3^n

.data
promptMessage: .asciiz "Please input an integer: \n"
resultMessage: .asciiz "The power of three is: "
base: .byte 3     	# base value set to 3
newline: .asciiz "\n"	# newline

.text
main:
  li $v0,4 		# code for print_string
  la $a0,promptMessage 	# point $a0 to result string
  syscall 		# print the result string

  li $v0,5 		# code for read_int
  syscall 		# get int from user --> returned in $v0
  move $a1, $v0         # move user input to $a1
  lb $a2, base		# save base into register $a2

powerInit:
  li $v1, 1		# account for base case: when recursion ends multiply by 1
  jal powerRec		# jump to powerRec and store next instruction into $ra

print:
  li $v0,4 		# code for print_string
  la $a0,resultMessage 	# point $a0 to result string
  syscall 		# print the result string

  li  $v0,1             # code for print_int
  move $a0, $v1         # put result in $a0
  syscall               # print out the result

  li $v0, 4             # code for print_string
  la $a0, newline       # point $a0 to newline
  syscall               # print the result

  j exit

powerRec:
  # the stack "grows upward", so we must decrement in memory
  addi $sp, $sp, -4	# decrement stack pointer by 4
  sw $ra, 0($sp)	# save return address to stack pointer

  beqz $a1, return	# if recursive counter equals 0 begin returning
  addi $a1, $a1, -1	# decrement the value of recursive counter

  jal powerRec		# loop back to power function

  # Using jal stores the address for the mul instruction (see below) into $ra.
  # When "popping" occurs, the mul instruction will be called
  # the designated number of times to multiply the stored value by 3.

  # The final address will move it up to the print label, as that was
  # the originally stored address

  mul $v1, $v1, $a2	# multiply 3 by value in $v1 register during return

return:
  lw $ra, 0($sp)	# load the return address from the top
  addi $sp, $sp, 4	# move the stack pointer "downward"
  jr $ra		# jump to the return address

exit:
  li $v0, 10            # code for exit
  syscall               # exit programs
