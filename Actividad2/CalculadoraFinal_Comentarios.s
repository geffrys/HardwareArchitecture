	.data
num1:	.word 0x1	@Numero1 Operando
num2:	.word 0x4	@Numero2 Operador
opera:	.byte '/'	@Operacion a realizar
	.text
main:	
	ldr r0, =num1	@Cargar la direccion de memoria Numero1 sobre el registro 0
	ldr r0, [r0]	@Se carga el valor que esta en la direccion de memoria en el registro 0
	ldr r1, =num2	@Cargar la direccion de memoria Numero2 sobre el registro 1
	ldr r1, [r1]	@Se carga el valor que esta en la direccion de memoria en el registro 1
	ldr r2, =opera	@Cargar la Operacion aritmetica sobre el registro 2
	ldr r2, [r2]	@Se carga el valor que esta en la direccion de memoria en el registro 2
	cmp r2, #0x2b	@Compara OperacionAritmetica de el registro r2 con #0x2b (suma en Hexa)
	beq suma	@Hace salto a la subrutina de Suma
	cmp r2, #0x2d	@Compara OperacionAritmetica de el registro r2 con #0x2d (resta en Hexa)
	beq resta	@Hace salto a la subrutina de Resta
	cmp r2, #0x2a	@Compara OperacionAritmetica de el registro r2 con #0x2a (multiplicacion en Hexa)
	beq multiplica	@Hace salto a la subrutina de Multiplicacion
	cmp r2, #0x2f	@Compara OperacionAritmetica de el registro r2 con #0x2f (division en Hexa)
	beq divide	@Hace salto a la subrutina de Division
stop: 			@Para el coddigo
	wfi		@Finaliza el programa
suma:			@Subrutina suma
	add r7, r0, r1	@Suma Valores de Registro0 y Registro1 y los guarda en Registro7
	b stop 		@Para el programa
resta:			@Subrutina resta
	sub r7, r0, r1	@Resta Valores de Registro0 y Registro1 y los guarda en Registro7
	b stop		@Para el programa
multiplica:		@Subrutina multiplicacion
	ldr r7, =num1	@Se carga la direccion de memoria de num1 en el registro7
	ldr r7, [r7]	@Se carga el valor de registro7 en el registro7
	mul r7, r1	@Multiplica el numero que esta en el registro7 por el numero que esta en el registro1
	b stop		@Para el programa
divide:			@Subrutina Division
	mov r2, r0	@Mueve al registro2 lo que esta en el registro0 para no perder el valor original del reg0(Num1)
	cmp r0,#0	@Compara el registro0 con el numero 0 para asegurar que el dividendo no sea 0
	beq stop	@Para el programa
	bmi SignoR0	@Compara si el valor anterior que se comparo es menor que cero
	cmp r1, #0	@Compara el registro0 con el numero 0 para asegurar que el divisor no sea 0
	beq stop	@Para el programa
	bmi SignoR1	@Compara si el valor anterior que se comparo es menor que cero
	b ciclo		@Salta a la Subrutina Ciclo
positivo:		@Subrutina Positivo (Cuando la comparacion en subrutina ciclo r6=2)
	sub r6, #2	@Limpia registro restando 2 al registro de r6
	b continuacion	@Salta a subrutina continuacion
negativo: 		@subrutina negativo (Cuando la comparacion en subrutina ciclo r6 es menor que 2)
	neg r7, r7	@Cambia el signo a negativo del valor que hay en R7
	b continuacion	@Salta a subrutina continuacion
ciclo: 			@subrutina ciclo
	cmp r0, r1	@Compara el registro 1 con el registro 2
	bge vciclo	@Compara si r0 es mayor o igual a r1 para saber si entra o no hacer resta(Las veces que sea necesario)
	mov r3, r7	@Cuando ya no entra vciclo (No hay mas restas) Mueve el valor que esta en r7 a r3
	cmp r6, #0	@Compara r6 con el numero 0, para saber si va tener decimal o resultado va ser negat o posit
	beq continuacion@Salta a subrutina continuacion
	cmp r6, #2	@Compara r6 con el numero 2 por si ambos registros son negativos
	beq positivo	@Si la comparacion anterior es = 2 Salta a subrutina Positivo
	bmi negativo	@Si la comparacion anterior es = 1 Salta a subrutina negativo
continuacion:		@Subrutina continuacion
	mov r6, #0	@Se borra lo que se tenga en el registro 6 y se registra el numero 0 (Limpia registro)
	mul r3, r1	@Multiplica lo que hay en el registo r3 por lo que hay en el registro1(Se obtiene residuo)
	sub r4, r2,r3	@Resta entre r2 y r3 donde se Obtiene el residuo, se registra en r4
	cmp r4, #0	@Compara que lo que este en r4 sea diferente de 0, Si es igual es porque no hay decimales
	beq stop	@Para el programa
	mov r5, #10	@Si no es = a 0 a R5 se le va a registrar un 10
	mul r4, r5	@Se multiplica el r4 por el 10 en r5 para asegurar que el numero a dividir sea mayor
	mov r5, #0	@Se borra lo que se tenga en el registro 6 y se registra el numero 0 (Limpia registro)
	b decimal	@Salta a subrutina decimal
	bmi stop	@Para el programa
vciclo: sub r0, r1	@Se le resta a r0 el valor que hay r1
	add r7, #1	@Cada vez que entre a vciclo es un entero que se le sumara al registro 7
	b ciclo		@Salta a subrutina ciclo
decimal:		@Subrutina Decimal
	add r0, #1	@Suma al registro cero una unidad(Verificandoresultadodecimal_noesnecesario)
	b ciclod	@Salta a subrutina ciclod
ciclod: 		@Subrutina ciclod
	cmp r4, r1	@Compara el registro r4 con el registro r1
	bge vciclod	@Compara si r4 es mayor o igual a r1 para saber si entra o no hacer resta(Las veces que sea necesario)
	bmi stop	@Para el programa cuando r4 es menor a r1
vciclod:		@Subrutina vciclod
	sub r4, r1	@Resta sucesiva mientras que r4 sea mayor a r1, se restra r1 a r4
	add r6, #1	@Contador de resta Sucesiva que seria el Decimal
	b ciclod	@Salta a subrutina ciclod
SignoR0: 		@Subrutina SignoR0 (Si entra aca es porque cambia signo a r0)
	neg r0, r0	@Cambia el signo al valor que hay r0 y lo registra en r0
	add r6, #1	@R6 es una bandera para identificar si ambos son registros son negativos
	b divide	@Salta a subrutina divide
SignoR1:		@Subrutina SignoR1 (Si entra aca es porque cambia signo a r1)
	neg r1, r1	@Cambia el signo al valor que hay r1 y lo registra en r1
	add r6, #1	@R6 es una bandera para identificar si ambos son registros son negativos
	b divide	@Salta a subrutina divide
