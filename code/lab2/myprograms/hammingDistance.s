.data

m1: .asciiz "abcdef"
m2: .asciiz "12cd45"
m3: .asciiz "Hamming Distance is "
newline: .asciiz "\n"

.text

main:
	la $a1, m1 #store message 1 in register
	la $a2, m2 #store message 2 in register
strcmp:
	add $t0,$zero,$zero #use t0 for loop counter
	add $t1,$zero,$zero #use t1 for hamming counter
	add $t2,$zero,$zero #use t2 to store address of byte in m1
	add $t3,$zero,$zero #use t3 to store address fo byte in m2
	add $t4,$zero,$zero# use t4 to store byte for m1
	add $t5,$zero,$zero# use t5 to store byte for m2
loop:
	add $t2, $t0, $a1 #store in t2 the address of bytes in m1
	add $t3, $t0, $a2 #store in t3 the address of bytes in m2
	lb $t4, 0($t2) #load byte from address of byte in t2
	lb $t5, 0($t3) #load byte from address of byte in t3
	beqz $t4, print
	addi $t0, $t0, 1 #increment loop counter
	beq $t4, $t5, loop #if equal then loop back
incHamming:
	addi $t1, $t1, 1 # otherwise add 1 to hamming counter
	j loop # and then loop back
print:
	li $v0, 4  # code for print_string
	la $a0, m3 # point $a0 to m3
	syscall # print the string
	li $v0, 1 # code for print_int
	move $a0,$t1 #put result in $a0
	syscall # print the result
	li $v0, 4 # code for print_string
	la $a0, newline # point $a0 to newline
	syscall # print the result
exit:
	li $v0, 10 # code for exit
	syscall # exit program
