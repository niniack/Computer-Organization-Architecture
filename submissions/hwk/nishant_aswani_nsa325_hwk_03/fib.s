.data
resultMessage: .asciiz "The fibonacci number is: "
fibIn: .byte 24             # fibIn
res: .byte 1                # result

.text
main:
  lb $a1, fibIn             # save fibIn into $a1
  li $a2, 1                 # load 1 into $a2
  beq $a2, $a1, edgeCase    # if fibIn == 1, jump to edgeCase
  jal fibRec                # jump to fibRec label and save return address
print:
  li $v0, 4                 # code for print_string
  la $a0, resultMessage     # point $a0 to resultMessage
  syscall                   # print the result
  li  $v0,1                 # code for print_int
  move  $a0, $v1            # put result in $a0
  syscall                   # print out the result
exit:
  li $v0, 10                # code for exit
  syscall                   # exit programs  
fibRec: 
  addi $sp, $sp, -12        # decrement stack pointer by 12 bytes
  sw $ra, 8($sp)            # save return address 
  sw $a1, 4($sp)            # save fibIn
  sw $a2, 0($sp)            # save fibIn-1
  
  addi $a1, $a1, -1         # decrement the fibIn
  addi $a2, $a1, -1         # subtract the fibIn-1
  
  blt $a2, $zero, fibEnd    # if fibIn-1 == 0, start returning
  
  jal fibRec                # loop back to beginning
  
  li $t0, 1                 # load 1 into $t0  
check1:
  beq $t0, $a1, inc         # if $a1 == 1, increment final answer
check2: 
  bne $t0, $a2, check3      # if $a2 != 1, go to check 3
  addi $v1, $v1, 1          # else increment
check3: 
  bgt $a2, $t0, fibCall     # if $a2 > 1, jump to fibCall
  j fibEnd                  # else continue returning
fibCall:
  addi $a1, $a2, -1         # $a1 = $a1 - 1
  addi $a2, $a2, -2         # $a2 = $a1 - 1
  j fibRec                  # call fibRec again
fibEnd:
  lb $a2, 0($sp)            # store the fib-2 into $a2
  lb $a1, 4($sp)            # store the fib-1 into $a1
  lw $ra, 8($sp)            # store the return address
  addi $sp, $sp, 12         # increment the stack pointer 12 bytes
  jr $ra                    # jump to return address
inc:
  addi $v1, $v1, 1      
  j check2   
edgeCase:
  li $v1, 1                 # loads 1 into result without recursing
  j print                   # jumps to print instruction