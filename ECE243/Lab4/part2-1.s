.global _start
_start:
	movia sp, 0x20000
	/*Initialize LEDs and KEYs */
	.equ LEDs, 0xFF200000
	.equ KEYs, 0xFF200050
	
	movia r8, LEDs
	movia r9, KEYs
	movia r10, COUNTER
	/*Initial LED=0, timer=0 */
	stwio r0, 0(r8)
	stw r0, 0(r10)
	
	call StopCounting
	call SetCount1second
	
	programLoop:
		/*Check The keys and Change Start / Stop Status*/
		call checkKEYs
		/*Add as long as no key is released*/
		call incrementCounter
		/*Set LED to Our Counter Value*/
		call LEDsGoGoGo
		
	br programLoop


LEDsGoGoGo:
	ldw r2, 0(r10)
	stwio r2, 0(r8)
	ret

/*Counter Speed Settings*/	
SetCount1second:/*Set Counting up every 1 second */
	movia r5, 0xFFFF
	stw r5, 8(r10)
	stw r5, 12(r10)
	ret
/*Counter Speed Settings*/	
	
/*Check KEYs Program*/	
checkKEYs:
	ldwio r5, 0(r9)
	bne r5, r0, KEYPressed
	ret
/*Check KEYs Program*/

/*Increment Counter Program*/
incrementCounter:

	/*Check if Counter Status is stop*/
	ldw r2, 4(r10)
	andi r2, r2, 0x8
	bne r2, r0, StatusIsStart
	ret
	
	StatusIsStart:
	/*Delay Loop*/
	delay:
	ldw r2, 8(r10)
	subi r2, r2, 1
	stw r2, 8(r10)
	beq r2, r0, delayfinish
	br delay
	/*Delay Finished*/
	delayfinish:
	/*Restore Delay Counter*/
	ldw r2, 12(r10)
	stw r2, 8(r10)
	/*Addition of Our counter of 1*/
	ldw r2, 0(r10)
	
	movi r3, 0xFF
	beq r2, r3, maxedBound
	br notReachedMaxBound
	
	maxedBound:
	stw r0, 0(r10)
	ret
	
	notReachedMaxBound:
	addi r2, r2, 1
	stw r2, 0(r10)
	ret
/*Increment Counter Program*/


/*Deeper Logic Of Check Keys*/
KEYPressed:
	
	ldwio r5, 0(r9)
	beq r5, r0, ChangeStatus/*If any key is pressed Change Status*/
	
	
	/*Push ra*/
	addi sp, sp, -4
	stw ra, 0(sp)
	/*Keep Increment if not released*/ /*THIS LINE IS IMPORTANT*/
	call incrementCounter
	/*Pop ra*/
	ldw ra, 0(sp)
	addi sp, sp, +4
	
	br KEYPressed

ChangeStatus:
	
	/*If started, stop*/
	ldw r2, 4(r10)
	andi r2, r2, 0x4
	bne r2, r0, StopCounting

	/*If stopped, start*/
	ldw r2, 4(r10)
	andi r2, r2, 0x8
	bne r2, r0, StartCounting
	
	ret

	
StopCounting:/*Initialize timer Stop = true*/
	movi r5, 0x8
	stw r5, 4(r10)
	ret
	
StartCounting:/*Start Counting*/
	movi r5, 0x4
	stw r5, 4(r10)
	ret
	
	
	

	




.data

COUNTER: .word 0
