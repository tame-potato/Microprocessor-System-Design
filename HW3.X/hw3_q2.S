#### Pablo Ruiz
	
# EECE.3170: Microprocessors I
# UMass Lowell
    
# Question 2 for HW 3

# 2.	(35 points) Implement the loop shown below (A, B, X and Y are variables). Assume A, B = 60. Initial values of X, Y are 0.



        .global    main

        .data
a:	.word	60
b:	.word	60
x:	.word	0
y:	.word	0

        .text
        .set	noreorder
        .ent	main

main:
	lw	$s0,a		## $s0 = a
	lw	$s1,b		## $s1 = b
	lw	$s2,x		## $s2 = x
	lw	$s3,y		## $s3 = y
	
	
## while ((X < A) || (Y < B)) {
## X = X +1;
## Y = Y +2;
## }

L1:
    slt $t0, $s2, $s0
    slt $t1, $s3, $s1
    or $t0, $t0, $t1
    beqz $t0, L2
    nop
    addi $s2, $s2, 1
    addi $s3, $s3, 2
    j	L1
    nop
    
L2:
    sw $s0, a
    sw $s1, b
    sw $s2, x
    sw $s3, y
	
## This code simply loops infinitely
spin:   j          spin
        nop

       .end        main