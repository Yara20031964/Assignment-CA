.data
	#array: .word 10, 31, 5, 7, 11, 3, 8, 40, 12, 4
	array: .word 19, 2, 3, 7, 5, 10, 9, 0, 6, 1
	myMessage: .asciiz "Count of even number is: "
.text
	main:
	li  $t0, 0   #i=0
	li $t1, 10
	la $t2, array
	li $t3, 0    #count =0
	
	loop:
	bge $t0, $t1, end_loop
	lw $t4, 0($t2)    #load the current element in array
	li $t5, 2  #load number 2 to make modules 
	div $t4, $t5
	mfhi $t6    #move remider to t6
	beq $t6, $zero, increment
	j next
	increment:
	addi $t3, $t3, 1
	next:
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	j loop
	end_loop:
	li $v0,4
	la $a0, myMessage
	syscall 
	move $a0, $t3
	li $v0,1
 	syscall 
 	    li  $v0, 10             # Syscall to exit
    syscall