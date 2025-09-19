.data 
prompt_msg: .asciiz "\nEnter a number!\n"
blank: .asciiz "\n"


.text
main:
	li $v0, 4
	la $a0, prompt_msg
	syscall

	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, blank
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
				
	li $v0, 10
	syscall