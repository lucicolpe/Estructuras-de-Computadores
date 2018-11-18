######################################################################
## Fichero: Desemsamblar.asm
## Descripción: Programa que realiza operaciones con datos de memoria
## Fecha última modificación: 2016-03-07
## Autores: Claudia Cea, Lucía Colmenareho (Pareja 3)
## Asignatura: EC. 1º grado
## Grupo de Prácticas: 2101
## Grupo de Teoría: 210
## Práctica: 4
## Ejercicio: 3
######################################################################

.text 0x0000 #comienzo de seccion de codigo
main:
lui $at, 0x00fa #R1(31:16) <= 0x00fa , R1(15:0) <= 0x0000 ; R1 = 0x00fa0000
ori $at, $at, 0xbada #R1(15:0) <= 0xbada ; R1 = 0x00fabada
lui $v0, 0x423f #R2(31:16) <= 0x423f , R2(15:0) <= 0x0000 ; R2 = 0x423f0000
ori $v0, $v0, 0xefdc #R2(15:0) <= 0xefdc ; R2 = 0x423fefdc
sub $v0, $at, $v0 #R2 <= R1 - R2 ; R2 = 0xbebacafe
lw $a0, a($0) #R4 = 0xc0cac01a
lw $a1, b($0) #R5 = 0x000000b0
sll $a1, $a1, 8 #R5 = 0x0000b000
addi $a1, $a1, 0x00b0 #R5 <= R5 + 0x00b0 ; R5 = 0x0000b0b0
lw $a2, c($0) #R6 = 0x0000b0ba
bne $a1, $a2, target #Si los valores de R5 y R6 son distintos salta hasta la instrucción target
xor $a0, $a1, $a1 #No se ejecuta ya que ha saltado a target. Si lo hiciese sería: R4 <= R5 XOR R5 ; R4 =0x00000000
target: xori $a3, $a1, 0x7a7a #R7 <= R5 XOR 0x7a7a ; R7 = 0x0000caca
bucle: j bucle #bucle en el que se queda para dar por finalizado el ejercicio

.data 0x2000 #Comienzo de seccion de datos
.align 2 #Direccion alineanda a palabra

a:0xc0cac01a
b:0x000000b0
c:0x0000b0ba
