;MULTIPLICA POR DOS LOS ELEMENTOS DE UN ARREGLO LLAMADO DATOS Y GENERA RES

.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8        ;TABLA DE DATOS
res: .word 0


.code
dadd r1, r0, r0           ;inicializa r1 en 0
ld r2, cant(r0)           ;pone en r2 la dimension logica de la tabla
loop: ld r3, datos(r1)    ;pone en r3 el primer dato de la tabla
daddi r2, r2, -1          ;disminuye la dimension logica
dsll r3, r3, 1            ;rota a la izquierda los bits q es como multiplicar por dos
sd r3, res(r1)            ;lo guarda en memoria
daddi r1, r1, 8           ;avanza en la proxima posicion de la tabla
bnez r2, loop             ;si r2 no es 0 salto a loop
nop                       ;para perder tiempo y evitar atascos
halt



;con el forwarding hay 7 branch taken stalls, 1.212 ciclos por instruccion, 
;52 instr, y 63 ciclos.

;DELAY SLOT --> hay 0 branch taken stalls, 1.068 ciclos por instruccion, 
;59 instrucciones y 63 ciclos

;sin la instruccion NOP no salta al loop, no entiendo bien por que

;Modificar el programa para aprovechar el ‘Delay Slot’ ejecutando una instrucción útil. 
;Simular y comparar número de ciclos, instrucciones y CPI 
;obtenidos con los de la versión anterior. ???