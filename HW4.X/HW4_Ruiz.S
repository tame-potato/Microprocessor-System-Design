# EECE.3170: Microprocessors I
# UMass Lowell
# Original Author: Pablo Ruiz
# HW4_Ruiz.S: Homework 4 submission Spring 2021
    
# Program Description:
# 1. Initially LED1 and LED2 blink simultaneously
# 2. Pressing S1 should change between the following modes of operation:
#   2a. LED1 blinking, LED2 is off.
#   2b. LEDs blinking simultaneously.
#   2c. Both LEDs are off.
#   2d. LED1 and LED2 blinking every 1.5 seconds.
# 3. Pressing S2 should change between the following modes of operation:
#   3a. Only LED2 is blinking, LED1 off.
#   3b. LED2 blinking after 1.5 seconds and LED1 blinking at the same rate.
#    3c. LEDs alternating when one is on, the other is off.
#
    .text		## Text section contains code
    .set noreorder	## Disable instruction reordering
    .globl main		## Define main label as a global entity
    .ent main		##   and an entry point    


#include <xc.h>
    
main:
    
    sw	    zero, TRISA		    ## TRISA = 0  --> all PORTA bits = output
    sw	    zero, ANSELA	    ## ANSELA = 0 --> all PORTA bits digital
    
    not	    t0, zero		    
    sw	    t0, TRISB		    ## TRISB = 0xFFFFFFFF --> all PORTB bits = input
    sw	    zero, ANSELB	    ## ANSELB = 0 --> all PORTB bits digital
    
    sw	    zero, TRISC		    ## TRISC = 0  --> all PORTC bits = output
    sw	    zero, ANSELC	    ## ANSELC = 0 --> all PORTC bits digital
    
    li	    t0, _PORTA_RA0_MASK	    ## $t0 = 0x00000001 --> control LED1
    li	    t1, _PORTC_RC9_MASK	    ## t1 = 0x00000200 --> control LED2
    li	    t5, _PORTB_RB7_MASK	    ## t5 = 0x00000080 --> saved state of S1
    li	    t6, _PORTB_RB13_MASK    ## t6 = 0x00002000 --> saved state of S2
    li	    t8, 1		    ## Set new mode flag to true
    li	    s1, 2		    ## s1 = 2 --> set starting state
    li	    s2, 0		    ## s0 = 0 --> initialize s2 to zero.
    li	    s3, 1		    ## s3 = 1
    li	    s4, 2		    ## s4 = 2
    li	    s5, 3		    ## s5 = 3
    
pollS1:
    
    lw	    t2, PORTB		    ## Read Port B
    
    andi    t3, t2, _PORTB_RB7_MASK ## Check S1
				    ## If button isn't pressed, t3 = 0x00000080
				    ##  If button is pressed, t3 = 0x00000000
				 
    bne	    t3, zero, copyS1	    ## If button not pressed (RB7 = 1), 
    nop				    ##    copy state and check S2
    beq	    t3, t5, pollS2	    ## If button pressed but hasn't changed
    nop				    ##    check state of S2
    
    ## Must be a new button press--wait ~0.009 sec and check it again
    jal	    delay		    ## Call debounce function for delay
    nop
    
    ## Check if button still pressed
    lw	    t2, PORTB		    
    andi    t3, t2, _PORTB_RB7_MASK 
    bne	    t3, zero, copyS1
    nop
    
    slti    s0, s1, 4
    beq	    s0, zero, reset_s1	    ## If the current s1 mode is 4 or larger reset to 0 before iterating
    nop
    j	    iterate_mode_s1
    nop
    
reset_s1:
    and	    s1, s1, zero	    ## Reset to 0
    
iterate_mode_s1:
    addi    s1, s1, 1		    ## Iterate mode by 1 and set the mode of s2 to 0
    and	    s2, s2, zero
    li	    t8, 1		    ## Set new mode flag to true
    
copyS1:
    add	    t5, t3, zero	    ## t5 = saved state of S1
    
pollS2:
    andi    t4, t2, _PORTB_RB13_MASK ## Check S2
    bne	    t4, zero, copyS2	    ## If button not pressed (RB13 = 1), 
    nop				    ##    copy state and go back to checking S1
    beq	    t4, t6, pollS1	    ## If button pressed but hasn't changed
    nop				    ##    check state of S1

    ## Must be a new button press--wait ~0.01 sec and check it again
    jal	    delay		    ## Call debounce function for delay
    nop
    
    ## Check if button still pressed
    lw	    t2, PORTB		    
    andi    t4, t2, _PORTB_RB13_MASK 
    bne	    t4, zero, copyS2
    nop
    
    slti    s0, s2, 3
    beq	    s0, zero, reset_s2	    ## If the current s1 mode is 3 or larger reset to 0 before iterating
    nop
    j	    iterate_mode_s2
    nop
    
reset_s2:
    and	    s2, s2, zero	    ## Reset to 0
    
