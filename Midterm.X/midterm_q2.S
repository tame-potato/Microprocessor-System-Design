## Pablo Ruiz

## EECE.3170: Microprocessors I
## UMass Lowell

## Program 2 for midterm exam

##   The program should count the number of Odd and Even values in the array and store the final count of each in two memory
##   variables, nOdd and nEven.

## The comments below describe generally how the program should behave
## Note that:
##      1. Pseudo-instructions are acceptable
##      2. Your solution should be general--don't write code that only
##          works for the sample variable values given.
##      3. Your solution should successfully assemble and run--code that does
##          not assemble will lose credit

    .data
## arr = Data to be tested
arr:	.word	    5, -3, 7, 4, -10, -18, 2020, 9, -1, 1

## nOdd = # of odd values in arr; nEven = # of even values in arr
nOdd:   .space	    4
nEven:	 .space	    4

    .text		# Text section contains code
    .set noreorder	# Disable instruction reordering
    .globl main		# Define main label as a global entity
    .ent main		#   and an entry point

main:

    la	$s0, arr    # load address f first element in arr into $s0
    
    addi    $t0, $zero, 0	    # $t0 = 0
    add	    $s1, $zero, $zero	    # $s1 = nOdd
    add	    $s2, $zero, $zero	    # $s2 = nEven
    addi    $s3, $zero, 2	    # $s3 = 2
    
L1:
    slti    $t1, $t0, 10
    beqz    $t1, L3
    nop
    
    sll	    $t1, $t0, 2	     # find the offset from the initial address for this iteration
    add     $t1, $s0, $t1    # add the offset to the original address to obtain the new address
    lw	    $t1, 0($t1)	     # load the contents at the adress $t1 into $t1
    div	    $t1, $s3	     # divide the current array member by 2 
    mfhi    $t1		     # move the remainder from the hi register to $t1
    
    addi    $t0, $t0, 1	     # increment the iterator
    
    sltu    $t1, $zero, $t1  # if zero is less than the remainder then it must be uneven
    beqz    $t1, L2
    nop
    addi    $s1, $s1, 1
    j	L1
    nop
    
    j	L1
    nop
    
L2:
    addi $s2, $s2, 1
    j	L1
    
L3:
    sw	    $s1, nOdd
    sw	    $s2, nEven
  
spin:
    j	spin
    nop

    .end main