	.text
main:	mov r0, #32
	mov r1, #1
	lsr r0, r1
	lsr r0, r1
	lsr r0, r1
	lsl r0, r1
	lsl r0, r1
	lsl r0, r1
stop:	wfi
