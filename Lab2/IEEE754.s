

.data
	@variables
numbers:.word 0x4433AAFF
		@0	10001000	01100111010101011111111
	.word 0x3344FFCC	@this will be saved on 20070004 memory direction
		@0	01100110	10001001111111111001100
	.word 0x80000000


.text

main:
	ldr r0, =numbers
	@ Cargamos los registros
	ldr r1, [r0, #0]
	ldr r2, [r0, #4] @number2 4 pos more in index	
	
	@ Hallaremos las potencias de ambos numeros
potencia1:	mov r3, r1
	@0100	0100	0011	0011	1010	1010	1111	1111
	@1000	1000	0110	0111	0101	0101	1111	1110 con lsl
	@ le quitamos el numero del signo moviendo a la izquierda
	lsl r3, #1
	@movemos a la derechaqueda numero positivo sobrante entonces r3 mayor que r4 24 bits
	@queda en queda numero positivo sobrante entonces r3 mayor que r4
	@0000	0000	0000	0000	0000	0000	1000	1000
	lsr r3, #24
	lsl r3, #24
	@replicamos lo mismo de arriba
potencia2:	mov r4, r2
	lsl r4, #1
	lsr r4, #24
	lsl r4, #24
	@0000	0000	0000	0000	0000	0000	0110	0110
	@Realizamos la comparacion de las potencias. igualaremos a la mayor 
biggest:	cmp r3, r4
	@0000	0000	0000	0000	0000	0000	1000	1000
	@0000	0000	0000	0000	0000	0000	0110	0110
	@0	0	0	0	0	0	8	8	
	@0	0	0	0	0	0	6	6
	@0	0	0	0	0	0	2	2
	@bne branch not equals to 0
	@beq branch equals to 0
	@bpl branch if plus, positivo y cero
	@bmi branch if minus
	@ in this case we got bpl case, but we need to use the cases beq equals to 0
	@ if there's an positive number in flag, uses the bpl case
	bpl bigger 
	beq mantizas
	mov r3, r4
bigger: mov r4, r3
	@ potencias listas
mantizas: 
	mov r5, r1
	lsl r5, #9
	@	0110	0111	0101	0101	1111	1110
	@	6	7	5	5	F	E
	@lsr r5, #9
	mov r6, r2
	lsl r6, #9
	@lsr r6, #9
	@	1000	1001	1111	1111	1001	1000
	@	8	9	F	F	9	8

conversionMantizas:
	@lo corremos una vez a la derecha para sumarle el 1 faltante
	@	0110	0111	0101	0101	1111	1110
	@	0011	0011	1010	1010	1111	1111
	@	3	3	A	A	F	F
	lsr r5, #1
	ldr r7, [r0, #8]
	add r5, r7 @at this point we add 80000000 to our mantiza. add one to the most significative number
	@1011	0011	1010	1010	1111	1111	0000	0000	

	@lsl r7, #8
	@	1000	1001	1111	1111	1001	1000
	@	0100	0100	1111	1111	1100	1100
	@	4	4	F	F	C	C
	lsr r6, #1
	add r6, r7 @the same way line 74
	@1100	0100	1111	1111	1100	1100	0000	0000

	@lsl r8, #8
	
	@	0100	0100	1111	1111	1100	1100	0000	0000
	@	1000	0000	0000	0000	0000	0000	0000	0000
		

		

@suma:	add r8, r5, r6
@resta:	sub r9, r5, r6
@multi:	mul r10, r5, r6



end:	wfi
