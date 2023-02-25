.data
bytel:	.byte	0x11
.balign 2 @alinea el siguiente valor a direcciones de memoria multiplo de 2
space:	.space 4
byte2:	.byte 0x22
.balign 4 @alinea el siguiente valor para direcciones de memoria multiplo de 4
word:	.word 0xAABBCCDD

	.text
stop:		wfi
