# EECE.3170: Microprocessors I
# UMass Lowell
# Author: S. W. Son
# timerTes.S: in-class example to demonstrate timers
           
    .text		## Text section contains code
    .set noreorder	## Disable instruction reordering
    .globl main		## Define main label as a global entity
    .ent main		##   and an entry point    

#
// PIC32MM0064GPL036 Configuration Bit Settings

// 'C' source line config statements

// FDEVOPT
#pragma config SOSCHP = OFF             // Secondary Oscillator High Power Enable bit (SOSC oprerates in normal power mode.)
#pragma config USERID = 0xFFFF          // User ID bits (Enter Hexadecimal value)

// FICD
#pragma config JTAGEN = OFF              // JTAG Enable bit (JTAG is enabled)
#pragma config ICS = PGx1               // ICE/ICD Communication Channel Selection bits (Communicate on PGEC1/PGED1)
					// PGx3 for debugging?

// FPOR
#pragma config BOREN = BOR3             // Brown-out Reset Enable bits (Brown-out Reset enabled in hardware; SBOREN bit disabled)
#pragma config RETVR = OFF              // Retention Voltage Regulator Enable bit (Retention regulator is disabled)
#pragma config LPBOREN = ON             // Low Power Brown-out Enable bit (Low power BOR is enabled, when main BOR is disabled)

// FWDT
#pragma config SWDTPS = PS1048576       // Sleep Mode Watchdog Timer Postscale Selection bits (1:1048576)
#pragma config FWDTWINSZ = PS25_0       // Watchdog Timer Window Size bits (Watchdog timer window size is 25%)
#pragma config WINDIS = OFF             // Windowed Watchdog Timer Disable bit (Watchdog timer is in non-window mode)
#pragma config RWDTPS = PS1048576       // Run Mode Watchdog Timer Postscale Selection bits (1:1048576)
#pragma config RCLKSEL = LPRC           // Run Mode Watchdog Timer Clock Source Selection bits (Clock source is LPRC (same as for sleep mode))
#pragma config FWDTEN = ON              // Watchdog Timer Enable bit (WDT is enabled)

// FOSCSEL
#pragma config FNOSC = LPRC             // Oscillator Selection bits (Low power RC oscillator (LPRC))
#pragma config PLLSRC = FRC             // System PLL Input Clock Selection bit (FRC oscillator is selected as PLL reference input on device reset)
#pragma config SOSCEN = ON              // Secondary Oscillator Enable bit (Secondary oscillator is enabled)
#pragma config IESO = ON                // Two Speed Startup Enable bit (Two speed startup is enabled)
#pragma config POSCMOD = OFF            // Primary Oscillator Selection bit (Primary oscillator is disabled)
#pragma config OSCIOFNC = OFF           // System Clock on CLKO Pin Enable bit (OSCO pin operates as a normal I/O)
#pragma config SOSCSEL = OFF            // Secondary Oscillator External Clock Enable bit (SOSC pins configured for Crystal mode)
#pragma config FCKSM = CSECME           // Clock Switching and Fail-Safe Clock Monitor Enable bits (Clock switching is enabled; Fail-safe clock monitor is enabled)

// FSEC
#pragma config CP = OFF                 // Code Protection Enable bit (Code protection is disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
    
main:
    // Configure port A for output
    sw	    zero, TRISA		    ## TRISA = 0  --> all PORTA bits = output
    sw	    zero, ANSELA	    	    ## ANSELA = 0 --> all PORTA bits digital
    li	    t0, _PORTA_RA0_MASK	    ## $t0 = 0x00000001
    sw	    t0, LATASET		    ## Set Port A, bit 0 (turn LED1 on)

    // Configure Timer 1
    sw	    zero, T1CON		    ## Clear T1Con -- including ON=0, 
    
    ori	    t1, zero, 65535          ## Set t1 = 0xFFFF = initial PR1 value
    sw	    t1, PR1		    ## maximum possible clock period -- 65,535 
    
    li	    t2, _IFS0_T1IF_MASK	    ## t2 = bit mask for checking T1IF 
    sw	    t2, IFS0CLR		    ## Clear T1IF 

    // Setting prescaler
    lw	    s1, T1CON
    li	    s2, 0x00000020	    ## Set prescaler to 0b10 => 1:64
    or	    s3, s1, s2
    sw	    s2, T1CON

    li	    t5, _T1CON_TON_MASK	    ## enable timer 1 by setting ON=1
    sw	    t5, T1CONSET
toggle:
				    ##   Toggles LED about every 1.5 seconds
delay:
    //addi    t1, t1, -1		    ## Decrement counter
    //bne	    t1, zero, delay. ##  and continue doing that until we hit 0
    lw	    t4, IFS0
    li	    t6, 0x00000800
    and	    t7, t4, t6
    beq	    t7, zero, delay
    nop

    //li	    t2, _IFS0_T1IF_MASK	    ## t2 = bit mask for checking T1IF 
    sw	    t2, IFS0CLR		    ## Clear T1IF 

    sw	    t0, LATAINV		    ## toggles LED1
  
    j	    toggle		    ## Reset delay counter and start again
    nop
spin:
    j	spin
    nop

    .end main