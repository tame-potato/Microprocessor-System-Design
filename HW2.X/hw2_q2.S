#### Pablo Ruiz
	
# EECE.3170: Microprocessors I
# UMass Lowell
    
# Question 2 for HW 2
#  (adapted from: http://www.cs.unca.edu/brock/classes/Spring2017/csci255/labs/mips32asmintro/index.html)
#
# The program below contains several comments (all of which start with ##)
#   describing an operation to be performed on one or more of the variables
#   declared at the start of the program. Replace each ## comment with *one*
#   appropriate instruction to complete the program (or, as I've done below,

#   When complete, the program implements the operation:
#	z = a*x*x + b + c*x 

        .global    main

        .data
a:      .int       2	    # Remember, an int is a signed word (32 bits)
b:      .int       8
c:      .int       17
x:      .int       10
z:      .int       -1

        .text
        .set       noreorder
        .ent       main

main:
        lw         $t0,a	    ##	$t0 = a
##      $t1 = b
	lw         $t1,b
##      $t2 = c
	lw         $t2, c
##      $t3 = x
	lw         $t3, x
        mul        $t4,$t0,$t3	    ##	$t4 = a*x

##      $t4 = $t4*x
	mul        $t4,$t4,$t3

##      $t5 = c*x
	mul        $t5,$t2,$t3

# finish rest of the program
	
##      $t4 = a*x*x + b
	add        $t4,$t4,$t1
	
##      $t4 = a*x*x + b + c*x
	add        $t4,$t4,$t5
	
##      z = $t4
	sw $t4,z
        
	
# This code simply loops infinitely--we'll cover jump (j) instructions soon
spin:   j          spin
        nop

       .end        main
