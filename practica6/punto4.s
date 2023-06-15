;Escriba un programa que solicite el ingreso por teclado de una clave 
;(sucesión de cuatro caracteres) 
;utilizando la subrutina char de ingreso de un carácter. 

;Luego, debe comparar la secuencia ingresada con una cadena almacenada
;en la variable clave. 

;Si las dos cadenas son iguales entre si, la subrutina llamada 
;respuesta mostrará el texto “Bienvenido” en la salida estándar del simulador
; (ventana Terminal). En cambio, si las cadenas no son iguales, 
;la subrutina deberá mostrar “ERROR” y solicitar nuevamente el ingreso de la clave.

.data
CONTROL: .word 0x10000
DATA: .word 0x10008
texto: .asciiz "Ingrese una cadena de cuatro caracteres " 
clave: .asciiz "hola"
bien: .asciiz "BIENVENIDO!"
error: .asciiz "ERROR"
cadena: .asciiz 0   ;cadena a ingresar desde teclado

RES: .byte 0

.code
;DIRECCIONES DE CONTROL Y DE DATA
LWU $s0, CONTROL ($zero) ;$so = CONTROL
LWU $s1, DATA ($zero) ;$s1 = DATA

daddi $t0, $0, texto     
sd $t0, 0($s1)                   ; mando el dato a DATA
daddi $t0, $0, 4                 
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> se ejecuta

 REPETIR: jal INGRESO

daddi $a0, $0, cadena
daddi $a1, $0, clave
jal COMPARAR
nop
nop
nop
nop
nop
nop

beqz $v0, REPETIR

nop
nop
nop
nop
nop


halt


;SUBRUTINAS------------------------------------------------------

INGRESO: daddi $t0, $0, 4       ;contador de lecturas
daddi $t1, $0, 0          ; incremento en memoria

;T2: num a control
;T3 : caracter ingresado

LOOP: daddi $t2, $0, 9
sd $t2, 0($s0)                   ;CONTROL = 9 (lectura de caracter) --> se ejecuta

lbu $t3, 0($s1)                   ;tomo caracter y lo guardo en t3
sb $t1, cadena ($t1)             ;guardo en cadena

daddi $t0, $t0, -1               ;decremento veces
daddi $t1, $t1, 1                ;incremento desplazamiento en direccion de memoria

bnez $t0, LOOP                  



JR $ra


;$a0 --> cadena | $a1 --> clave
COMPARAR: daddi $t0, $t0, 4

loop: lbu $t2, 0($a0) ;caracter de la cadena
lbu $t3, 0($a1)       ; caracter de la clave

bne $t2, $t3, DIFERENTE  ;si son diferentes dejo de comparar y salgo del loop

daddi $t0, $t0, -1 ;decremento dimlogica
daddi $a0, $a0, 1 ;incremento el registro de desplazamiento en memoria
daddi $a1, $a1, 1 ;inc desplazamiento memoria
bnez $t0, loop

nop
nop
nop
nop
nop
bie: daddi $t0, $0, bien    
sd $t0, 0($s1)                   ; mando el dato a DATA
daddi $t0, $0, 4                 
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> se ejecuta
daddi $v0, $v0, 1                ;retorna 1

j fin
nop
nop
nop
DIFERENTE: daddi $t0, $0, error
sd $t0, 0($s1)
daddi $t0, $0, 4
sd $t0, 0($s0)                   ; CONTROL = 4 (salida del mensaje) --> se ejecuta

daddi $v0, $v0, 0               ;retorna 0

fin: JR $ra

