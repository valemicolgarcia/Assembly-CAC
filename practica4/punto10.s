;Escribir un programa que cuente la cantidad de veces que 
;un determinado caracter aparece en una cadena de texto. 
;Observar cómo se almacenan en memoria los 
;códigos ASCII de los caracteres (código de la letra “a” es 61H).
;Utilizar la instrucción lbu (load byte unsigned) para
;cargar códigos en registros.

.data
cadena: .asciiz "adbd";cdedfdgdhdid" ; cadena a analizar
car: .asciiz "d" ; caracter buscado
cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.
dim: .word 4 ;16 letras

.code  ;-------------------------------------

;INICIALIZACION DE REGISTROS

lbu r2, car (r0)
lbu r3, cant (r0)
dadd r4, r4, r0   ;contador
dadd r5, r5, r0   ;posicion
ld r6, dim(r0)    ;dim logica 

;PROGRAMA PRINCIPAL

loop: lbu r1, cadena(r5)      ;elem de tabla
bne r2, r1, saltar            ;cmp r2, r1 --> jnz salta
daddi r4, r4, 1               ;inc contador 
saltar:  daddi r5, r5, 1      ;avanza en la tabla
daddi r6, r6, -1              ;disminuyo la dim logica
bnez r6, loop                 ;si r6 no es 0 salto a loop
sd r4, cant(r0)               ;mando a memoria
halt                          



;me cuenta uno mas del que me tiene que contar





