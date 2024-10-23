.global _start
_start:
	
	/*Initialize LEDs and KEYs */
	.equ LEDs, 0xFF200000
	.equ KEYs, 0xFF200050
	movia r8, LEDs
	movia r9, KEYs
	/*Initial LED=0 */
	stwio r0, 0(r8)
	
	
Check:
	ldwio r2, 0(r9)
	
	
	
check0:
	/*Check the first last digit*/
	andi r10, r2, 0x1 /*get first last digit*/
	bne r10, r0, Pressed0 /*If the first last digit is not 0, it is pressed*/ 
	
check1:
	/*Check the second last digit*/
	andi r11, r2, 0x2
	bne r11, r0, Pressed1 /*If the second last digit is not 0, it is pressed*/ 
	
check2:
	/*Check the third last digit*/
	andi r12, r2, 0x4
	bne r12, r0, Pressed2 /*If the third last digit is not 0, it is pressed*/ 
	
check3:
	/*Check the forth last digit*/
	andi r13, r2, 0x8
	bne r13, r0, Pressed3 /*If the forth last digit is not 0, it is pressed*/ 

br Check
	
	
Pressed0:
	ldwio r2, 0(r9)
	andi r10, r2, 0x1 /*get first last digit*/
	
	beq r10, r0, Released0 /*If the first last digit is again 0, it is released*/
	br Pressed0	/*Continue to be pressed*/
	
Pressed1: 
	ldwio r2, 0(r9)
	andi r11, r2, 0x2 /*get Second last digit*/
	
	beq r11, r0, Released1 /*If the second last digit is again 0, it is released*/
	br Pressed1 /*Continue to be pressed*/

Pressed2:
	ldwio r2, 0(r9)
	andi r12, r2, 0x4 /*get Third last digit*/
	
	beq r12, r0, Released2 /*If the third last digit is again 0, it is released*/
	br Pressed2 /*Continue to be pressed*/

Pressed3:
	ldwio r2, 0(r9)
	andi r13, r2, 0x8 /*get first last digit*/
	
	beq r13, r0, Released3 /*If the forth last digit is again 0, it is released*/
	br Pressed3 /*Continue to be pressed*/




Released0:
	/*Set number displayed to 1*/
	movi r4, 0x1
	stwio r4, 0(r8)
	br Check
	
Released1:
	/*Number ++ */
	ldwio r4, 0(r8)
	movi r18, 0xF
	beq r4, r18, Check
	addi r4, r4, 1
	stwio r4, 0(r8)
	br Check

Released2:
	/*Number -- */
	ldwio r4, 0(r8)
	movi r19, 0x1
	beq r4, r19, Check
	subi r4, r4, 1
	stwio r4, 0(r8)
	br Check
	
Released3:
	/*Blank the display*/
	stwio r0, 0(r8) 

	call load3
	
	beq r4, r14, Pressed3_0
	beq r5, r15, Pressed3_1
	beq r6, r16, Pressed3_2
	beq r7, r17, Pressed3_3
	
	br Released3
	
Pressed3_0:	
	call load3
	bne r4, r14, Released0
	br Pressed3_0
Pressed3_1:
	call load3
	bne r5, r15, Released0
	br Pressed3_1
Pressed3_2:
	call load3
	bne r6, r16, Released0
	br Pressed3_2
Pressed3_3:
	call load3
	bne r7, r17, Released0
	br Pressed3_3
	
load3:
	/*Load from the KEYs*/
	ldwio r2, 0(r9)
	andi r4, r2, 0x1
	andi r5, r2, 0x2
	andi r6, r2, 0x4
	andi r7, r2, 0x8
	
	movi r14, 0x1
	movi r15, 0x2
	movi r16, 0x4
	movi r17, 0x8
	
	ret


