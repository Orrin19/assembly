.text

@ Input string via stdi
mov r0, #1
ldr r1, =CharArray
mov r2, #80
swi 0x6a

@ Print help string for stdout
mov r0, #1
ldr r1, =upper_str
swi 0x69

ldr r2, =CharArray
mov r5, #0

find_space:
    ldrb r6, [r2], #1
    add r5, r5, #1
    cmp r6, #0 @ compare to end of line
    beq start_print

    cmp r6, #' ' @ compare to space
    bne not_space

    add r4, r5, #0
    add r2, r2, #0
    b find_space

not_space:
    add r3, r4, #0
    add r2, r2, #0
    b find_space

start_print:
    mov r2, #0
    mov r5, #0
    mov r6, #0
    ldr r2, =CharArray

check_char:
    ldrb r6, [r2], #1
    cmp r6, #0 @ if end of line
    beq row_end

    add r5, r5, #1
    cmp r3, r5 @ if last space
    beq row_end

    cmp r6, #'a' 
    blt not_lowercase
    cmp r6, #'z' 
    bgt not_lowercase
    add r6, r6, #'A' - 'a' @ to uppercase

not_lowercase:
    ldr r8, =Char_output
    str r6, [r8] @ save character

    mov r0, #1
    ldr r1, =Char_output @ print character
    swi 0x69

    b check_char

row_end:
    @ output blank line 

    mov r0, #1
    ldr r1, =blank_line
    swi 0x69

swi 0x11

.data
CharArray: .asciz "Hello World, This is a sample sentence."
Char_output: .skip 10
symbol_space_output: .asciz " "
blank_line: .asciz "\n"
upper_str: .asciz "String with all uppercase letters without last word:\n"