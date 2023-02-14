# EECE.3170: Microprocessors I
# UMass Lowell
# Original Author: Pablo Ruiz
# HW5_Ruiz.S: Homework 5 submission Spring 2021
    
# Program Description:
# 1. Initially LED1 and LED2 blink simultaneously
# 2. Timer configuration should use a pre-scaler of 256 and period of 0x0FFF 
# 3. Pressing S1 should change between the following modes of operation:
#   3a. LED1 blinking, LED2 is off.
#   3b. LEDs blinking simultaneously.
#   3c. Both LEDs are off.
#   3d. LED1 off and LED2 blinking.
#
    
    // Interrupt vector setup timer 
    .globl  __vector_dispatch_11    ## Timer 1 interrupt = vector #11
    .section .vector_11, code, keep
    .align 2
    .set nomips16
    .ent __vector_dispatch_11
__vector_dispatch_11:
    j  isrvector11	    ## Jump to actual ISR code, which is in text section
    nop
    .end __vector_dispatch_11
    .size __vector_dispatch_11, .-__vector_dispatch_11
    
    // Interrupt vector setup S1    
    .globl  __vector_dispatch_9    ## Port B change notification = vector #9
    .section .vector_9, code, keep
    .align 2
    .set nomips16
    .ent __vector_dispatch_9
__vector_dispatch_9:
    j  isrvector9	    ## Jump to actual ISR code, which is in text section
    nop
    .end __vector_dispatch_9
    .size __vector_dispatch_9, .-__vector_dispatch_9
    
    .data
    
    s2Array: .space 24
    
    .text		## Text section contains code
    .set noreorder	## Disable instruction reordering
    .globl main		## Define main label as a global entity
    .ent main		##   and an entry point    


#include <xc.h>
    
