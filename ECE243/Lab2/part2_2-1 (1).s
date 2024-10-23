.text  # The numbers that turn into executable instructions
.global _start
_start:

/* r13 should contain the grade of the person with the student number, -1 if not found */
/* r10 has the student number being searched */


	movia r10, 718293		# r10 is where you put the student number being searched for
	
	movia r4, Snumbers 		# r11 is student numbers
	
	movia r5, Grades 		# r12 is grades
	
	movia r6, n			# Snumber index
	movia r7, m			# Grade index
	
	movia r8, result		# r18 is the result grade
	
	movia r9, index			# int i = 0

loop: 
	
	ldb r20, 0(r9)
	add r20, r20, r20		# 2i
	add r20, r20, r20		# 4i
	add r20, r20, r4	
	
	
	
	mov r11, r20			# Snumbers[i] in r10

/*xxx*/

cond: 
	ldw r21, 0(r8)
	beq r21, r0, notFound		# Not Found at all	
	br continue

notFound: 
	br done

continue: 
	
	ldw r22, 0(r11)
	beq r22, r10, found			# Found, branch found
	br increment				# not found, increment
			
found: 
	mov r6, r9				# Found, set index n = i
	br GetGrade					# Go to GetGrade
	

increment:
	ldb r20, 0(r9)
	addi r20, r20, 1
	stb r20, 0(r9)			# i++
	br loop
/* Your code goes here  */

GetGrade:
							# address of grade index [7]
	ldb r23, 0(r9)
	add r6, r5, r23	
	ldb r8, 0(r6)			# Grade[i] in r18

done: #show on led

	.equ LEDs, 0xFF200000
	movia r25, LEDs
	stwio r8, (r25)
	br done




.data  	# the numbers that are the data 

/* result should hold the grade of the student number put into r10, or
-1 if the student number isn't found */ 
result: .byte -1
.align 2

/* Snumbers is the "array," terminated by a zero of the student numbers  */
Snumbers: .word 10392584, 423195, 644370, 496059, 296800
        .word 265133, 68943, 718293, 315950, 785519
        .word 982966, 345018, 220809, 369328, 935042
        .word 467872, 887795, 681936, 0
		

index: .byte 0
		
n: .byte 0
m: .byte 0
/* Grades is the corresponding "array" with the grades, in the same order*/
Grades: .byte 99, 68, 90, 85, 91, 67, 80
        .byte 66, 95, 91, 91, 99, 76, 68  
        .byte 69, 93, 90, 72
.align 2
		 


	