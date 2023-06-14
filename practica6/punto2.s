;Escriba un programa que utilice sucesivamente dos subrutinas: 

;La primera, denominada ingreso, debe solicitar el ingreso por teclado de un número entero (de un dígito), 
;verificando que el valor ingresado realmente sea un dígito.
 
;La segunda, denominada muestra, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del
;número ingresado expresado en letras (es decir, si se ingresa un ‘4’, deberá mostrar ‘CUATRO’). 

;Establezca el pasaje de parámetros entre subrutinas respetando las convenciones para el uso de los registros 
;y minimice las detenciones del cauce (ejercicio similar al ejercicio 6 de Práctica 2).


.data
CONTROL: .word 0x10000
DATA: .word 0x10008
texto: .asciiz "Ingrese un numero entero: " 

cero:  .asciiz "CERO"
uno:   .asciiz "UNO"
dos:   .asciiz "DOS"
tres:  .asciiz "TRES"


.code

;DIRECCIONES DE CONTROL Y DE DATA
LD $s0, CONTROL ($zero) ;$so = CONTROL
LD $s1, DATA ($zero) ;$s1 = DATA

jal INGRESO
;beqz $v1, terminar
nop
nop
nop
nop
nop
dadd $a0, $v0, $0                ;mando numero a $a0 para pasarlo como parametro

jal MUESTRA
beqz $v0 , terminar



terminar: halt

;SUBRUTINAS

INGRESO: daddi $t0, $0, texto     
sd $t0, 0($s1)                   ; mando el dato a DATA

daddi $t0, $0, 4                 
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> se ejecuta

daddi $t0, $0, 9
sd $t0, 0($s0)                   ;CONTROL = 9 (lectura de caracter) --> se ejecuta

ld $t1, 0($s1)                   ;tomo numero en $t1 para analizar si es digito o no

slti $t2, $t1, 48               ;veo si es mayor al 0
bnez $t2, noesnum                ;si no es cero --> no es mayor

slti $t2, $t1, 57               ;veo si es menor al 9
beqz $t2, noesnum                ;si es cero --> no es menor

daddi $v0, $t1, 0                ;mando numero a $v0 para retornarlo
daddi $v1, $0, 1                 ;devuelvo 1 para indicar que es numero
j fin

noesnum: daddi $v1, $0, 0        ;devuelvo 0 para indicar que no es numero

fin: JR $ra

;----------------------------------------
MUESTRA: bne $a0, $0, analizoUno   ;es cero?
daddi $t0, $0, cero
j imprimo

analizoUno: daddi $t1, $0, 49
bne $a0, $t1, analizoDos
daddi $t0, $0, uno
j imprimo

analizoDos: daddi $t1, $0, 50
bne $a0, $t1, analizoTres
daddi $t0, $0, dos
j imprimo

analizoTres: daddi $t1, $0, 51
bne $a0, $t1, error
daddi $t0, $0, tres
j imprimo

error: daddi $v1, $0, 0           ;retorno 0
j finalizar

imprimo: sd $t0, 0($s1)           ; mando el dato a DATA
daddi $t0, $0, 4                 
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> IMPRIMO
daddi $v1, $0, 1                 ; retorno 1

finalizar: JR $ra




