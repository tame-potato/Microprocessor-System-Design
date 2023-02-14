#### Pablo Ruiz
	
# EECE.3170: Microprocessors I
# UMass Lowell
    
# Question 3 for HW 3

# 3.	(30 points) Implement the following program in which you will swap consecutive elements of the array



        .global    main

        .data
list:	.word	6, 150, 33, 472, 151, 109, 102

        .text
        .set	noreorder
        .ent	main

main:
	la	$s0, list		## $s0 = address of first element
	lw	$s1, 0($s0)		## $s1 = first element of the list at $s0 

addi $t0, $zero, 1
	
L1:
    slt   $t1, $t0, $s1	 
    
    beqz  $t1, L2
    nop
    
    sll   $t1, $t0, 2	    # $t1 = offset of first item in bytes
    addi  $t0, $t0, 1	    # increment the iterator
    sll   $t2, $t0, 2	    # $t2 = offset of second item in bytes
    
    add   $t1, $s0, $t1	    # $t1 = the address $s0 + $t1
    add   $t2, $s0, $t2	    # $t2 = the address $s0 + $t2
    
    lw	   $t3, 0($t1)	    # $t3 = contents at the $t1 address
    lw	   $t4, 0($t2)	    # $t4 = contents at the $t2 address
    
    sw	   $t4, 0($t1)	    # contents at $t1 address = $t4
    sw	   $t3, 0($t2)	    # contents at $t2 address = $t3
    
    j	   L1
    
    nop
    
L2:
	
## This code simply loops infinitely
spin:   j          spin
        nop

       .end        main