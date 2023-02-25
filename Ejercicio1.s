.text
main:
	mov r0, #0
	mov r1, #10
loop:
	mov r2,  r1
	mul r2, r1
	mul r2, r1
	add r0, r0, r2
	sub r1, r1, #1
	bne loop
stop:	
	wfi
	.end
