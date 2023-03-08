	.data
word1:	.word 0x10203040
word2:	.word 0x11213141
word3:	.word 0x12223242

	.text
main:	ldr r0, =word1
	mov r1, #8
	ldr r2, [r0]
	ldr r3, [r0, #4]
	ldr r4, [r0, r1]
	wfi
