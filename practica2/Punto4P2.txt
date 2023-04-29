ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM DB ?

ORG 2000H

MOV BX, OFFSET MSJ                ; mueve la direc del mensaje para imprimirlo 
MOV AL, OFFSET FIN-OFFSET MSJ     ; guarda la cant de caracteres que debe imprimir 
INT 7                 		    ; imprime "INGRESE UN NUMERO"
MOV BX, OFFSET NUM		    ; guarda la direc de num
INT 6					    ; se ingresa desde teclado un numero en esa direc --------------> me tira comando no reconocido (probe con num y letra)
MOV AL, 1				    ;	mueve 1 a AL porque va a imprimir un solo caracter 
INT 7					    ; imprime
MOV CL, NUM				    ; guarda el num en CL
INT 0					    ; termina el programa
END


; a) Con referencia a la interrupción INT 7, ¿qué se almacena en los registros BX y AL? 
;    En BX se guarda lo que se va a imprimir y en AL la cantidad de caracteres que se van a imprimir

; b) Con referencia a la interrupción INT 6, ¿qué se almacena en BX?
;    Se almacena la dirección del num que se va a ingresar   ???????????

; c) En el programa anterior, ¿qué hace la segunda interrupción INT 7? ¿qué queda almacenado en el registro CL?
;    Creo que imprime el numero ingresado, en CL queda almacenado el numero que se ingresó desde teclado