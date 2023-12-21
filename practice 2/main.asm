;-------------------------------------------
;-- Рябцев Даниил, КИ22-16/1Б, ПР1.2, В20 --
;-------------------------------------------


format PE Console
entry start
include 'win32a.inc'


section '.data' data readable writeable

        prompt db 'Enter X and A:',10,0
        input db '%lf',0
        output_i db 'i  = %d',10,0
        output_y1 db 'y1 = %5.3f',10,0
        output_y2 db 'y2 = %5.3f',10,0
        output_y db 'y  = %5.3f',10,0
        newline db '',10,0

        a dq 0
        x dq 0
        y1 dq 0
        y2 dq 0
        y dq 0
        i dd 0
        n dd 10
        temp dd 0


section '.code' code readable writeable executable

start:
        invoke printf, prompt
        invoke scanf, input, x
        invoke scanf, input, a
        invoke printf, newline

        for:
                finit
                ;--- if (x >= 0) { else_1 } ---
                fldz
                fld [x]
                fcomip st1
                jae else_1

                if_1:
                        finit
                        ;--- y1 = |x| -----
                        fld [x]
                        fabs
                        fstp [y1]
                        ;---------------------
                        jmp if_1_out

                else_1:
                        finit
                        ;--- y1 = x - a ----
                        fld [x]
                        fsub [a]
                        fstp [y1]

        if_1_out:
                finit
                ;--- if (x mod 3 != 1) { else_2 } ---
                mov [temp], 3
                fild [temp]
                fld [x]
                fprem1
                fld1
                fcomip st1
                jne else_2

                if_2:
                        finit
                        ;--- y2 = a + x ---
                        fld [a]
                        fadd [x]
                        fstp [y2]
                        ;--------------------
                        jmp if_2_out

               else_2:
                        finit
                        ;--- y2 = 7.0 ---
                        mov [temp], 7
                        fild [temp]
                        fstp [y2]
                        ;----------------

        if_2_out:
                finit
                ;--- y = y1 - y2 -----
                fld [y1]
                fsub [y2]
                fstp [y]
                ;---------------------

                invoke printf, output_i, [i]
                invoke printf, output_y1, dword [y1], dword [y1+4]
                invoke printf, output_y2, dword [y2], dword [y2+4]
                invoke printf, output_y, dword [y], dword [y+4]
                invoke printf, newline


                ;----- x++ -----------
                finit
                fld1
                fadd [x]
                fstp [x]
                ;---------------------


                ;---- i++; i < n -----
                mov ecx, [i]
                inc ecx
                cmp ecx, [n]
                mov [i], ecx
                jne for
                ;---------------------
  
        invoke getch
        invoke ExitProcess, 0


section '.idata' data import readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'
  
        import kernel,\
                ExitProcess, 'ExitProcess'
          
        import msvcrt,\
                printf, 'printf',\
                getch, '_getch', scanf, 'scanf'
