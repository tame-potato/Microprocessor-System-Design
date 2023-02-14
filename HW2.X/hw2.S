    .global main
    .text
    .set noreorder
    .ent main
main:
    li $t1,0x400009EA
    sh $t1, 9($s0)
    .end main