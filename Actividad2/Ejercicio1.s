.text
main:
	ldr r1, =0xFF
	ldr r2, =0x10203040 @ pc guarda direccion de memoria de la siguiente instruccion.
	wfi
