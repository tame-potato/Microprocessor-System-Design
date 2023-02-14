#### Pablo Ruiz
	
# EECE.3170: Microprocessors I
# UMass Lowell
    
# Question 3 for HW 2 
#
# The program below contains several comments (all of which start with ##)
#   describing an operation to be performed on one or more of the variables
#   declared at the start of the program. Replace each ## comment with *one*
#   appropriate instruction to complete the program (or, as I've done below,
#   simply move each comment to the right of the instruction)
	
### EACH INSTRUCTION YOU USE MUST BE A BITWISE, SHIFT, OR ROTATE INSTRUCTION


# SOME OF THE "INSTRUCTIONS" LISTED BELOW ACTUALLY REQUIRE MULTIPLE INSTRUCTIONS
#  THESE LINES HAVE BEEN MARKED, AND YOU ARE ALLOWED TO USE >1 INSTRUCTION FOR
#  EACH ONE OF THE MARKED LINES (THE LINES THAT CHANGE $t0, $t1, AND $t6)

#   This program gives you some practice working with bitwise,
#     shift, and rotate operators

        .global    main

        .data
v1:	.word	12
v2:	.word	0xFEEDABEE

        .text
        .set	noreorder
        .ent	main

main:
	lw	$s1,v1		## $s1 = v1
	lw	$s2,v2		## $s2 = v2
	
## ***REQUIRES >1 INSTRUCTION***: $t0 = v2 with lowest 12 bits cleared (set to 0), other bits staying the same
	li	$t0, 0xFFFFF000
	and     $t0,$s2,$t0
	
## ***REQUIRES >1 INSTRUCTION***: $t1 = v2 with 8 highest bits set to 0, other bits staying the same 
	li	$t1,0x00FFFFFF
	and     $t1,$s2,$t1
	
## $t2 = v1 multiplied by 8 *without* using a multiply instruction
	sll     $t2,$s1,3
	
## ***REQUIRES >1 INSTRUCTION***: $t3 = v2 multiplied by 12 *without* using a multiply instruction
	sll     $t3,$s2,2
	sll     $t7,$s2,3
	add     $t3,$t3,$t7
	
## $t4 = v1 divided by 2 *without* using a divide instruction
	sra     $t4,$s1,1
	
## $t5 = v2 with the lowest 16 bits flipped (inverted) and the upper 16 bits staying the same
	xori    $t5,$s2,0xFFFF
	
## ***REQUIRES >1 INSTRUCTION***:## $t6 = 0xFD000010 without using the li pseudo-instruction 
	xori    $t6,$s2,0x13
	sll     $t6,$t6,24
	xori    $t6,$t6,0x10
	
# This code simply loops infinitely
spin:   j          spin
        nop

       .end        main