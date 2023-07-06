.data
a: .word 4
b: .word 1
c: .word 5
.code
    ld r2, a(r0)
    ;ld r1, b(r0)
    ;ld r3, c (r0)
halt