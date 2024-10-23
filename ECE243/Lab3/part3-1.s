.text
/* Program to Count the number of 1’s in a 32-bit word,
located at InputWord */
.global _start
_start:
/* Your code here */

main:

movia r8, TEST_NUM
movia r15, LargestOnes
movia r16, LargestZeroes


br largestOnes
tag1:

movia r8, TEST_NUM

br largestZeros
tag2:


endloop:
br endloop




largestOnes:
ldw r4, 0(r8)
beq r4, r0, tag1

call ONES

ldw r17, 0(r15)
bge r2, r17, store1

incre1:
addi r8, r8, 4
br largestOnes

store1:
stw r2, 0(r15)
br incre1






largestZeros:
ldw r4, 0(r8)
beq r4, r0, tag2
movi r21, 0xFFFFFFFF
xor r4, r4, r21

call ONES

ldw r18, 0(r16)
bge r2, r18, store2

incre2:
addi r8, r8, 4
br largestZeros

store2:
stw r2, 0(r16)
br incre2









ONES:
movi r11, 1
movi r12, 0
movi r13, 32
movi r14, 0

loop:
and r12, r11, r4
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
mov r2, r14
ret













.data
TEST_NUM:  .word 0x4a01fead, 0xF677D671,0xDC9758D5,0xEBBD45D2,0x8059519D
            .word 0x76D8F0D2, 0xB98C9BB5, 0xD7EC3A9E, 0xD9BADC01, 0x89B377CD
            .word 0  # end of list

LargestOnes: .word 0
LargestZeroes: .word 0
