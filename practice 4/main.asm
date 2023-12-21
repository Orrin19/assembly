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

        tickets ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?
                ticket ?,?,?,?

        output_head db 'Number         Destination        Departure        Date         Price',10,0
        output_ticket db 'Ticket %2d  %15s  %15s  %10s  %5d rubles',10,0
        n dd 10
        ticket_size dd 49
        i dd 0

        read_filename db 'input.txt',0
        write_filename db 'output.txt',0
        w db 'w',0
        r db 'r',0
        read_descriptor dd 0
        write_descriptor dd 0


section '.code' code readable writeable executable

start:
        invoke fopen, read_filename, r
        mov [read_descriptor], eax
        mov eax, [n]
        imul [ticket_size]
        mov ecx, 1
        invoke fread, tickets, ecx, eax, [read_descriptor]
        invoke fclose, [read_descriptor]

        invoke fopen, write_filename, w
        mov [write_descriptor], eax

        mov [i], 0
        for_add_price:
                mov eax, [i]
                imul [ticket_size]

                mov edx, eax
                add edx, tickets.price

                mov eax, [edx]
                add eax, 99
                mov [edx], eax

                inc [i]
                mov edx, [i]
                cmp edx, [n]
                jne for_add_price

        invoke printf, output_head
        mov [i], 0
        for_print:
                mov eax, [i]
                imul [ticket_size]

                mov ebx, eax
                add ebx, tickets.destination

                mov ecx, eax
                add ecx, tickets.departure

                mov edx, eax
                add edx, tickets.date

                add eax, tickets.price

                inc [i]
                invoke printf, output_ticket, [i], ebx, ecx, edx, [eax]

                mov edx, [i]
                cmp edx, [n]
                jne for_print

        mov eax, [n]
        imul [ticket_size]
        mov ecx, 1

        invoke fwrite, tickets, ecx, eax, [write_descriptor]
        invoke fclose, [write_descriptor]

        invoke getch
        invoke ExitProcess, 0


section '.idata' data import readable
        library \
                kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
                ExitProcess, 'ExitProcess'

        import msvcrt,\
                printf, 'printf',\
                getch, '_getch',\
                fopen, 'fopen',\
                fwrite, 'fwrite',\
                fclose, 'fclose',\
                fread, 'fread'