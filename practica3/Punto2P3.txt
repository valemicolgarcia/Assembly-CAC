PIC EQU 20H
TIMER EQU 10H
PIO EQU 30H
N_CLK EQU 10
ORG 40
IP_CLK DW RUT_CLK
ORG 1000H
INICIO DB 0 ; 0000 0000

ORG 3000H

RUT_CLK: INC INICIO ; 
CMP INICIO, 0FFH    ;  
JNZ LUCES           ; 
MOV INICIO, 0

LUCES: MOV AL, INICIO
OUT PIO + 1, AL
MOV AL, 0
OUT TIMER, AL       ; CONT lo vuelve a poner en 0 

MOV AL, 20H         ; termina la subrutina 
OUT PIC, AL   
IRET 

ORG 2000H

CLI
; configuracion del PIC
MOV AL, 0FDH          ;
OUT PIC + 1, AL
MOV AL, N_CLK
OUT PIC + 5, AL

; configuracion TIMER
MOV AL, 1             ;
OUT TIMER + 1, AL     ; CONT= 1, cada un seg hay una interrup 

; configuracion del PIO
MOV AL, 0
OUT PIO + 3, AL       ; CB = 0000 0000 
OUT PIO + 1, AL       ; PB = 0000 0000
OUT TIMER, AL         ; CONT = 0 

STI 

LAZO: JMP LAZO

INT 0
END