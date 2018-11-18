######################################################################
## Fichero: Vectores.asm
## Descripción: Programa que trabaja con vectores
## Fecha última modificación: 2016-03-07
## Autores: Claudia Cea, Lucía Colmenareho (Pareja 3)
## Asignatura: EC. 1º grado
## Grupo de Prácticas: 2101
## Grupo de Teoría: 210
## Práctica: 4
## Ejercicio: 1
######################################################################

.text # Comienzo de seccion de codigo
main: 
 #$s0 = i, $s1 = C
 lw $t0, C #Cargamos la variable C en R8 
 addi $s0, $0, 0 #Inicialización de i
 addi $s1, $0, 40 #Inicialización de N
 for: slt $t1, $s0, $s1 #Comprobación de la condición i<N
 beq $t1, $0, done #Si la condición no se cumple sale del bucle
 #Cuerpo del bucle 
 lw $s2, A($s0) #Cargamos la variable A[i] en R18 
 lw $s3, B($s0) #Cargamos la variable B[i] en R19 
 sll $s3, $s3, 3 #Multiplicamos la variable B[i] por 8 utilizando tres desplazamientos lógicos a la izquierda
 sub $t0, $s2, $s3 #Realizamos la operación A[i]-B[i]*8 y guardamos su resultado en R8
 sw $t0, C($s0) #Escribimos el resultado de C[i] en R8
 addi $s0, $s0, 4 #Operacion del bucle: Hacemos que i aumente de 4 en 4
 j for #Salto a la insrucción de la comprobación de la condición
 
done:

bucle: j bucle #bucle en el que se queda para dar por finalizado el ejercicio

.data  # Comienzo de seccion de datos
.align 2 # Direccion alineada a palabra (multiplo de 2^2=4)
N: 10 # Variable N que indica el tamaño de los arrays 
A: 2, 2, 4, 6, 5, 6, 7, 8, 9, 10  # Array a
B: -1, -5, 4, 10, 1, -2, 5, 10, -10, 0  # Array b
C: .space 40  # Array c


