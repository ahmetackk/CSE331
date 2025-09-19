.data
    array:      .word 1, 4, 5, 2, 6, 3, 7    # The array of integers
    length:     .word 7                      # Length of the array
    threshold:  .word 3                      # The threshold value (3)
    result_msg: .asciiz "Number of elements greater than 3: " # Message to display result
    
.text
.globl main

main:
    # Initialize registers
    li $t0, 0               # $t0 will hold the count of elements greater than 3
    li $t1, 0               # $t1 will serve as the index for the array
    la $t2, array           # $t2 will hold the base address of the array
    lw $t3, length          # $t3 will hold the length of the array
    lw $t4, threshold       # $t4 will hold the threshold value (3)

while_loop:
    beq $t1, $t3, end_loop  # If index ($t1) == length ($t3), exit the loop

    sll $t5, $t1, 2         # Calculate offset (index * 4) since each element is 4 bytes
    lw $t6, 0($t2)          # Load the current element into $t6
    add $t2, $t2, $t5       # Update the base address with the offset

    bgt $t6, $t4, increment_count  # If current element > 3, increment the count

next_element:
    addi $t1, $t1, 1        # Increment index to move to the next element
    j while_loop            # Jump back to the beginning of the loop

increment_count:
    addi $t0, $t0, 1        # Increment the count of elements greater than 3
    j next_element          # Move to the next element

end_loop:
    # Print the result message
    la $a0, result_msg      # Load the address of the message
    li $v0, 4               # System call for printing a string
    syscall

    # Print the count of elements greater than 3
    move $a0, $t0           # Move the result (count) to $a0
    li $v0, 1               # System call for printing an integer
    syscall

    # Exit the program
    li $v0, 10              # System call to exit the program
    syscall