main:
    
    // Array Values
    addi t0, zero, 0x0FFF
    addi t1, zero, 0x1FFE
    addi t2, zero, 0x3FFC
    addi t3, zero, 0x7FF8
    addi t4, zero, 0xFFF0
    addi t5, zero, 0x0FFF
    
    // Array Index
    addi s6, zero, 0
    
    // Set address of s2Array to s7
    la s7, s2Array
    
    // Load values into array
    sw t0, (s7)
    addi s7, s7, 4
    sw t1, (s7)
    addi s7, s7, 4
    sw t2, (s7)
    addi s7, s7, 4
    sw t3, (s7)
    addi s7, s7, 4
    sw t4, (s7)
    addi s7, s7, 4
    sw t5, (s7)
    
    // Reset address
    la s7, s2Array
    
    // Initialize end flag
    addi s8, zero, 0
    
   // Set variables
    li	    s1, 1		    ## s1 = 0
    li	    s2, 1		    ## s2 = 1
    li	    s3, 1		    ## s3 = 1
    li	    s4, 2		    ## s4 = 2
    li	    s5, 3		    ## s5 = 3
    
   /* Configure I/O ports--LEDs on Port A & C; switches on Port B */
    sw	    zero, TRISA		    ## TRISA = 0  --> all PORTA bits = output
    sw	    zero, ANSELA	    ## ANSELA = 0 --> all PORTA bits digital
    li	    t0, _PORTB_RB7_MASK
    ori	    t0, t0, _PORTB_RB13_MASK
    sw	    t0, TRISB		    ## TRISB = 0x00002080 --> pins 7 & 13 inputs
    sw	    zero, ANSELB	    ## ANSELB = 0 --> all PORTB bits digital  
    sw	    zero, TRISC		    ## TRISC = 0  --> all PORTC bits = output
    sw	    zero, ANSELC	    ## ANSELC = 0 --> all PORTC bits digital

    li	    t4, _PORTB_RB7_MASK	    ## t4 = 0x00000080 --> mask for S1
    li	    t6, _PORTB_RB13_MASK    ## t6 = 0x00002000 --> mask for S2
    
   // Configure Timer 1
    sw	    zero, T1CON		    ## Clear T1CON--disables timer to allow setup
    
    li	    t1, 0x0FFF		    ## Set t1 = 0x0FFF = initial PR1 value
    sw	    t1, PR1		    ##   (maximum possible clock period--65,535 cycles)
    
    li	    t2, _IFS0_T1IF_MASK	    ## t2 = bit mask for checking Timer 1 interrupt flag
    
    ## Prescale clock
    li	    t3, _T1CON_TCKPS_MASK  ## Prescale by factor of 256         
    sw	    t3, T1CONSET
    
    // Configure interrupts
    lui	    t3, 0x0001			## Want INTCON bit 16 (VS<0>) = 1
					##   so vectors 8 bytes apart
					
    ori	    t3, t3, _INTCON_MVEC_MASK   ## Enable multivectored interrupt mode
    sw	    t3, INTCON
    
    li	    t3, _IPC2_CNBIP_MASK    ## Set change notification Port B interrupt priority level to 7
    
    li	    t7, _IPC2_T1IP_MASK	    ## Set T1 interrupt priority level to 7
    or	    t3, t3, t7
    
    sw	    t3, IPC2		    ## Implicitly sets subpriority level to 0
    
    li	    t3, _IEC0_CNBIE_MASK    ## Enable Port B change 
    or	    t3, t3, t2
    sw	    t3, IEC0		    ##    notification interrupts

    add	    t3, t4, zero	    ## Set bits in CNEN1B = 1 and CNEN0B = 0
    or	    t3, t3, t6		    ##   corresponding to switch positions
    sw	    t3, CNEN1B		    ##   (t4 = S1 bit mask; t6 = S2 bit mask)
    sw	    zero, CNEN0B	    ## Will detect falling edges on these pins
    
    li	    t3, _CNCONB_ON_MASK		    ## Enables Port B change notification
    ori	    t3, t3, _CNCONB_CNSTYLE_MASK    ## Enables edge detection
    sw	    t3, CNCONB
    
    ei				    ## Set global interrupt enable
    
    li	    t3, _T1CON_TON_MASK	    ## Enable Timer 1 by setting "ON" bit in T1CON
    sw	    t3, T1CONSET
    
    ## Set Mask for LED1, and LED2
    li	    t0, _PORTA_RA0_MASK	    ## LED1
    li	    t1, _PORTC_RC9_MASK	    ## LED2
    
// Main loop does nothing--interrupts detect button press, 
//    handle LED toggling
mainloop:
    
    bne	    s8, zero, end
    nop
    j	mainloop
    nop
    
end:
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCCLR		    ## Turn off LED2
    sw	    zero, IEC0		    ## clear notifications
    sw	    zero, IPC2		    ## clear priority levels
    
spin:
    j	    spin
    nop
    
    .end main
    
    // Delay loop for switch debouncing
    .global delay
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
    nop				    
    jr	    ra
    nop

    .end delay
    
// Handle Port B change interrupt--check switches and toggle appropriate LEDs
    .global isrvector9
    .ent isrvector9
isrvector9:   
    li	    t4, _PORTB_RB7_MASK	    ## t4 = 0x00000080 --> mask for S1
    li	    t6, _PORTB_RB13_MASK    ## mask for S2
    
    // Check S1
    lw	    t8, CNFB
    and	    t9, t8, t4
    beq	    t9, zero, checkS2	    ## If bit 7 = 0, S1 wasn't pressed
    nop
    
    // S1 pressed--clear flag, then debounce and toggle if actually pressed
    sw	    t4, CNFBCLR		    ## Clear flag for S1
    jal	    delay		    ## Delay to debounce
    nop
    lw	    t2, PORTB		    
    and	    t2, t2, t4		    ## Is button still pressed?
    bne	    t2, zero, checkS2	    ## If not, leave LED alone and check S2
    nop
    
    slti    s0, s1, 4
    beq	    s0, zero, reset_s1	    ## If the current s1 mode is 4 or larger reset to 0 before iterating
    nop
    j	    iterate_mode_s1
    nop
    
reset_s1:
    and	    s1, s1, zero	    ## Reset to 0
    
