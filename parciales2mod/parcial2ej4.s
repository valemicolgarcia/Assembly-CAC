
.data
    VALOR: .double 1.2
    texto: .asciiz "El resultado es : "
    CONTROL: .word 0x10000
    DATA: .word 0x10008

.code
    ;CONFIGURACION DE ENTRADA/SALIDA
    LWU $s0, CONTROL ($0)  ;CONTROL = S0
    LWU $s1, DATA ($0)     ;DATA = S1

    ;LECTURA EN PUNTO FLOTANTE : X (f1)
    daddi $t0, $0, 8
    sd $t0, 0($s0)         ;CONTROL = 8
    L.D f1, 0($s1)         ;tomo nro en F1

    ;COMPARACION CON VALOR (f2)
    l.d f2, VALOR ($0)
    c.le.d f1, f2         ;deja FLAG=1 si f1 es menor o igual que f2
    bc1t ESMENOR

    sub.d f3, f1, f2      ; x - valor --> f3 = f1 - f2
    mul.d f4, f3, f1      ; (x-valor) * x --> F3 * F1 = F4
    j imprimir

    ESMENOR: sub.d f3, f2,f1 ;valor - x --> f3 = f2 - f1
    div.d f4, f3, f1         ; (valor-x) / x --> f4 = f3/f1
    

    imprimir: daddi $t0, $0, texto     
    sd $t0, 0($s1)                   ; mando el dato a DATA
    daddi $t0, $0, 4                 
    sd $t0, 0($s0)                   ; CONTROL = 4 (caracteres)
    
    s.d f4, 0($s1)                    ;le mando el resultado a DATA
    daddi $t0, $0, 3                 ;CONTROL = 3 (punto flotante)
    sd $t0, 0 ($s0)
    

halt
