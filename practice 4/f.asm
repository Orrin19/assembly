; Рябцев Даниил Сергеевич, КИ22-16/1б, ПР 1.4, В20


format PE Console
entry start
include 'win32a.inc'


section '.data' data readable writeable

        struct  ticket
                destination db 15 dup(0)
                departure db 15 dup(0)
                date db 15 dup(0)
                price dd 0
        ends

        tickets ticket 'Moscow','Krasnoyarsk','12.11.2023',10000
                ticket 'Moscow','Beijing','18.11.2023',14901
                ticket 'Abakan','Kemerovo','22.12.2023',7400
                ticket 'Samara','Novosibirsk','02.01.2024',11200
                ticket 'Astana','Bishkek','23.02.2024',5400
                ticket 'Kazan','Norilsk','25.02.2024',15200
                ticket 'Saratov','Novosibirsk','13.03.2024',8400
                ticket 'Voronezh','Perm','27.05.2024',6500
                ticket 'Minsk','Izhevsk','04.06.2024',9800
                ticket 'Moscow','St. Petersburg','31.08.2024',7901

        n dd 10
        ticket_size dd 49

        filename db 'input.txt',0
        w db 'w',0
        descriptor dd 0


section '.code' code readable writeable executable

start:
        invoke fopen, filename, w
        mov [descriptor], eax
        mov eax, [n]
        imul [ticket_size]
        mov ecx, 1
        invoke fwrite, tickets, ecx, eax, [descriptor]
        invoke fclose, [descriptor]


section '.idata' data import readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import msvcrt,\
                fopen, 'fopen',\
                fwrite, 'fwrite',\
                fclose, 'fclose'