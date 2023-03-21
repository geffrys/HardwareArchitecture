.text
main:	mov r0, #10
	mov r1, #6
	mov r2, #6
	cmp r0, r1
	cmp r1, r0
	cmp r1, r2
stop:	wfi

@queda en duda cual es el indicador C 
