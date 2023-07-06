;Escriba un programa que calcule el resultado de elevar un valor en punto flotante 
;a la potencia indicada por un exponente que es un número entero positivo. 
;Para ello, en el programa principal se solicitará el ingreso de la base 
;(un número en punto flotante) y del exponente (un número entero sin signo) y
; se deberá utilizar la subrutina a_la_potencia para calcular el resultado pedido 
;(que será un valor en punto flotante). Tenga en cuenta que
;cualquier base elevada a la 0 da como resultado 1. 
;Muestre el resultado numérico de la operación en la salida 
;estándar del simulador (ventana Terminal).

.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.code

lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

daddi $t0, $0, 8
sd $t0, 0($s0) ;CONTROL recibe 8 y lee un numero
l.d f1, 0($s1) ;DATA recibe el numero y lo agarro en a0

sd $t0, 0($s0) ;CONTROL recibe 8 y lee otro numero
ld $a0, 0($s1) ;DATA recibe el numero y lo agarro en a1
;EN ESTE MOMENTO $A0 = FLOT Y $A1 = ENTERO

jal a_la_potencia

s.d f2, 0($s1) ; Guardo resultado en DATA
daddi $t0, $0, 3
sd $t0, 0($s0) ;CONTROL recibe 3 y escribe resultado

halt


a_la_potencia: dadd $t0, $0, $a0
daddi $t1, $0, 1
mtc1 $t1, f2
cvt.d.l f2, f2
beqz $t0, fin
loop: mul.d f2, f2, f1
daddi $t0, $t0, -1
bnez $t0, loop

fin: jr $ra