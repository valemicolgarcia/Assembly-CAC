ORG 1000H

INI DB 01H                  ;carcater desde el cual tiene que imprimir
FIN DB 255H                 ;caracter hasta el cual tiene que imprimir



DB 55H
DB 4EH
DB 4CH
DB 50H
FIN DB ?

ORG 2000H

MOV AH, FIN
MOV AL, INI

LOOP: INT 7
INC AL
CMP AH, AL
JNC LOOP

INT 0
END


