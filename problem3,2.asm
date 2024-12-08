.data
array: .word 7, 2, 5, 11, 4, 6, 1, 1, 8, 3
length: .word 10
average: .float 0.0
message :.asciiz "average is: "
 .text
 main:
 la $t0,array 
 li $t1,0 #i=0
 lw $t2,length
 li $t3,0 #sum=0
  
  loop:
  lw $t4 ,0($t0)
  add $t3,$t3,$t4
  addi $t1 ,$t1,1
  addi $t0,$t0,4 #to get next offset
  blt $t1,$t2,loop
 
 # to float 
  mtc1 $t3,$f1
  mtc1 $t2,$f2
  cvt.s.w $f1,$f1
  cvt.s.w $f2,$f2
  div.s $f3,$f1,$f2
  s.s $f3,average
  
# to print message
    li $v0, 4          
    la $a0, message    
    syscall

    # to print average
    li $v0, 2         
    l.s $f12, average    
    syscall

    li $v0, 10         
    syscall
