; Memoria de Datos
ORG 1000H
FIN DB 01H 

ORG 2000H


MOV AL, 1 ; indica que voy a imprimir 255 veces un caracter 

MOV BX, OFFSET FIN ; guardamos la longitud de nuestro cartel

MOV CL, 01H
LOOP: INT 7 ; imprime siempre lo que tiene BX
INC CL 
MOV [BX], CL
CMP CL, 255 
JNZ LOOP ; si AL es 25 sale

INT 0 ; para avisar que termino

END


