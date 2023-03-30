.text

number1: .word 34,43275
number2: .word -959818

main:	
	ldr r0, =number1
	ldr r1, =number2
	
	cmp r0, r1
	




endOf:	wfi

	
