.text

main:
	ldr r0, =0x1
	ldr r1, =0xF
	@Realizamos la comparacion entre estos numeros
	cmp r0, r1
	@Saltos
	bgt mayor
	@En caso de que no sea mayor r0 que r1
	
