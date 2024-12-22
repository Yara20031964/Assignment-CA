.data
m1:.asciiz"Enter the current system: "
m2:.asciiz "\nEnter the number:"
m3:.asciiz "\nEnter the new system:"
m4: .asciiz"\nThe number in the new system:"
userinput:.space 20
.text
  #to print m1
  li $v0,4
  la $a0,m1
  syscall
  
 #to input
 li $v0,5
 syscall
 move $t0,$v0
 
   #to print m2
  li $v0,4
  la $a0,m2
  syscall
  
   #to input
 li $v0,8
 la $a0,userinput
 li $a1,20
 syscall
li $t0, 0           # Null terminator
sb $t0, 19($a0)  
 
   #to print m3
  li $v0,4
  la $a0,m3
  syscall
  
 #to input
 li $v0,5
 syscall
 move $t2,$v0
 
 #pass argument to function
 move $a0, $t0  
 la $a1, userinput 
 jal othertodecimal
 
 move $a0, $v0 
 li $v0, 1 # Print integer syscall
 syscall
# Exit program
 li $v0, 10 # Exit syscall
 syscall
  
  othertodecimal:
     li $v0, 0
     li $t3, 0
     move $t4, $a1
     find_length:
    lb $t5, 0($t4)     
   beqz $t5, done_length  
   addi $t3, $t3, 1     
   addi $t4, $t4, 1  
   j find_length 
   done_length:
   sub $t3,$t3,1
    move $t4, $a1  #to reset t4 to begin of string
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
     move $a2,$a0
     move $a3,$t3
     jal calc_power
     move $t9,$v1   #value of bower
     sub $t3,$t3,1
     
     
     mul $t9,$t9,$t5
     add $v0,$v0,$t9
     j main_loop
     
    exx: 
     jr $ra 
  
 calc_power:
  li $t0, 1      
  li $t1, 0      

power_loop:
  beq $t1, $a3, exist  
  mul $t0, $t0, $a2         
  addi $t1, $t1, 1          
  j power_loop         

exist:
  move $v1, $t0  # Return the result in $v0
  jr $ra    
 
 
 
 
 
 
