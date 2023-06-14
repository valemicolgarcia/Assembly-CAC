;while a > 0 do begin
;x := x + y;
;a := a - 1;
;end

.data
a: .word 5
x: .word 2
y: .word 3

.code

;INICIALIZACION
ld r1, a(r0)
ld r2, x(r0)
ld r3, y(r0)

;MAIN
LOOP: dadd r2, r2, r3    ;x=x+y
daddi r1, r1, -1         ;a=a-1
bnez r1, LOOP            ;mientras a no sea 0 salto a loop

sd r2, x(r0)             ;mando a memoria los resultados
sd r1, a(r0)

nop
halt
