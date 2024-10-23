.global _start
_start:
	
	movi r8, 0
	movi r9, 30
	movi r10, 0
	
cond: 
	blt r8, r9, then

else:
	mov r12, r10
	br fever

then:
	addi r8, r8, 1
	add r10, r10, r8
	br cond

fever:
	br fever