.data
m1:.asciiz "Enter the current system: "
m2:.asciiz "\nEnter the number:"
m3:.asciiz "\nEnter the new system:"
m4:.asciiz "\nThe number in the new system:"
m5:.asciiz "\n the number doesnot belong to the current system "
userinput:.space 20

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
 move $a0, $t0  
 la $a1, userinput 
 jal othertodecimal
 
move $a0,$v0
li $v0, 1 
syscall

 li $v0, 10 # Exit syscall
 syscall
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
  
     
           

     
