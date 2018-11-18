######################################################################
## Fichero: Vectores.asm
## Descripci�n: Programa que trabaja con vectores
## Fecha �ltima modificaci�n: 2016-03-07
## Autores: Claudia Cea, Luc�a Colmenareho (Pareja 3)
## Asignatura: EC. 1� grado
## Grupo de Pr�cticas: 2101
## Grupo de Teor�a: 210
## Pr�ctica: 4
## Ejercicio: 1
######################################################################

.text # Comienzo de seccion de codigo
main: 
 #$s0 = i, $s1 = N, $s4 = j, $s5 = k
 lw $t0, C #Cargamos la variable C en R8 
 addi $s0, $0, 0  #Inicializaci�n de i
 addi $s4, $0, 0 #Inicializaci�n de j
 addi $s5, $0, 4 #Inicializaci�n de k
 lw $s1, N #Cargamos la variable N en R17
 
 #Multiplicamos la variable N por 4
 por4: slt $t4, $s4, $s5 #Comprobaci�n de la condici�n j<k
 beq $t4, $0 kes8 #Si la condici�n se cumple sale del bucle
 #Cuerpo del bucle
 add $t3, $t3, $s1 #Multiplicamos N*4 y guardamos el resultado en R11
 addi $s4, $s4, 1 #Operacion del bucle: Hacemos que j aumente de 1 en 1
 j por4 #Salto a la instrucci�n de la comprobaci�n de la condici�n
 
 kes8: addi $s5, $s5, 4 #Ponemos la variable k a 8
 
 for: slt $t1, $s0, $t3 #Comprobaci�n de la condici�n i<N
 beq $t1, $0, done #Si la condici�n se cumple sale del bucle
 #Cuerpo del bucle 
 lw $s2, A($s0) #Cargamos la variable A[i] en R18 
 lw $s3, B($s0) #Cargamos la variable B[i] en R19 
 sub $s4, $s4, $s4 #Volvemos a poner la variable j a 0
 #Multiplicamos la variable B[i] por 8 
 por8: slt $t2, $s4, $s5 #Comprobaci�n de la condici�n j<k
 beq $t2, $0, next #Si la condici�n se cumple sale del bucle
 #Cuerpo del bucle 
 add $s6, $s6, $s3 #Vamos guardando el contenido de la operacion hasta llegar a B[i]*8
 addi $s4, $s4, 1 #Operacion del bucle: Hacemos que j aumente de 1 en 1
 j por8 #Salto a la intsrucci�n de la comprobaci�n de la condici�n
 
 next: sub $t0, $s2, $s6 #Realizamos la operaci�n A[i]-B[i]*8 y guardamos su resultado en R8
 sw $t0, C($s0) #Escribimos el resultado de C[i] en R8
 sub $s6, $s6, $s6 #Volvemos a poner el contenido del registro donde guardamos B[i]*8 a 0
 addi $s0, $s0, 4 #Operacion del bucle: Hacemos que i aumente de 4 en 4
 j for #Salto a la instrucci�n de la comprobaci�n de la condici�n
 
done:

fin: j fin #bucle en el que se queda para dar por finalizado el ejercicio

.data  # Comienzo de seccion de datos
.align 2 # Direccion alineada a palabra (multiplo de 2^2=4)
N: 6 # Variable N que indica el tama�o de los arrays 
A: 2, 4, 6, 8, 10, 12  # Array a
B: -1, -5, 4, 10, 1, -5  # Array b
C: .space 24  # Array c
