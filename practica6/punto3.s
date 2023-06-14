;Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: 
;La denominada ingreso del ejercicio anterior (ingreso por teclado de un dígito numérico) 
;y otra denominada resultado, que muestre en la salida estándar del simulador (ventana Terminal) 
;el resultado numérico de la suma de los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2).

.data
CONTROL: .word 0x10000
DATA: .word 0x10008
texto: .asciiz "Ingrese un numero entero: " 
RES: .byte 0

.code
;DIRECCIONES DE CONTROL Y DE DATA
LWU $s0, CONTROL ($zero) ;$so = CONTROL
LWU $s1, DATA ($zero) ;$s1 = DATA

jal INGRESO

beqz $v1, terminar
dadd $a0, $v0, $0                ;mando numero a $a0 para pasarlo como parametro
jal INGRESO
dadd $a1, $v0, $0                ;mando numero a $a1 para pasarlo como parametro
nop
nop
nop
nop
nop
jal SUMA
nop
nop
nop

terminar: halt


;SUBRUTINAS-------------------------------------------------------------

INGRESO: daddi $t0, $0, texto     
sd $t0, 0($s1)                   ; mando el dato a DATA

daddi $t0, $0, 4                 
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> se ejecuta

daddi $t0, $0, 9
sd $t0, 0($s0)                   ;CONTROL = 9 (lectura de caracter) --> se ejecuta

ld $t1, 0($s1)                   ;tomo numero en $t1 para analizar si es digito o no

slti $t2, $t1, 48                ;veo si es mayor al 0
bnez $t2, noesnum                ;si no es cero --> no es mayor

slti $t2, $t1, 57                ;veo si es menor al 9
beqz $t2, noesnum                ;si es cero --> no es menor

daddi $v0, $t1, 0                ;mando numero a $v0 para retornarlo
daddi $v1, $0, 1                 ;devuelvo 1 para indicar que es numero
j fin

noesnum: daddi $v1, $0, 0        ;devuelvo 0 para indicar que no es numero

fin: JR $ra



SUMA: daddi $a0, $a0, -48
daddi $a1, $a1, -48

dadd $t0, $a0, $a1               

sd $t0, 0($s1)                   ; mando el dato a DATA

daddi $t0, $0, 1                 
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> se ejecuta
nop
nop
nop
nop
nop

JR $ra