iterate_mode_s1:
    addi    s1, s1, 1		    ## Iterate mode by 1
    li	    s2, 1		    ## Set new mode flag to true
    j	    intdone
    nop
    
checkS2:
    and	    t9, t8, t6
    beq	    t9, zero, intdone	    ## If bit 13 = 0, S2 wasn't pressed
    nop
    
    // S2 pressed--clear flag, then debounce and toggle if actually pressed
    sw	    t6, CNFBCLR		    ## Clear flag for S2
    jal	    delay		    ## Delay to debounce
    nop
    lw	    t2, PORTB		    
    and	    t2, t2, t6		    ## Is button still pressed?
    bne	    t2, zero, intdone	    
    nop

    // S2 task
    addi    s6, s6, 4
    addi    s7, s7, 4
    
    slti    t3, s6, 24
    
    beq	    t3, zero, endFlag
    nop
    
    sw	    zero, T1CON		    ## Clear T1CON--disables timer to allow setup
    
    lw	    t3, (s7)
    sw	    t3, PR1
    
        ## Prescale clock
    li	    t3, _T1CON_TCKPS_MASK  ## Prescale by factor of 256         
    sw	    t3, T1CONSET
    
    li	    t3, _T1CON_TON_MASK	    ## Enable Timer 1 by setting "ON" bit in T1CON
    sw	    t3, T1CONSET
    
    j	    intdone
    nop
    
endFlag:
    addi    s8, zero, 1
    
intdone:
    li	    t3, _IFS0_CNBIF_MASK    ## Clear Port B change notification flag
    sw	    t3, IFS0CLR		    ##    in IFS0
    eret		    ## Return from interrupt
    nop
    .end isrvector9
    
// Handle Timer1 interrupt--clear interrupt flag and toggle LED
    .global isrvector11
    .ent isrvector11
isrvector11:
    
    li	    t2, _IFS0_T1IF_MASK    
    sw	    t2, IFS0CLR		    ## Clear T1IF in software!
    
s1_mode1:
    bne	    s1, s3, s1_mode2
    nop
    
    beq	    s2, zero, s1_mode1_repeat
    nop
    
    sw	    t0, LATASET		    ## Turn on LED1
    sw	    t1, LATCCLR		    ## Turn off LED2
    and	    s2, s2, zero	    ## Set new mode flag to false
    
s1_mode1_repeat:
    sw	    t0, LATAINV		    ## Switch LED1
    sw	    t1, LATCCLR		    ## Turn off LED1
    eret			    ## Return from interrupt
    nop
    
s1_mode2:  
    bne	    s1, s4, s1_mode3
    nop
    
    beq	    s2, zero, s1_mode2_repeat
    nop
    
    sw	    t0, LATACLR		    ## Turn on LED1
    sw	    t1, LATCCLR		    ## Turn on LED2
    and	    s2, s2, zero	    ## Set new mode flag to false
    
s1_mode2_repeat:
    sw	    t0, LATAINV		    ## Switch LED1
    sw	    t1, LATCINV		    ## Switch LED2
    eret			    ## Return from interrupt
    nop
    
    
s1_mode3:
    bne	    s1, s5, s1_mode4
    nop
    
    beq	    s2, zero, s1_mode3_repeat
    nop
    
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCCLR		    ## Turn off LED2
    and	    s2, s2, zero	    ## Set new mode flag to false
    
s1_mode3_repeat:
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCCLR		    ## Turn off LED2
    eret			    ## Return from interrupt
    nop
    
s1_mode4:
    beq	    s2, zero, s1_mode4_repeat
    nop
    
    sw	    t0, LATACLR		    ## Turn off LED1
    sw	    t1, LATCSET		    ## Turn on LED2
    and	    s2, s2, zero	    ## Set new mode flag to false
    
s1_mode4_repeat:
    sw	    t1, LATCINV		    ## Switch LED2
    sw	    t0, LATACLR		    ## Turn off LED1
    eret			    ## Return from interrupt
    nop

    .end isrvector11