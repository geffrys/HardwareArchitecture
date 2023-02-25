	.data
words:	.word 15, 0x15, 015, 0b11

	.text
vector:
    	@valor1: 
	.word 0x10
    	@valor2: 
	.word 30
    	@valor3: 
	.word 0x34
    	@vealor4:
	.word 0x20
	@valor5: 
	.word 60
@main:
	@usamos la operacion loadReagister, pues no permite usar mov
	@ldr r0, =valor1 @ carga el valor de valor1 en r0
	@ldr r1, =valor2 @ carga el valor de valor2 en r1
	@ldr r2, =valor3 @ carga el valor de valor3 en r2
	@ldr r3, =valor4 @ carga el valor de valor4 en r3
	@ldr r4, =valor5 @ carga el valor de valor5 en r4
stop: 	wfi
