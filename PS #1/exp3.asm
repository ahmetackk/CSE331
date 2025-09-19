.data
	array: 		.word 1, 5, 7, 2, 3, 9, 8
	length: 	.word 7
	threshold: 	.word 3
	found_msg: 	.asciiz "\nA number found that bigger than threshold: "
	result_msg: 	.asciiz "\nNumber of elements greater than 3: " # Message to display result
	blank:		.asciiz "\n"

.text
main:
	li $t0, 0
	lw $t1, length
	lw $t2, threshold
	la $t3, array
	li $t7, 0
	
while_loop:
	beq $t0, $t1, end_loop
	
	sll $t4, $t0, 2
	lw $t5, 0($t3)
	add $t3, $t3, $t4
	
	la $a0, blank    
   	li $v0, 4               
    	syscall
	
	move $a0, $t5 
   	li $v0, 1               
    	syscall
	
	bgt $t5, $t2, increment_and_print
	
next_element:
	addi $t0, $t0, 1
	j while_loop
	
increment_and_print:
	la $a0, found_msg    
   	li $v0, 4               
    	syscall
    	
    	move $a0, $t5 
   	li $v0, 1               
    	syscall
	
	addi $t7, $t7, 1
	j next_element
	
end_loop:
	la $a0, result_msg    
   	li $v0, 4               
    	syscall
    	
    	move $a0, $t7    
   	li $v0, 1               
    	syscall

	li $v0, 10
	syscall
	
	