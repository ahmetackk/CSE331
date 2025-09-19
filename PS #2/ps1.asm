.data
	prompt: .asciiz "Enter a number: "
	divisible_msg: .asciiz "The number is divisible by 9.\n"
	not_divisible_msg: .asciiz "The number is NOT divisible by 9.\n"


.text
.globl main

main:
	li $v0, 4          
    	la $a0, prompt
    	syscall

	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 10
	li $t2, 0
	li $t3, 9
	
sum_of_digits:
	beq $t0, 0, check
	div $t0, $t1
	mfhi $t4
	mflo $t0
	
	add $t2, $t2, $t4
	
	j sum_of_digits
check:
	div $t2, $t3
	mfhi $t4
	beq $t4, 0, divisible
	j not_divisible
	
divisible:
	li $v0, 4          
    	la $a0, divisible_msg
    	syscall
	
	j exit

not_divisible:
	li $v0, 4          
    	la $a0, not_divisible_msg
    	syscall
    	
    	j exit
    	
exit:
	li $v0, 10
	syscall