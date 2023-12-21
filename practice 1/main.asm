; Рябцев Даниил, КИ22-16/1Б, Вариант 20
; 
; Z1 = -X * (1 - X * Y)
; Z2 = Y + X / Y - 1
; Z3 = 5 / X * Y + X ^ 3
; Z4 = -X + Y^3 - 1
; Z5 = X^3 / (X - Y)
;
; Tests for this program:
; X = 3,  Y = 2   => Z1 = 15    Z2 = 2   Z3 = 29   Z4 = 4      Z5 = 27
; X = 5,  Y = 10  => Z1 = 245   Z2 = 9   Z3 = 135  Z4 = 994    Z5 = -25
; X = 15, Y = -1  => Z1 = -240  Z2 = -17 Z3 = 3375 Z4 = -17    Z5 = 210
; X = 15, Y = -30 => Z1 = -6765 Z2 = -31 Z3 = 3375 Z4 = -27016 Z5 = 75
;
format PE Console
entry start
include 'win32a.inc'

section '.const' data readable
    x            dd -4
    y            dd -2
    inputFormat  db "Input:  X == %d and Y == %d", 10, 0
    resultFormat db "Result: Z%d == %d", 10, 0

section '.data' data readable writeable
    interResult dd 0
    result      dd 0

section '.code' code readable executable
start:
    invoke printf, inputFormat, [x], [y]

    ; Z1 = -X * (1 - X * Y)
    mov  eax, [x]
    imul eax, [y]
    mov  [interResult], eax
    mov  eax, 1
    sub  eax, [interResult]
    imul eax, [x]
    imul eax, -1
    mov  [result], eax
    invoke printf, resultFormat, 1, [result]

    ; Z2 = Y + X / Y - 1
    mov  eax, [x]
    cdq
    idiv [y]
    add  eax, [y]
    sub  eax, 1
    mov  [result], eax
    invoke printf, resultFormat, 2, [result]

    ; Z3 = 5 / X * Y + X ^ 3
    mov  eax, 5
    idiv [x]
    imul eax, [y]
    mov  [interResult], eax
    mov  eax, [x]
    imul eax, [x]
    imul eax, [x]
    add  eax, [interResult]
    mov  [result], eax
    invoke printf, resultFormat, 3, [result]

    ; Z4 = -X + Y^3 - 1
    mov  eax, [x]
    imul eax, -1
    mov  [interResult], eax
    mov  eax, [y]
    imul eax, [y]
    imul eax, [y]
    add  eax, [interResult]
    sub  eax, 1
    mov  [result], eax
    invoke printf, resultFormat, 4, [result]

    ; Z5 = X^3 / (X - Y)
    mov  eax, [x]
    sub  eax, [y]
    mov  [interResult], eax
    mov  eax, [x]
    imul eax, [x]
    imul eax, [x]
    cdq
    idiv [interResult]
    mov  [result], eax
    invoke printf, resultFormat, 5, [result]

    invoke getch
    invoke ExitProcess, 0

section '.idata' data import readable
    library kernel, 'kernel32.dll',\
            msvcrt, 'msvcrt.dll'
    import kernel, ExitProcess, 'ExitProcess'
    import msvcrt,\
            printf, 'printf',\
            getch, '_getch'