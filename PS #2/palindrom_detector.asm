.data
	array: 			.space 40
	input_msg:		.asciiz "Please enter a number: "
	palindrome_msg:         .asciiz "The number is a palindrome.\n" 
	notpalindrome_msg: 	.asciiz "The number is not a palindrome.\n"

.text
.globl main

main:
	la 	$a0, input_msg    
   	li 	$v0, 4               
    	syscall
    	
	li 	$v0, 5 		# Take a number from user
	syscall
	move 	$t0, $v0
	
	li	$t1, 0		# Digit number
	li	$t2, 0		# Compare counter
	
	j digit_count
	
digit_count:
	div 	$t3, $t0, 10

	addi	$t1, $t1, 1
	
	mflo	$t0
	bnez	$t0, digit_count
	
	j compare
	
compare:
	div	$t3, $t2, 2
	mfhi	$t3
	
	beqz	$t3, evendigit_compare
	j	odddigit_compare
	
evendigit_compare:

	beq	$t1, $t2, palindrome
	
	move	$t4, $t1
	

odddigit_compare:
	
	
	
palindrome:
	la 	$a0, palindrome_msg    
   	li 	$v0, 4               
    	syscall
	
	j exit

notpalindrome:
	la 	$a0, notpalindrome_msg    
   	li 	$v0, 4               
    	syscall
    	
	j exit
exit:
	li	$v0, 10
	syscall
