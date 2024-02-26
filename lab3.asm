WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#                         ICS 51, Lab #3
#
#      IMPORTANT NOTES:
#
#      Write your assembly code only in the marked blocks.
#
#      DO NOT change anything outside the marked blocks.
#
###############################################################
#                           Text Section
.text

###############################################################
###############################################################
###############################################################
#                           PART 1 (fib_recur)
# $a0: input number
###############################################################
fib_recur:
############################### Part 1: your code begins here ##
addi $sp, $sp, -12 
sw $ra, 0($sp)
sw $a0, 4($sp)
bgt $a0, 1, else_case
move $v0, $a0 
j end_fib_recur 

else_case:
subi $a0, $a0, 1 
jal fib_recur
sw $v0, 8($sp)
subi $a0, $a0, 1
jal fib_recur 
lw $t0, 8($sp)
add $v0, $t0, $v0

end_fib_recur:
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 12

############################### Part 1: your code ends here  ##
jr $ra

###############################################################
###############################################################
###############################################################
#                           PART 2 (catalan_recur)
# $a0: input number
###############################################################
catalan_recur:
############################### Part 2: your code begins here ##
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
bgt $a0, 1, another_case
addi $v0, $0, 1
j end_catalan_recur

another_case:
move $s0,$a0
li $s1,0  # res
li $s2,0  # i
	loop_c:
	beq $s2,$s0,loop_c_done
	move $a0,$s2
	jal catalan_recur
	move $s3,$v0
	
	sub $a0,$s0,$s2
	subi $a0,$a0,1
	jal catalan_recur
	mul $v0,$v0,$s3
	add $s1,$s1,$v0
	addi $s2,$s2,1
	j loop_c

loop_c_done:
move $v0,$s1

end_catalan_recur:
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
addi $sp, $sp, 20
############################### Part 2: your code ends here  ##
jr $ra

###############################################################
###############################################################
###############################################################
#                           PART 3A (SYSCALL: file read, ASCII to Integer)
#
# $a0: the address of the string that represents the input file name
# $a1: the base address of an integer array that will be used to store distances
# data_buffer : the buffer that you use to hold data for file read (MAXIMUM: 300 bytes)
load_pts_file:
############################### Part 3A: your code begins here ##

li   $v0, 13       # system call for open file
# a0 is already ready for file name
li   $a1, 0        # Open for reading (flags are 0: read, 1: write)
li   $a2, 0        # mode is ignored
syscall            # open a file (file descriptor returned in $v0)
move $t0, $v0      # save the file descriptor 

li   $v0, 14       # system call for read file
move $a0, $t0      # file descriptor 
la   $a1, data_buffer   # address of buffer from which to read
li   $a2, 300       # max hardcoded buffer length
syscall            # read file

li $v0, 16 # close file
move $a0, $t0 # file descrip to close
syscall

# Parse the file contents and find the distances
li $t0, 0          # initialize the index to 0
li $t1, -1         # initialize the first number to -1
li $t2, -1         # initialize the second number to -1
la $t3, data_buffer # load the address of data_buffer into $t3

loop:
lb $t4, ($t3)      # load the current character into $t4
beq $t4, 10, exit  # if the current character is a newline, exit the loop
beq $t4, 32, next  # if the current character is a space, move to the next number

# convert the current character to a number and add it to the current number
mul $t1, $t1, 10
addi $t1, $t1, -48
addi $t1, $t1, $t4
j continue

next:
mul $t2, $t2, 10    # convert the second number
addi $t2, $t2, -48
addi $t2, $t2, $t1
li $t1, -1          # reset the first number
continue:
lb $t4, ($t3)       # move to the next character
addi $t3, $t3, 1
j loop

exit:
# Store the distances in the array
li $t0, 0          # initialize the index to 0
li $t5, -1         # initialize the previous number to -1
la $t6, distances   # load the address of the distances array into $t6

loop2:
lw $


############################# Part 3A: your code ends here   ##
jr $ra

###############################################################
###############################################################
###############################################################
#                           PART 3B (SYSCALL: file write, Integer to ASCII)
#
# $a0: the address of the string that represents the output file name
# $a1: the base address of an integer array that stores distances
# $a2: the number of valid distances to the integer array
# data_buffer : the buffer that you use to hold data for file read (MAXIMUM: 300 bytes)
save_dist_list:
############################### Part 3B: your code begins here ##

############################### Part 3B: your code ends here   ##
jr $ra
