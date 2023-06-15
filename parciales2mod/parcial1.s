.data
CONTROL: .word 0x10000
DATA: .word 0x10008
coorX: .byte 5
coorY: .byte 5
color: .byte 0,255,0,0   ;RED:0, GREEN:255, BLUE:0


.code
LWU $s0, CONTROL ($0) ; $SO = CONTROL
LWU $s1, DATA ($0)    ;S1 = CONTROL

;SOLICITO VALOR NUMERICO BASE
daddi $t0, $0, 8
sd $t0, 0($s0)    ;control = 8
ld $t8, 0($s1)    ;tomo nro en $t8

;SOLICITO VALOR NUMERICO ALTURA
sd $t0, 0($s0)    ;control = 8
ld $t9, 0($s1)    ;tomo nro en $t9

;PANTALLA GRAFICA
daddi $t0, $0, 7
sd $t0, 0 ($s0)  ; control = 7 --> limpiar la pantalla grafica

;registro $t3: aumenta base
;registro $t4: aumenta altura
dadd $t3, $0, $0
dadd $t4, $0, $0

altura: daddi $t3, $0, 0  ;vuelvo a inicializar la base
dadd $t5, $0, $t8

    base: lbu $t0, coorX ($0)
        dadd $t0, $t0, $t3    ;x+1
        sb $t0, 5($s1)        ;DATA + 5 --> coordenada X

        lbu $t1, coorY ($0)
        dadd $t1, $t1, $t4    ;y+1
        sb $t1, 4($s1)        ;DATA + 4 --> coordenada Y

        lwu $t2, color ($0)  ;DATA + 0 --> color R G B A
        sw $t2, 0 ($s1)

        daddi $t0, $0, 5  ;CONTROL = 5 --> pinta
        sd $t0, 0($s0)

        daddi $t3, $t3, 1  ;incremento base
        daddi $t5, $t5, -1 ;BASE - 1
        bnez $t5, base 

        daddi $t4, $t4, 1 ;incremento altura
        daddi $t9, $t9, -1 ; ALTURA - 1
        bnez $t9, altura


halt

