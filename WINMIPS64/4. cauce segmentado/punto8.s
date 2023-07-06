;Escribir un programa que multiplique dos números enteros 
;utilizando sumas repetidas (similar al Ejercicio 7 de la Práctica 1).
;El programa debe estar optimizado para su ejecución 
;con la opción Delay Slot habilitada

.data
NUM1: .word 2
NUM2: .word 3
RESULT: .word 0


;REGISTROS
;R1: num1
;R2: num2
;R3: result


.code
;MULTIPLICAR --> sumar sucesivas veces

ld r1, NUM1 (r0)
ld r2, NUM2 (r0)
dadd r3, r0, r0

beqz r1, fin
beqz r2, fin

LOOP: dadd r3, r3, r1    ;sumo num 1 a result
daddi r2, r2, -1         ;decremento NUM 2 (menos veces las que se suma)
bnez r2, LOOP            ;cuando llego a 0 no salto mas

sd r3, RESULT (r0)       ;mando el resultado a memoria

fin: nop
halt