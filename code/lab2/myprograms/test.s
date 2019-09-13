.data

message: .asciiz "Hello World"

.text

main: 

	la $a0, message
	li $v0, 4
	syscall
	