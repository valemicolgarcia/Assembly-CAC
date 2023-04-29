;Modificar el programa anterior agregando una subrutina llamada ES_NUM que verifique si el caracter ingresado es 
;realmente un número. De no serlo, el programa debe mostrar el mensaje “CARACTER NO VALIDO”. La subrutina debe 
;recibir el código del caracter por REFERENCIA desde el programa principal y debe devolver vía registro el valor 0FFH en caso de 
;tratarse de un número o el valor 00H en caso contrario.

;Tener en cuenta que el código del “0” es 30H y el del “9” es 39H.

ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?
no_valido db "CARACTER NO VALIDO"
fin_no_valido db ?

ORG 1500H
NUM DB ?

ORG 3000H

ES_NUM: MOV BX, DX

MOV CL, [BX]                      ; muevo a CL lo que tiene BX porq no puedo comparar accediendo a memoria

MOV CH, 30H                       ; muevo el 0 a CH y le voy sumando   
MOV DL, 39H  			    ; muevo el 9 a DL para condicion de corte

loop: CMP CL, CH                  ; comparo el num con los digitos
JZ dig                            ; si son iguales devuelvo 0FFH por registro
MOV DH, 00H                       ; si no es digito devuelvo 00H por registro
INC CH 				    ; incremento digito
CMP DL, CH                        ; si hay carry es xq se paso de 39H 
JNC loop

JMP FIN1				    ; si llega aca es porq no es dig
dig: MOV DH, 0FFH			    ; si salto aca es porque es dig

FIN1:RET 


ORG 2000H

MOV BX, OFFSET MSJ                ; mueve la direc del mensaje para imprimirlo 
MOV AL, OFFSET FIN-OFFSET MSJ     ; guarda la cant de caracteres que debe imprimir 
INT 7                 		    ; imprime "INGRESE UN NUMERO"
MOV BX, OFFSET NUM		    ; guarda la direc de num
INT 6					    ; se ingresa desde teclado un numero en esa direc 
MOV AL, 1				    ;	mueve 1 a AL porque va a imprimir un solo caracter 

PUSH AX				    ; pusheo AX y BX por si tengo que imprimir dsp
PUSH BX				    ; 
MOV DX, OFFSET NUM                ; en DX pongo la direc de la variable para pasar por referencia
CALL ES_NUM

CMP DL, 0FFH 			    ; comparo para ver si es dig
JZ SALTA				    ; si son iguales salta, es un digito

MOV BX, OFFSET no_valido	    ; si no son iguales es letra
MOV AL, OFFSET fin_no_valido - OFFSET no_valido
INT 7					    ; imprimo "CARACTER NO VALIDO"
JMP SIGUE 				    ; sigue porq no tiene que imprimir 
   
SALTA: POP BX 				    ; traigo de nuevo la cant de car que voy a imprimir 
POP AX				    ; traigo de nuevo la direc que voy a imprimir 
INT 7			    ; imprime 
SIGUE: MOV CL, NUM		    ; guarda el num en CL
INT 0					    ; termina el programa
END