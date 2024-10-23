.text
/* Program to Count the number of 1’s in a 32-bit word,
located at InputWord */
.global _start
_start:
/* Your code here */
	
	movia r8, InputWord
	ldw r9, 0(r8)
	movia r10, Answer
	
	movi r11, 1
	movi r12, 0
	movi r13, 32
	movi r14, 0
	
loop:
	and r12, r11, r9
	subi r13, r13, 1
	beq r12, r0, dada
	bne r12, r0, dudu
	
dada: 
	muli r11, r11, 2
	beq r13, r0, finish
	br loop

dudu:
	addi r14, r14, 1
	br dada
	
finish:
	stw r10, 0(r14)
	br endiloop
	
endiloop: br endiloop
.data
InputWord: .word 0x4a01fead
Answer: .word 0
