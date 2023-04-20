

.data
	@variables
numbers:.word 0x4433AAFF
		@0	10001000	01100111010101011111111
	.word 0x3344FFCC	@ esta se guardara en la posicion 20070004
		@0	01100110	10001001111111111001100
	.word 0x80000000


.text

main:
	ldr r0, =numbers
	@ Cargamos los registros
	ldr r1, [r0, #0]
	ldr r2, [r0, #4] @number2 a 4 posiciones de memoria

signos:
	mov r3, r1
	asr r3, #31
	str r3, [r0, #12] @ guardamos signo en el registro 2007000C de memoria
	
	mov r4, r2
	asr r4, #31
	str r4, [r0, #16] @ guardamos signo en el registro 20070010 de memoria
	
potencia1: @ Hallaremos las potencias de ambos numeros	
	mov r3, r1
	@0100	0100	0011	0011	1010	1010	1111	1111
	@1000	1000	0110	0111	0101	0101	1111	1110 con lsl
	@ le quitamos el numero del signo moviendo a la izquierda
	lsl r3, #1
	@movemos a la derechaqueda numero positivo sobrante entonces r3 mayor que r4 24 bits
	@queda en queda numero positivo sobrante entonces r3 mayor que r4
	@0000	0000	0000	0000	0000	0000	1000	1000
	lsr r3, #24
	lsl r3, #24
	
potencia2: @replicamos lo mismo de arriba	
	mov r4, r2
	lsl r4, #1
	lsr r4, #24
	lsl r4, #24
	@0000	0000	0000	0000	0000	0000	0110	0110
	@Realizamos la comparacion de las potencias. igualaremos a la mayor 

comparacion:	cmp r3, r4
	@0000	0000	0000	0000	0000	0000	1000	1000
	@0000	0000	0000	0000	0000	0000	0110	0110
	@0	0	0	0	0	0	8	8	
	@0	0	0	0	0	0	6	6
	@0	0	0	0	0	0	2	2
	@ en este caso nos vamos por bpl, pero necesitamos tambien usar el caso beq
	@ si se prende la bandera positiva, usara bpl
	bpl mayor @ r3 mayor que r4
	beq mantizas
	mov r3, r4
mayor: mov r3, r3 @ es redundante decir esto pero quizas lo hace mas claro
	
@ la potencia queda en r3


mantizas: 
	mov r4, r1
	lsl r4, #9
	@	0110	0111	0101	0101	1111	1110
	@	6	7	5	5	F	E
	@lsr r5, #9
	mov r5, r2
	lsl r5, #9
	@lsr r6, #9
	@	1000	1001	1111	1111	1001	1000
	@	8	9	F	F	9	8


	@ Esta porcion de codigo sobra pues para operar no hay necesidad de añadir este numero	

			@ conversionMantizas:
			@ 	@lo corremos una vez a la derecha para sumarle el 1 faltante
			@ 	@	0110	0111	0101	0101	1111	1110
			@ 	@	0011	0011	1010	1010	1111	1111
			@ 	@	3	3	A	A	F	F
			@ 	lsr r5, #1
			@ 	ldr r7, [r0, #8]
			@ 	add r5, r7 @En este punto le sumamos 80000000 a la mantiza, que seria como sumarle 1 en el ultimo numero
			@ 	@1011	0011	1010	1010	1111	1111	0000	0000	

			@ 	@lsl r7, #8
			@ 	@	1000	1001	1111	1111	1001	1000
			@ 	@	0100	0100	1111	1111	1100	1100
			@ 	@	4	4	F	F	C	C
			@ 	lsr r6, #1
			@ 	add r6, r7 @igual que la linea 70
			@ 	@1100	0100	1111	1111	1100	1100	0000	0000


			@ 	@	0100	0100	1111	1111	1100	1100	0000	0000
			@ 	@	1000	0000	0000	0000	0000	0000	0000	0000

@Las operaciones no se pueden hacer de manera tan arbitraria



@ 1. teniendo las mantizas en r5 y r6 vamos a operar estas
@ pero vamos a tener en cuenta los signos
@ y estar pendiente de construir bien el formato


@ a este punto tenemos libres r6 y r7
suma:


@ suma:	add r7, r5, r6
	@1110	1110	1010	1011	0011	0011	0000	0000
	
@ resta:	sub r7, r5, r6

@ multi:		
	@ mul r7, r5, r6

end:	wfi
