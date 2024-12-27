.data
m1:.asciiz "Enter the current system: "
m2:.asciiz "\nEnter the number:"
m3:.asciiz "\nEnter the new system:"
m4:.asciiz "\nThe number in the new system:"
m5:.asciiz "\nThe number does not belong to the current system"
userinput:.space 20
digits: .asciiz "0123456789ABCDEF"  # Array for base conversion
result: .space 20  # Reserve space for the result string

.text
# Print m1
li $v0, 4
la $a0, m1
syscall

# Input current base
li $v0, 5
syscall
move $t0, $v0  # current base

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
move $t2, $v0  # new base

# Check input validity
la $t4, userinput
check_input:
  lb $t5, 0($t4)
  beqz $t5, main_section
  addi $t4, $t4, 1
  
  li $t8, '9'  # Load ASCII value of '9'
  bgt $t5, $t8, check_c
  sub $t5, $t5, '0'  # Convert to integer
  j check_error
check_c:
  sub $t5, $t5, 'A'
  addi $t5, $t5, 10  # To get its integer value
check_error:
  blt $t5, $t0, check_input

end_program:
  li $v0, 4
  la $a0, m5
  syscall

  li $v0, 10  # Exit syscall
  syscall

main_section:
  # Convert the input number to decimal (if necessary) using othertodecimal function
  move $a0, $t0
  la $a1, userinput
  jal othertodecimal  # Convert to decimal

  # If the base is 10, convert to the new base
  li $t0, 10
  beq $a0, $t0, decimal_to_other

  move $a0, $v0
  li $v0, 1
  syscall  # Print the decimal result

  li $v0, 10  # Exit syscall
  syscall

# Convert number from other base to decimal
othertodecimal:
  li $v0, 0
  li $t6, 0
  li $t3, 0
  move $t4, $a1
find_length:
  lb $t5, 0($t4)
  beqz $t5, done_length
  addi $t3, $t3, 1
  addi $t4, $t4, 1
  j find_length
done_length:
  sub $t3, $t3, 2
  move $t4, $a1
main_loop:
  lb $t5, 0($t4)
  beqz $t5, exx
  addi $t4, $t4, 1

  li $t8, '9'  # Load ASCII value of '9'
  bgt $t5, $t8, check_char
  sub $t5, $t5, '0'  # Convert to integer
  j calc_answer

check_char:
  sub $t5, $t5, 'A'
  addi $t5, $t5, 10  # To get its integer value
calc_answer:
  li $t7, 1  # To calculate power
  li $t1, 0
  move $t2, $a0
power_loop:
  beq $t1, $t3, exist
  mul $t7, $t7, $t2
  addi $t1, $t1, 1
  j power_loop
exist:
  mul $t9, $t7, $t5
  add $t6, $t6, $t9
  sub $t3, $t3, 1
  bgez $t3, main_loop

exx:
  move $v0, $t6
  jr $ra

# Convert decimal to other base
decimal_to_other:
  # Decimal to other base conversion logic
  li $t6, 0            # Clear $t6 (this will store the final result)
  li $t3, 0            # Clear $t3 (index for result storage)
  la $t4, result       # Set $t4 to the address of the result string

convert_loop:
  divu $t0, $t0, $t2   # Divide the decimal number by the base
  mfhi $t5             # Get the remainder (this is the next digit)
  mflo $t0             # Update the decimal number (quotient)

  # Get the digit from the 'digits' string using the remainder
  la $t6, digits       # Load address of 'digits' string
  add $t6, $t6, $t5    # Add the remainder value to the address of digits
  lb $t7, 0($t6)       # Load the corresponding digit character from 'digits'

  sb $t7, result($t3)  # Store the character in the result array
  addi $t3, $t3, 1     # Increment the index for result

  # Check if the quotient (decimal number) is 0, exit loop if true
  beqz $t0, print_result

  j convert_loop

print_result:
  # Print the result message
  li $v0, 4
  la $a0, m4
  syscall

  # Print the result array in reverse order (since the least significant digit is first)
  sub $t3, $t3, 1        # Decrement index to the last valid character
reverse_loop:
  lb $t8, result($t3)    # Load character from result array
  li $v0, 11
  move $a0, $t8
  syscall                # Print character

  # Decrement index and check if we've reached the beginning
  sub $t3, $t3, 1
  bge $t3, $zero, reverse_loop

  jr $ra                 # Return from function
