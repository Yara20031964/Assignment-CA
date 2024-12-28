.data
m1:.asciiz "Enter the current system: "
m2:.asciiz "\nEnter the number:"
m3:.asciiz "\nEnter the new system:"
m4:.asciiz "\nThe number in the new system:"
m5:.asciiz "\n the number doesnot belong to the current system "
userinput:.space 20
result_message: .asciiz "The number in the new system is: "
unsupported_message: .asciiz "Unsupported system. Please choose a base between 2 and 16.\n"
digits: .asciiz "0123456789ABCDEF"
result_buffer: .space 64  # Buffer to store the converted number

.text
# Print m1
li $v0, 4
la $a0, m1
syscall

# Input current base
li $v0, 5
syscall
move $t0, $v0

# Print m2
li $v0, 4
la $a0, m2
syscall

# Input number
li $v0, 8
la $a0, userinput
li $a1, 20
syscall


# Print m3
li $v0, 4
la $a0, m3
syscall

# Input new base
li $v0, 5
syscall
move $t2, $v0

#check the input
la $t4,userinput
 check_input:
  lb $t5, 0($t4)     
   beqz $t5, main_section    
   addi $t4, $t4, 1  
   
    li $t8, '9'  # Load ASCII value of '9'
    bgt $t5, $t8,check_c
    sub $t5, $t5, '0'  #convert to integer
    j check_error
    check_c:
     sub $t5, $t5, 'A'
     addi $t5, $t5, 10 
    check_error:
    blt $t5,$t0,check_input
     
    end_program:
     li $v0, 4
     la $a0, m5
     syscall
     
    li $v0, 10 # Exit syscall
    syscall


main_section:
 # Check if the current base is decimal (10)
 li $t1, 10
 beq $t0, $t1, call_decimal_to_other # Jump to decimal conversion if base is 10

 # Convert input number from current base to decimal
 move $a0, $t0 # Pass current base
 la $a1, userinput # Pass input number
 move $a2, $t2 #pass the new base
 jal othertodecimal
 move $t3, $v0            # to save the decimal number
 
 move $t2,$a2 #because we used t2 in other to decimal function and we still need the value of new base
 
 #check if the base is decimal here we finished our task
 li $t1, 10
 beq $t2, $t1, print_and_end_program # If new base is decimal, exit program

#else now we still have to convert the decimal number to other
#to continued
  move $a0, $t3            # decimal number
  move $a1, $t2            # target system
 
  jal DecimalToOther

 li $v0, 10  # Exit syscall
 syscall
 
 
call_decimal_to_other:
 #here 
 la $t4,userinput
 li $t3,0
find_length1:
  lb $t5, 0($t4)
  beqz $t5, done_length1
  addi $t3, $t3, 1
  addi $t4, $t4, 1
  j find_length1
done_length1:
  sub $t3, $t3, 2
  la $t4, userinput
  main_loop1:
  lb $t5, 0($t4)
  beqz $t5, exx1
  addi $t4, $t4, 1
  sub $t5, $t5, '0'  # Convert to integer
  li $t7, 1  # To calculate power
  li $t1, 0
power_loop1:
  beq $t1, $t3, exist1
  mul $t7, $t7, 10
  addi $t1, $t1, 1
  j power_loop1
exist1:
  mul $t9, $t7, $t5
  add $t6, $t6, $t9
  sub $t3, $t3, 1
  bgez $t3, main_loop1

exx1:
  #the number in t6
  move $a0, $t6            # decimal number
  move $a1, $t2            # target system
  jal DecimalToOther
  li $v0, 10  # Exit syscall
  syscall
  
  
  DecimalToOther:
    # Save the return address and registers
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $t0, 0($sp)

    # Check if the decimal number is 0
    beq $a0, $zero, print_zero

    # Initialize variables
    la $t4, result_buffer    # pointer to result buffer
    la $t5, digits           # pointer to digit characters
    move $t6, $a0            # $t6 = decimal number
    li $t7, 0                # $t7 = index for result buffer

convert_loop:
    beq $t6, $zero, reverse_result   # Exit loop when number becomes 0
    div $t8, $t6, $a1         # $t8 = quotient, $lo = remainder
    mfhi $t9                  # $t9 = remainder
    add $t9, $t5, $t9         # Address of digit: base address + remainder
    lb $t9, 0($t9)            # Load the digit character
    sb $t9, 0($t4)            # Store the digit into result buffer
    addi $t4, $t4, 1          # Move pointer to next position
    move $t6, $t8             # Update number to quotient
    addi $t7, $t7, 1          # Increment index
    j convert_loop

reverse_result:
    sub $t4, $t4, 1           # Point to the last valid character in buffer
    move $t6, $t7             # Number of digits
    
    li $v0, 4
    la $a0, m4
    syscall
reverse_loop:
    beq $t6, $zero, print_result2   # Exit loop when all characters are printed
    lb $a0, 0($t4)            # Load character from buffer
    li $v0, 11                # syscall for printing a character
    syscall
    subi $t4, $t4, 1          # Move pointer to previous character
    subi $t6, $t6, 1          # Decrement count
    j reverse_loop
    

print_result2:
    j return_function

print_zero:
    li $v0, 4
    la $a0, result_message
    syscall
    li $v0, 11                # Print '0'
    li $a0, 48
    syscall
    j return_function

return_function:
    # Restore the registers and return
    lw $t0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
  

 othertodecimal:
     li $v0, 0
     li $t6,0
     li $t3, 0
     move $t4, $a1
     find_length:
    lb $t5, 0($t4)     
   beqz $t5, done_length  
   addi $t3, $t3, 1     
   addi $t4, $t4, 1  
   j find_length 
   done_length:
   sub $t3,$t3,2
    move $t4, $a1
    main_loop:
    lb $t5, 0($t4)     
   beqz $t5, exx    
   addi $t4, $t4, 1  
   
    li $t8, '9'  # Load ASCII value of '9'
    bgt $t5, $t8,check_char
    sub $t5, $t5, '0'  #convert to integer
    j calc_answer
    
    check_char:
     sub $t5, $t5, 'A'
     addi $t5, $t5, 10   #to get its integer value
     calc_answer:
     li $t7,1      #to calc power
     li $t1,0
     move $t2,$a0
     power_loop:
      beq $t1, $t3, exist  
      mul $t7, $t7, $t2        
      addi $t1, $t1, 1          
     j power_loop   
     exist:
     
     
     mul $t9,$t7,$t5
     add $t6, $t6, $t9
     sub $t3,$t3,1
     bgez $t3, main_loop   
     
    exx: 
     move $v0, $t6   
     jr $ra 
  
     
 print_and_end_program:
 	move $t9,$v0
 	li $v0, 4
	la $a0, m4
	syscall
	move $a0,$t9
	li $v0, 1 
	syscall 
	li $v0, 10  # Exit syscall
 	syscall  
	
		              	              