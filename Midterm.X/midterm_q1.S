
## Pablo Ruiz

## EECE.3170: Microprocessors I
## UMass Lowell
## Program 1 for midterm exam

## The program contains 10 comments, numbered C1-C10, and each
##   comment describes an operation that can be done in *one* instruction.
##   (No, really, I mean it this time--only one instruction.)
## Replace each comment with a single instruction that performs the
##   designated operation. Note that:
##      1. Pseudo-instructions are acceptable
##      2. Your solution should be general--don't write code that only
##          works for the sample variable values given.
##      3. Your solution should successfully assemble and run--code that does
##          not assemble will lose credit

    .data
v1:	.word	    10
v2:	.word	    100
v3:	.word	    0x10192020
v4:	.word	    20
N:      .word       5		# Natural number threshold for C9

    .text		# Text section contains code
    .set noreorder	# Disable instruction reordering
    .globl main		# Define main label as a global entity
    .ent main		#   and an entry point

main:

    ## Copy variables into registers
    lw	    $t0, v1
    lw	    $t1, v2
    lw	    $t2, v3
    lw      $s3, v4

    ## *** START ADDING CODE BELOW THIS POINT--REPLACE EVERY COMMENT NUMBERED C1-C10
    ## More than 1 instructions are allowed for all parts

    ## C1: $t3 = $t1 * 14, without using a multiply instruction
    sll	    $t3, $t1, 3
    sll	    $s4, $t1, 2
    sll	    $s5, $t1, 1
    add	    $t3, $t3, $s4
    add	    $t3, $t3, $s5

    ## C2: $t4 = $t1 / 6, without using a divide instruction AND keeping the sign intact
    sra	    $t4, $t1, 3
    sra	    $s4, $t1, 5
    sra	    $s5, $t1, 6
    add	    $t4, $t4, $s4   
    add	    $t4, $t4, $s5

    ## C3: $t5 = $t2 with the lowest 4 bits flipped (inverted) and the upper 28 bits staying the same
    xori    $t5, $t2, 0xF

    ## C4: $t6 = $t4 / $t5
    div	    $t6, $t4, $t5

    ## C5: $t7 = 0x0000DEEF without using the li pseudo-instruction
    ori    $t7, $zero, 0xDEEF

    ## C6: $t8 = value in $t2 with all bits cleared except the upper 8 bits
    li	    $t8, 0xFF
    sll	    $t8, $t8, 24
    and     $t8, $t2, $t8

    ## C7: $t9 = difference between $t7 and $t0
    sub	    $t9, $t7, $t0

    ## C8: $s0 = 1 if $t2 < $t0; otherwise, $s0 = 0
    slt   $s0, $t2, $t0
    
    beqz  $s0, L1
    nop
    
    li	   $s0, 1
    
    j	L2
    nop
    
    L1:
	li  $s0, 0
	
    L2:
    
    ## C9: $s1 = sum of first N Natural numbers. Test using N=5 and use a loop
    lw	  $s2, N
    add	  $s5, $zero, $zero
    add	  $s1, $zero, $zero
    
    L3:
	slt	  $s4, $s5, $s2

	beqz      $s4, L4
	nop
	
	addi	  $s5, $s5, 1
	add	  $s1, $s1, $s5
	
	j	L3
	nop
    
    L4:
    
    ## C10: store the value of $s1 at the address  of variable v4
    sw	$s1, v4
                             
spin:
    j	spin
    nop

   .end main