iterate_mode_s2:
    addi    s2, s2, 1		    ## Iterate mode by 1 and set the mode of s2 to 0
    and	    s1, s1, zero
    li	    t8, 1		    ## Set new mode flag to true
    
copyS2:
    add	    t6, t4, zero	    ## t6 = saved state of S2
       
main_logic:
    
    beq	    s1, zero, s2_mode1
    nop
    
s1_mode1:
    bne	    s1, s3, s1_mode2
    nop
    
    beq	    t8, zero, s1_mode1_repeat
    nop
    
    sw	    t0, LATASET		    ## Turn on LED1
    sw	    t1, LATCCLR		    ## Turn off LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s1_mode1_repeat:
    jal	    delay_0.5		    ## Delay 0.5 sec
    sw	    t0, LATAINV		    ## Switch LED1
    j	    pollS1		    ## Return to the beginning
    nop
    
s1_mode2:  
    bne	    s1, s4, s1_mode3
    nop
    
    beq	    t8, zero, s1_mode2_repeat
    nop
    
    sw	    t0, LATASET		    ## Turn on LED1
    sw	    t1, LATCSET		    ## Turn on LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s1_mode2_repeat:
    jal	    delay_0.5		    ## Delay 0.5 sec
    sw	    t0, LATAINV		    ## Switch LED1
    sw	    t1, LATCINV		    ## Switch LED2
    j	    pollS1		    ## Return to the beginning
    nop
    
    
s1_mode3:
    bne	    s1, s5, s1_mode4
    nop
    
    beq	    t8, zero, s1_mode3_repeat
    nop
    
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCCLR		    ## Turn off LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s1_mode3_repeat:
    j	    pollS1		    ## Return to the beginning
    nop
    
s1_mode4:
    beq	    t8, zero, s1_mode4_repeat
    nop
    
    sw	    t0, LATASET		    ## Turn on LED1
    sw	    t1, LATCSET		    ## Turn on LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s1_mode4_repeat:
    jal	    delay_1.5		    ## Delay 0.5 sec
    sw	    t0, LATAINV		    ## Switch LED1
    sw	    t1, LATCINV		    ## Switch LED2
    j	    pollS1		    ## Return to the beginning
    nop
    
s2_mode1:
    bne	    s2, s3, s2_mode2
    nop
    
    beq	    t8, zero, s2_mode1_repeat
    nop
    
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCSET		    ## Turn on LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s2_mode1_repeat:
    jal	    delay_0.5		    ## Delay 0.5 sec
    sw	    t1, LATCINV		    ## Switch LED1
    j	    pollS1		    ## Return to the beginning
    nop
    
s2_mode2:
    bne	    s2, s4, s2_mode3
    nop
    
    beq	    t8, zero, s2_mode2_repeat
    nop
    
    sw	    t0, LATASET		    ## Turn on LED1
    sw	    t1, LATCSET		    ## Turn on LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s2_mode2_repeat:
    jal	    delay_1.5		    ## Delay 0.5 sec
    sw	    t0, LATAINV		    ## Switch LED1
    sw	    t1, LATCINV		    ## Switch LED2
    j	    pollS1		    ## Return to the beginning
    nop
    
s2_mode3:
    beq	    t8, zero, s2_mode3_repeat
    nop
    
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCSET		    ## Turn on LED2
    and	    t8, t8, zero	    ## Set new mode flag to false
    
s2_mode3_repeat:
    jal	    delay_0.5		    ## Delay 0.5 sec
    sw	    t0, LATAINV		    ## Switch LED1
    sw	    t1, LATCINV		    ## Switch LED2
    j	    pollS1		    ## Return to the beginning
    nop
    
spin:
    j	spin
    nop

    .end main
    
    .ent delay_0.5
delay_0.5:
    li	    t7, 0x00155555
blink_0.5:
    
    addi    t7, t7, -1		    ## Decrement counter
    bne	    t7, zero, blink_0.5	    ##  and continue doing that until we hit 0
    nop
    
    jr	    ra
    nop
    .end delay_0.5
    
    .ent delay_1.5
delay_1.5:
    li	    t7, 0x003FFFFF  
blink_1.5:
    
    addi    t7, t7, -1		    ## Decrement counter
    bne	    t7, zero, blink_1.5	    ##  and continue doing that until we hit 0
    nop
    
    jr	    ra			    
    nop
    .end delay_1.5
    
    .ent delay
delay:
    li	    t7, 0x61A8		    ## Set delay counter to 0x61A8 = 25,000
				    ## Since loop body has 3 instructions,
				    ##   loop takes 25,000 * 3 = 75,000
				    ##   cycles
				    ## Remaining 3 instructions take 3 cycles
				    ##  ~75,000 cycles / 8 MHz clock ~ 0.009375 sec delay
loop:
    addi    t7, t7, -1		    ## Decrement counter
    bne	    t7, zero, loop	    ##  and continue doing that until we hit 0
    nop				    ## NOTE: This function originally branched
				    ##   to "done" if t7 != zero, which means
				    ##   the delay loop was really no loop at all!
    jr	    ra
    nop
    .end delay