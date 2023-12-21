;-------------------------------------------
;-- Рябцев Даниил, КИ22-16/1Б, ПР1.3, В20 --
;-------------------------------------------


format PE Console
entry start
include 'win32a.inc'
define string_buffer 512


section '.data' data readable writable
        char_format db '%c', 0
        input_string db 'Enter your string: ',0
        output_string db 'Shortest word in your string: ',0
        source_string db string_buffer dup(0)
        word_shift dd 0
        length dd 0


section '.code' code readable executable


start:
        cinvoke printf, input_string
        cinvoke gets, source_string

	; Поиск самого короткого слова
        cld
        mov ax, ds
        mov es, ax
        lea edi, [source_string]
        mov al, 0
        mov ecx, string_buffer
        repnz scasb ; Листаем до конца строки

 	; Поиск длины строки
        mov eax, string_buffer
        sub eax, ecx
        mov [length], eax
        mov ecx, eax
        mov ebx, ecx

        mov edx, [length] ; Длина самого короткого слова
        lea edi, [source_string]

for_word:
        mov al, ' '
        repnz scasb
        mov eax, ebx
        sub eax, ecx
        dec eax
	cmp eax, 0
	je for_word_continue
        cmp eax, edx
        jae for_word_continue
        mov edx, eax
        mov eax, [length]
        sub eax, ebx
        mov [word_shift], eax
for_word_continue:
        mov ebx, ecx 
        cmp ecx, 0
        jne for_word

	; Печать самого короткого слова
        cinvoke printf, output_string
        cld
        mov eax, [word_shift]
        lea esi, [source_string + eax]
        mov eax, [length]
        sub eax, [word_shift]
        mov ecx, eax
        dec ecx
for_symbol:
        xor eax, eax
        lodsb
        cmp al, ' '
        je for_end
        push ecx
        cinvoke printf, char_format, eax
        pop ecx
        loop for_symbol  

for_end:
        invoke getch
        invoke ExitProcess, 0


section '.idata' import data readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'
 
        import kernel,\
                ExitProcess, 'ExitProcess'
 
        import msvcrt,\
                gets,'gets',\
                printf,'printf',\
                getch, '_getch'
