
;Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos 
;parciales del registro r1 
;¿Qué significado tienen los elementos de la tabla que se genera?

.data
A: .word 1
B: .word 6
tabla: .word 0


.code
ld r1, A(r0) ;se carga un 1
ld r2, B(r0) ;se carga un 6

sd r1, tabla(r0) ;pongo el primer valor de r1 en la tabla!!


loop: dsll r1, r1, 1   ;rotariz

daddi r5, r5, 8 ;sumo uno a la posicion!!
sd r1, tabla (r5) ;muevo valor de r5 a la tabla en la siguiente posicion!!

daddi r2, r2, -1       ;va disminuyendo la cantidad de veces que se quiere hacer
bnez r2, loop    
halt

;hay que inicializar r5???? como?
