#### Pablo Ruiz
	
# EECE.3170: Microprocessors I
# UMass Lowell
    
# Question 1 for HW 3

# 1.	(35 points) Implement the conditional statement shown below (A, B, X and Y are variables). Assume A =10, B = 6. Initial values of X, Y are 0.

        .global    main

        .data
a:	.word	10
b:	.word	6
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
	
## if (X < 10) {
## Y = X + A;}
slti $t0, $s2, 10
beqz $t0, L1
nop
add $s3, $s0, $s2
j   L3
nop

## else if (Y > B) {
## X = Y ? A;
## }
L1:
    slt $t0, $s1, $s3
    beqz $t0, L2
    nop
    sub $s2, $s3, $s0
    j	L3
    nop

## else {
## X = Y + 4;
## Y = X + 4;
## } 
L2:
    addi $s2, $s3, 4
    addi $s3, $s2, 4
    
L3:
    sw $s0, a
    sw $s1, b
    sw $s2, x
    sw $s3, y
	
## This code simply loops infinitely
spin:   j          spin
        nop

       .end        main