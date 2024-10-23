.global _start
		.equ      TIMER_BASE, 0xFF202000
		.equ      COUNTER_DELAY, 100000000
		.equ	  LEDs, 0xff200000

_start: movia      r20, TIMER_BASE      # base address of timer


            stwio      r0, 0(r20)         # clear the TO (Time Out) bit in case it is on
            movia      r8, COUNTER_DELAY    # load the delay value
            srli       r9, r8, 16           # shift right by 16 bits
            andi       r8, r8, 0xFFFF       # mask to keep the lower 16 bits
            stwio      r8, 0x8(r20)         # write to the timer period register (low)
            stwio      r9, 0xc(r20)         # write to the timer period register (high)
            movi       r8, 0b0110           # enable continuous mode and start timer
            stwio      r8, 0x4(r20)         # write to the timer control register to 
											# and go into continuous mode
											
			movia 		r21,LEDs

			movi r10, 1
			
tloop:	   stwio r10,0(r21)		# write into LED0
			xori  r10,r10,1		#flip bit
			
	# now wait
	
ploop:     ldwio      r8, 0x0(r20)         # read the timer status register
            andi       r8, r8, 0b1          # mask the TO bit
            beq        r8, r0, ploop     # if TO bit is 0, wait
            stwio      r0, 0x0(r20)         # clear the TO bit
			
			br tloop
			
			