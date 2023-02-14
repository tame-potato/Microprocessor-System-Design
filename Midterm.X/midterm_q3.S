## Pablo Ruiz

## EECE.3170: Microprocessors I
## UMass Lowell

## Program 3 for the midterm exam

## Implement the following program in which you will swap consecutive 
## elements of the array based on the condition 
## and compute the sum of all elements moved from left to right during swapping

## N is the number of swaps. Test the program on N=3
## M is the number of elements in the array
## N<M 
## Only swap if the element is greater than or equal to 2X of the current number

## For example
## First swap	10, 40, 8, 20, 4, 17, 4, 25, 11, 7, 21    Sum = 0
##		40, 10, 8, 20, 4, 17, 4, 25, 11, 7, 21    Sum = 10
## Second swap	40, 10, 20, 8, 4, 17, 4, 25, 11, 7, 21    Sum = 10 + 8  = 18
## Third Swap	40, 10, 20, 8, 17, 4 , 4, 25, 11, 7, 21   Sum = 18 + 4  = 22

## Your array should be stored as a data structure where the first word is 
## the number of elements in the array, followed by the elements of the array.  
## Each element is an integer.

    .global    main
    .data

sum1:  .word    0
M   :  .word    11
N   :  .word    3
arr1:  .word	10, 40, 8, 20, 4, 17, 4, 25, 11, 7, 21

    .text
    .set       noreorder
    .ent       main

main:
    la  $a0, arr1	    # a0 = starting address of arr1
    lw	$s0, M		    # s0 = number of elements in address
    lw	$s1, N		    # s1 = number of swaps
    lw	$s2, sum1           # s2 = the sum

    add $t0, $zero, $zero	    # t0 = array iterator
    add $t1, $zero, $zero	    # t1 = swap iterator
	
L1:
    slt   $t2, $t0, $s0 
    
    beqz  $t2, L2
    nop
    
    sll   $t2, $t0, 2	    # $t1 = offset of first item in bytes
    addi  $t0, $t0, 1	    # increment the iterator
    sll   $t3, $t0, 2	    # $t2 = offset of second item in bytes
    
    add   $a1, $a0, $t2	    # $a1 = the address $s0 + $t2
    add   $a2, $a0, $t3	    # $a2 = the address $s0 + $t3
    
    lw	   $t2, 0($a1)	    # $t2 = contents at the $t2 address
    lw	   $t3, 0($a2)	    # $t3 = contents at the $t3 address
    
    sll	   $t4, $t2, 1	    # $t2 = $t2 * 2
    
    slt	   $t4, $t3, $t4    # if 2 times the current number is smaller than the next number then False
    nor	   $t4, $t4, $t4    # swap true for false in order to make sure if the numbers are the same the swap still occurs
    slt	   $t5, $t1, $s1    # if the swap iterator is less than the max number of swaps then True
    
    and	   $t4, $t4, $t5    # if both t4 and t5 are True then True
    
    beqz  $t4, L1	    # if True then swap
    nop
    
    sw	   $t2, 0($a2)	    # save the value of the current array member into the next one
    sw	   $t3, 0($a1)	    # save the value of the next array member into the current one
    
    add	   $s2, $s2, $t2    # add the current member to the sum
    addi  $t1, $t1, 1	    # increment swap iterator
    
    j	L1
    nop  
    
    nop
    
L2:
    sw	    $s2, sum1
    
spin:
    j	spin
    nop

    .end main