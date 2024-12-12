.data
array: .word 10       
       .word 31       
       .word 5       
       .word 7      
       .word 11       
       .word 3      
       .word 8       
       .word 40        
       .word 12       
       .word 4   
       #another test case 
      # array: .word 10       
     #  .word 31       
    #   .word 5       
      # .word 7      
     #  .word 11       
      # .word 3      
     #  .word 8       
       #.word 40        
      # .word 12       
     #  .word 4    
       
min:   .word 0		#for minimum value

message :.asciiz "Min element is: "
.text

.globl main
main:
    la $t0, array         # Load address of the array into $t0
    lw $t1, 0($t0)        # Load the first element of the array into $t1 
    sw $t1, min           # Store the first element as the initial minimum
    li $t2, 1             # Initialize index $t2 = 1
    li $t3, 10            # Set loop limit size of array

loop:
    beq $t2, $t3, done    # Exit loop if index equals 10

    sll $t4, $t2, 2       # Calculate offset (index * 4)
    add $t5, $t0, $t4     # Compute address of array[$t2]
    lw $t6, 0($t5)        # Load array[$t2] into $t6

    lw $t7, min           # Load the current minimum into $t7
    blt $t6, $t7, update  # If array[$t2] < current minimum then update minimum

    j next                # else continue to the next element

update:
    sw $t6, min           # Update minimum with array[$t2]

next:
    addi $t2, $t2, 1      # Increment index
    j loop                # Repeat loop

done:
	# to print message
    li $v0, 4          
    la $a0, message    
    syscall
    
    lw $a0, min           # Load the minimum value into $a0 for printing
    li $v0, 1             # Print integer syscall
    syscall

    li $v0, 10            # Exit syscall
    syscall
