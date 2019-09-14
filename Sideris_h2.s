#######################################################################################################################
#Peter Sideris
#May 5, 2019
#Sideris_h2.s
#DESCRIPTION
#Program 2 asks the user to input 10 integer values, they were stored. The program then was to find the sum of the
#values, find the maximum value, and then reverse the entries and display them in that order. I had trouble finding
#the maximum value, as well as figuring out how to traverse the array in reverse order using the MIPS language.
#PSUEDO-CODE
#println("Enter 10 values: ");
#for (i < array.length){
#	myArray[i] = user_input.next
#	println("These are tge values " + myArray[i]);
#sum=0;
#for(i < array.length){
#sum += myArray[i]
#}
#int max = myArray[0]
#for (i < myArray.length )
#	if( mA[i] > max)
#		max = mA[i]
#REGISTER USE
#$a0 : addressing 
#$zero : zero register
#$v0 : users input values
#$t0 : input values' storage
#$s1 : array
#$t1 : counter
#$t4 : first position in array
#$t5 : sum of array
#$t6 : max value
#######################################################################################################################
.data 
	myArray: .space 40
	prompt: .asciiz "Enter 10 values: \n"
	theSum: .asciiz "\n The sum of all values is: "
	theMax: .asciiz "\n The maximum value is: "
	reverse: .asciiz "\n The reverse order of the values are: \n"
.text
main:
	#print the user prompt
	li $v0, 4
	la $a0, prompt
	syscall
	#load myArray into $s1
	la $s1, myArray
	
loop:
	#allow user to input
	li $v0, 5
	syscall
	sw $v0, 0($s1)
	#shift array position one word at a time (1 word = 4 bytes)
	addi $s1, $s1, 4
	#increment counter $t1
	addi $t1, $t1, 1
	#for ($t1=0; $t1<10; $t1++) 
	bne $t1, 10, loop
	
	#we load myArray to reset array position
	la $s1, myArray
	#we subtract $t1 from itself to clear the temp register for later use 
	sub $t1,$t1,$t1

sum:	
	#set array to first position
	lw $t4, 0($s1)
	#move to next value (in bytes)
	addi $s1, $s1, 4
	#add the "first" and "next" values
	add $t5, $t4, $t5
	#create a counter
	addi $t1, $t1, 1
	#repeat until counter = 10
	bne $t1, 10, sum
	
	#display message theSum
	li $v0, 4
	la $a0, theSum
	syscall
	
	#move result of sum to argument $a0
	move $a0, $t5
	
	#print int in argument $a0
	li $v0, 1
	syscall
	
max: 
	#set array to first position
	lw $t4, 0($s1)
	#move to next value (in bytes)
	addi $s1, $s1, 4
	#compare the "first" and "next" values
	slt $t6, $t4, $t5	#($t4 < $t5)
	beq $t6, $zero, max
	#create a counter
	addi $t1, $t1, 1
	#repeat until counter = 10
	bne $t1, 10, max
	
	#display message theMax
	li $v0, 4
	la $a0, theMax
	syscall
	
	#move result of sum to argument $a0
	move $a0, $t6
	
	#print int in argument $a0
	li $v0, 1
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
