.data
word1: 	.word 15
word2: 	.word 0x15
word3:	.word 015
word4:	.word 0b11

vector:
	.word 0x10
	.word 30
	.word 0x34
	.word 0x20
	.word 60

.text

stop: 	wfi
