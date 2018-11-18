######################################################################
## Fichero: Alcance.asm
## Descripción: Programa que calcula el alcance en un movimiento parabolico
## Fecha última modificación: 2016-03-07
## Autores: Claudia Cea, Lucía Colmenareho (Pareja 3)
## Asignatura: EC. 1º grado
## Grupo de Prácticas: 2101
## Grupo de Teoría: 210
## Práctica: 4
## Ejercicio: 2
######################################################################

.text #comienzo de seccion de codigo
main:
# $s1 = angulo, $s2 = resultado
lw $s1, angulo #Guardamos el valor del angulo en R17
addi $sp, $0, 0x4000 #Inicializamos el stack pointer al valor 0x4000
sll $s3, $s1, 2 #Multiplicamos el ángulo por 4, para indicar la posición de memoria del alcance correspondiente en el array lut y lo guardamos en R19
addi $sp, $sp, -4 #Reservamos espacio en la pila para guardar el registro
sw $s3, 0($sp) #Hacemos push y guardamos R19 en la pila
jal calculaAlcance #Llamamos a la funcion
lw $s2, 0($sp) #Hacemos pop de la pila y guardamos el valor del alcance en R18, que habiamos asignado para guardar el resultado 
addi $sp, $sp, 4 #Liberamos el espacio de pila usado
sw $s2,resultado($0) #Escribimos el valor del resultado en R18
bucle: j bucle #bucle en el que se queda para dar por finalizado el ejercicio
 
calculaAlcance:
lw $t1, 0($sp) #Hacemos pop de la pila y guardamos el contenido del últio elemento introducido en la pila en R9 
addi $sp, $sp, 4 #Liberamos el espacio de pila usado
lw $t2 , lut($t1) #Guardamos el valor del alance correspondiente en R10
addi $sp, $sp, -4 #Reservamos espacio en la pila para guardar el registro
sw $t2, 0($sp) #Hacemos push y guardamos R10 en la pila
jr $ra #Regresamos a la rutina principal


.data #Comienzo de seccion de datos
.align 2 #Direccion alineanda a palabra
lut: 0, 6, 11, 17, 23, 28, 34, 39, 45, 50, 56, 61, 66, 72, 77, 82, 
87, 91, 96, 101, 105, 109, 113, 117, 121, 125, 129, 132, 135, 138, 
141, 144, 147, 149, 151, 153, 155, 157, 158, 160, 161, 162, 162, 
163, 163, 163 #Array lut que guarda el alcance
angulo: 10 #Variable angulo
resultado:0 #Variable resultado inicializada a 0