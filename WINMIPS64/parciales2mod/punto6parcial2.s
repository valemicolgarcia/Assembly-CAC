
;Escribir una subrutina MINMAX que recibe 
;argumentos: la direccion de comienzo de una tabla y la cantidad de elementos 
;devuelve: maximo y minimo de dicha tabla
;programa que obtenga el maximo y minimo de dos tablas, por ultimo
;imprimir en la pantalla grafica un punto de color rojo (255,0,0) en la
; coordenada (minimo tabla1, maximo tabla 2). 

;DECLARACION DE VARIABLES
.data
tabla1: .word 21,12,5,16,8,39,10,41,4,33
tabla2: .word 32,24,15,32,17,28,11,20,44,21
diml: .word 10
CONTROL: .word 0x10000
DATA: .word 0x10008
color: .byte 255,0,0,0 ;ROJO

;PROGRAMA PRINCIPAL
.code

;MIN Y MAX TABLA 1
ld $a0, diml ($0) ;cantidad de elementos de la tabla
daddi $a1, $0, tabla1 ;direccion de la tabla 1
jal MINMAX
dadd $s0, $0, $v0 ; = max
dadd $s1, $0, $v1 ;= min tabla 1

;MIN Y MAX TABLA 2
ld $a0, diml ($0) ;cantidad de elementos de la tabla
daddi $a1, $0, tabla2 ;direccion de la tabla 2
jal MINMAX
dadd $s3, $0, $v0 ;= max tabla 2
dadd $s4, $0, $v1 ;= min

;PANTALLA GRAFICA
ld $s5, CONTROL ($0)
ld $s6, DATA ($0)

daddi $t0, $0, 7
sd $t0, 0($s5) ;CONTROL = 7 --> limpiar la pantalla grafica

dadd $t0, $s1, $0 ;minimo de tabla 1
sb $t0, 5 ($s6)  ;DATA + 5 = COORDENADA X
dadd $t1, $s3, $0 ;maximo de tabla 2
sb $t0, 4 ($s6) ;DATA + 6 = COORDENADA Y
lwu $t0, color ($0)
sw $t0, 0($s6) ;DATA = COLOR

daddi $t0, $0, 5 ;CONTROL = 5
sd $t0, 0 ($s5) 


halt

;SUBRUTINAS----------
;$t0: direc -- $t1: diml -- $t2: elem tabla -- $t3: max -- $t4: min

MINMAX: dadd $t1, $0, $a0  ;copio diml en registro temporal
dadd $t0, $a1, $0 ;copio direccion de la tabla

daddi $t3, $0, -1 ;inicializo el max
daddi $t4, $0, 999 ;inicializo el min

;registros para la comparacion
dadd $t5, $0, $0 ;
daddi $t6, $0, 1

;recorrido de la tabla
loop: ld $t2, 0 ($t0) ; elemento de la tabla
slt $t5, $t3, $t2 ; t3 < t2 ? 1 : xx
bne $t5, $t6, analizoMin ; t5 = 1? si no es igual no cambies t3
dadd $t3, $0, $t2 ;max = t2
analizoMin: slt $t5, $t2, $t4 ; t2 < t3? 1 : xx
bne $t5, $t6, sigo ;t5 = 1?
dadd $t4, $0, $t2 ;min = t2
sigo: daddi $t0, $t0, 8  ; t0 + 8
daddi $t1, $t1, -1 ;dec t1
bnez $t1, loop ;mientras no llego a 0 salto a loop

;elementos que se devuelven
dadd $v0, $t3, $0   ;v0 = max
dadd $v1, $t4, $0   ;v1 = min


jr $ra

