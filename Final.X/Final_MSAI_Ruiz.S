/**** Pablo Ruiz ****/
## Link to your recording: https://studentuml-my.sharepoint.com/:v:/g/personal/pablo_ruiz_student_uml_edu/EYlrnE_6Z81KqIQ0c0d4u8AB-cirl0tWukGEi3TrMrWnEQ?e=T7gK8z
## EECE.3170: Microprocessors I
## UMass Lowell
## Spring 2021 final exam programming problem
## You are open to having your design of the solution based on your interpretation
/*****
  TODO:
     
  You must change this program so that:
    1. Create the following variables:
      array_s1 = [1,3,3,2];
      n1 = 4;   // number of element of array_s1
      m1 = 2;   // array index
    2. Your program should detect each press of S1 using switch interrupt.
     
    3. The program changes the state of LED1 based on the following conditions:
       If S1 is pressed the same number of times as the value of array_s1 at m1 index, LED1 turns on
     
       For example, since m1 is 2, which means 3 is the m1-th element (2nd) of array_s1. So LED1 should be turned on only when S1 is pressed 3 times.
       
    4. If S1 is pressed 4 times, LED1 blinks with period 0x0FFF and Prescaler 256.

*****/
    
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
    
    array_s1:  .int   1,3,3,2	# Declare Array with values 1,3,3,2
    n1:	    .int    4		# Declare n1 as 4
    m1:	    .int    2		# Declare m1 as 2
    size:   .int    4		# Declare the size of each index in the array in this case 32 bits which is 4 bytes
    
    .text		## Text section contains code
    .set noreorder	## Disable instruction reordering
    .globl main		## Define main label as a global entity
    .ent main		##   and an entry point    
    
#include <xc.h>
    
main:
    
    /* load variables */
    lw	    s1, n1	    ## load the value at n1 into the s1 register
    lw	    s2, m1	    ## load the value at m1 into the s2 register
    lw	    s3, size	    ## load the value stored in size into s3 register
    la	    t3, array_s1    ## load initial address of array_s1 into t3 register
    mul	    t4, s2, s3	    ## obtain the total offset to find the desired value
    add	    t3, t3, t4	    ## obtain final address
    lw	    s4, (t3)        ## obtain desired value from array and store in s4
    addi    s5, s4, 1	    ## the value at which the LED flashes is 1 higher than the value at which it turns on
    
    
    // Configure I/O ports--LEDs on Port A & C; switches on Port B 
    sw	    zero, TRISA		    ## TRISA = 0  --> all PORTA bits = output
    sw	    zero, ANSELA	    ## ANSELA = 0 --> all PORTA bits digital
    li	    t0, _PORTB_RB7_MASK
    ori	    t0, t0, _PORTB_RB13_MASK
    sw	    t0, TRISB		    ## TRISB = 0x00002080 --> pins 7 & 13 inputs
    sw	    zero, ANSELB	    ## ANSELB = 0 --> all PORTB bits digital  
    sw	    zero, TRISC		    ## TRISC = 0  --> all PORTC bits = output
    sw	    zero, ANSELC	    ## ANSELC = 0 --> all PORTC bits digital

    li	    t4, _PORTB_RB7_MASK	    ## t4 = 0x00000080 --> mask for S1
    
   // Configure Timer 1
    sw	    zero, T1CON		    ## Clear T1CON--disables timer to allow setup
    
    li	    t1, 0x0FFF		    ## Set t1 = 0x0FFF = initial PR1 value
    sw	    t1, PR1		    ##   (maximum possible clock period--65,535 cycles)
    
    li	    t2, _IFS0_T1IF_MASK	    ## t2 = bit mask for checking Timer 1 interrupt flag
    
    ## Prescale clock
    li	    t3, _T1CON_TCKPS_MASK   ## Prescale by factor of 256         
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
    sw	    t3, CNEN1B		    ##   (t4 = S1 bit mask; t6 = S2 bit mask)
    sw	    zero, CNEN0B	    ## Will detect falling edges on these pins
    
    li	    t3, _CNCONB_ON_MASK		    ## Enables Port B change notification
    ori	    t3, t3, _CNCONB_CNSTYLE_MASK    ## Enables edge detection
    sw	    t3, CNCONB
    
    ei				    ## Set global interrupt enable
    
    li	    t3, _T1CON_TON_MASK	    ## Enable Timer 1 by setting "ON" bit in T1CON
    sw	    t3, T1CONSET
    
    ## Set Mask for LED1
    li	    t0, _PORTA_RA0_MASK	    ## LED1
    
    ## Make sure the S1 press counter begins at 0
    addi    t1, zero, 0
    
main_loop:
    
    j	    main_loop
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
    
    // Check S1
    lw	    t8, CNFB
    and	    t9, t8, t4
    beq	    t9, zero, intdone	    ## If bit 7 = 0, S1 wasn't pressed
    nop
    
    // S1 pressed--clear flag, then debounce and toggle if actually pressed
    sw	    t4, CNFBCLR		    ## Clear flag for S1
    jal	    delay		    ## Delay to debounce
    nop
    lw	    t2, PORTB		    
    and	    t2, t2, t4		    ## Is button still pressed?
    bne	    t2, zero, intdone	    ## If not, leave LED alone and check S2
    nop
    
    slt	    t3, t1, s5
    beq	    t3, zero, reset_s1	    ## If the current t1 mode is s5 or larger reset to 0 before iterating
    nop
    j	    iterate_mode_s1
    nop
    
reset_s1:
    and	    t1, t1, zero	    ## Reset to 0
    j	    intdone
    nop
    
iterate_mode_s1:
    addi    t1, t1, 1		    ## Iterate mode by 1
    j	    intdone
    nop
    
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
    
untimed:
    
    bne	    t1, s4, timed	    ## if t1 is not s4 then check if its s5, else turn on and end
    nop
    sw	    t0, LATASET		    ## Turn on LED1
    j	    end
    nop
    
    
timed:
    
    bne	    t1, s5, standby	    ## if t1 is not s5 then make sure the LED is off
    nop
    sw	    t0, LATAINV		    ## INVERT LED1
    j	    end
    nop
    
standby:
    sw	    t0, LATACLR		    ## Turn off LED1
    
end:
    eret
    nop

    .end isrvector11