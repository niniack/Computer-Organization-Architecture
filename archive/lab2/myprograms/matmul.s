# File: matmul.s
# Name: Nishant Aswani
# Instructor: Cristoforos Vasilatos
# Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
# Due: Sep 11 2019

# for normal matrix multiplication, we must multiply row by column
# this is an O(N3) implementation
# e.g. <2,-1>*<1,3>
# essentially, 4 dot product calculations

.data
resultMessage: .asciiz "Resulting matrix [(0,0), (0,1), (1,0), (1,1)]: \n"
arr1: .word 2,-1,1,3    # first 2x2 array
arr2: .word 5,6,7,8     # second 2x2 array
matrixSize: .byte 2     # square matrix size
res: .word 0:4          # result aray
newline: .asciiz "\n"


#Bookkeeping: 

# use t0 for loop counter "i"
# use t1 for loop counter "j"
# use t2 for loop counter "k"

# use t3 as a counter for printing

# use $t4 to hold needed array 1 addresses
# use $t5 to hold needed array 2 addresses
# use $t6 to hold needed result array addresses
# use $t7 to temporarily store result values, later store result array offset

# use $t8 to store the result aray base address
# use $t9 to store result, later limit for print counter 
 
.text
main:
  la $a1, arr1          # store base address of array 1 in register
  la $a2, arr2          # store base address of array 2 in register
  lb $a3, matrixSize    # store matrixSize into register
  la $t8, res           # store base address of result array in register

  j L1                  # jump to L1 (first loop)
  
printInit:
  li  $t3,0             # use $t3 as a counter for printing
  li  $t9,0             # repurpose $t9 to store loop limit (2x2)
  li  $t7,9             # repurpose $t7 to store address offset for result array
  mul $t9, $a3, $a3     # matrixSize**2 to get print loop limit
  
  li $v0, 4             # code for print_string
  la $a0, resultMessage # point $a0 to resultMessage
  syscall               # print the result
  
printMatrix:
  beq $t3, $t9, exit    # if loop counter = matrixSize**2 then exit
  
  sll $t7, $t3, 2       # (counter)*4
  add $t7, $t7, $t8     # address C[0] + (counter)*4
  
  li  $v0,1             # code for print_int
  lw $a0, 0($t7)        # put result in $a0
  syscall               # print out the result
  
  li $v0, 4             # code for print_string
  la $a0, newline       # point $a0 to newline
  syscall               # print the result
  
  addi $t3, $t3, 1      # increment print loop counter
  j printMatrix         # loop back to beginning of printMatrix
  
L1:
  beq $t0, $a3, L1end   # if i = matrixSize then go to L1end
  
L2:
  beq $t1, $a3, L2end   # if j = matrixSize then go to L2end
  
L3:
  beq $t2, $a3, L3end   # if k = matrixSize then go to L3end

  li $t4, 0  		# use $t4 to hold needed array 1 addresses
  li $t5, 0   		# use $t5 to hold needed array 2 addresses
  li $t6, 0   		# use $t6 to hold needed result array addresses
  li $t7, 0   		# use $t7 to store result from loop

  # The iterator values have to be modified, as data is stored
  # in a flat 1D array instead of a 2x2 C/C++ type multidim array.
  # Hence, here is a modified algorithm for iteration
	
  # A[i][k] = A[2i+k]
  # B[k][j] = B[j+2k]
  # C[i][j] = C[2i+j]

  # loading the value from array 1
  sll $t4, $t0, 1       # i*2
  add $t4, $t4, $t2     # 2i+k
  sll $t4, $t4, 2       # (2i+k)*4 to get offset
  add $t4, $t4, $a1     # address A[0] + (2i+k)*4
  lw  $t4, 0($t4)       # load A[2i+k] into $t4 register

  # loading the value from array 2
  sll $t5, $t2, 1       # k*2
  add $t5, $t5, $t1     # j+2k
  sll $t5, $t5, 2       # (j+2k)*4 to get offset
  add $t5, $t5, $a2     # address B[0] + (j+2k)*4
  lw  $t5, 0($t5)       # load B[j+2k] into $t5 register

  # loading the address for result
  sll $t6, $t0, 1       # i*2
  add $t6, $t6, $t1     # 2i+j
  sll $t6, $t6, 2       # (2i+j)*4 to get offset 
  add $t6, $t6, $t8     # address C[0] + (2i+j)*4

  # notice, because of the block above, $t6 always points
  # to correct address for storing the result
  
  # carry out multiplication A[i][k]*B[k][j]
  mul $t7, $t4, $t5

  # add onto existing value to avoid overwrite
  lw  $t9, 0($t6)	# load existing value 
  add $t7, $t7, $t9	# add new value onto existing value

  # save into result array at C[i][j]
  sw  $t7, 0($t6)	# save value into result array

  # conclude loop
  addi $t2, $t2, 1      # increment k counter by 1
  j L3                  # return to start of L3

L1end:
  j printInit
  
L2end:
  addi $t0, $t0, 1      # increment i counter by 1
  li $t1, 0             # reset j counter to 0
  j L1                  # jump to j loop
  
L3end:
  addi $t1, $t1, 1      # increment j counter by 1
  li $t2, 0             # reset k counter to 0
  j L2                  # jump to k loop
  
exit:
  li $v0, 10            # code for exit
  syscall               # exit program
