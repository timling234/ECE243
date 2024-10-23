.text  # The numbers that turn into executable instructions
.global _start
_start:

/* r13 should contain the grade of the person with the student number, -1 if not found */
/* r10 has the student number being searched */


	movia r10, 718293		# r10 is where you put the student number being searched for
	
	movia r11, Snumbers 	# r11 is student numbers
	
	movia r12, Grades 		# r12 is grades
	
	movia r13, n			# r13 is inedx of target student
	
	movia r18, result		# r18 is the result grade
	
	movia r18, -1
	
	movia r14, 0			# int i = 0
	
loop: 
	
	add r15, r14, r14		# 2i
	add r16, r15, r15		# 4i
	
	
	add r16, r16, r11		
	ldw r17, 0(r16)			# Snumbers[i] in r17
	
cond: 
	beq r17, r0, notFound		# Not Found at all	
	br continue

notFound: 
	
	br done

continue: 
	beq r17, r10, found			# Found, branch found
	br increment				# not found, increment
			

found: 
	mov r13, r14				# Found, set index n = i
	br GetGrade				# Go to GetGrade

increment:
	addi r14, r14, 1			# i++
	br loop
	
GetGrade:
	add r16, r13, r13
	add r16, r16, r16		# 4r16 = 4*7=28
	add r16, r16, r12		# address of grade index [7]
	
	ldw r18, 0(r16)			# Grade[i] in r18


	
/* Your code goes here  */

done: #show on led

	.equ LEDs, 0xFF200000
	movia r25, LEDs
	stwio r18, (r25)
	br done



.data  	# the numbers that are the data 

/* result should hold the grade of the student number put into r10, or
-1 if the student number isn't found */ 

result: .word 0
		
/* Snumbers is the "array," terminated by a zero of the student numbers  */
Snumbers: .word 10392584, 423195, 644370, 496059, 296800
        .word 265133, 68943, 718293, 315950, 785519
        .word 982966, 345018, 220809, 369328, 935042
        .word 467872, 887795, 681936, 0

/* Grades is the corresponding "array" with the grades, in the same order*/
Grades: .word 99, 68, 90, 85, 91, 67, 80
        .word 66, 95, 91, 91, 99, 76, 68  
        .word 69, 93, 90, 72
		 
	
n: .word 0
	