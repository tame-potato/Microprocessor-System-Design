    .global main
    .text
    .set noreorder
    .ent main
main:
    li $t1, 0x0000FFFF
    li $t2, 0xFFFF0000
    add $t3, $t1, $t2
    addu $t4, $t1, $t2
    
    ## This code simply loops infinitely
spin:   j          spin
        nop

      
    .end main