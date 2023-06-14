;Escribir un programa que recorra una TABLA de diez números enteros 
;y determine cuántos elementos son mayores que X. 
;El resultado debe almacenarse en una dirección etiquetada CANT. 
;El programa debe generar además otro arreglo llamado RES
;cuyos elementos sean ceros y unos. 
;Un ‘1’ indicará que el entero correspondiente 
;en el arreglo TABLA es mayor que X,
;mientras que un ‘0’ indicará que es menor o igual.

.data
tabla: .word 1,2,3,4,5,6,7,8,9,10  ;arreglo a analizar
long: .word 10          ;dimension logica de la tabla
cant: .word 0           ;resultado
X: .word 3
res: .word 0            ;arreglo con 0 y 1


;R1: DIM LOGICA
;R2: DIREC DE TABLA --> para avanzar
;R3: ELEM DE LA TABLA
;R4: ELEMENTO X DE MEMORIA
;R5: 1 O 0 si es MAYOR O MENOR
;R6: 1 para comparar y ver si sumo al contador o no
;R7: contador que despues mando a CANT


.code
ld r1, long (r0)        ;dimL
dadd r2, r0, r0         ;inicializo r2 en 0 
daddi r6, r0, 1         ;inicializo r6 en 1
dadd r7, r7, r0         ;inicializo r7 en 0
ld r4, X(r0)            ;llevo a registro X almacenado en memoria

;RECORRIDO DE LA TABLA
loop: ld r3, tabla(r2)  ;elem de tab
slt r5, r4, r3          ;comparo X con ELEM (si elem es mayor se pone 1 en r5)
bne  r5, r6, saltear    ;si no es 1 (es 0) saltea la suma del contador
daddi r7, r7, 1         ;incremento en 1 el contador de numeros mayores
saltear: sd r5, res (r2)  ;mando al arreglo en memoria el 1 o el 0
daddi r1, r1, -1          ;disminuyo la dimension logica (R1)
daddi r2, r2, 8           ;avanzo en la proxima direc de la tabla (R2)
bnez r1, loop             ;si la dimL es 0 se termina y no se salta a loop

sd r7, cant (r0)           ;mando contador a memoria

nop
halt
