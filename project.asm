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
 beq $t2,10,othertodecimal
  
  othertodecimal:
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

   
     
   
   
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
