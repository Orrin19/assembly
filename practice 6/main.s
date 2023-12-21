.globl _start


.bss
  array:            .zero 16  ; 4*4 по 1 байту


.rodata
  O_READONLY:       .word 0b0000001
  path:             .string "output.txt"
  size_arr:         .word  16 ; 4*4
  N:                .word 4  ; колонки
  M:                .word 4  ; строки


.text


func:
  mv t1, a0 ; t1: адрес входного массива
  lw t2, N

  ; (0, 0)
  li t3, 0
  li t4, 0
  mv t5, t3  ; t5: смещение
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)
  
  li a0, 1  ; вывод числа
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ; (0, 1)
  li t3, 0
  li t4, 1
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)

  ; (1, 0)
  li t3, 1
  li t4, 0
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g1
  mv t6, t3
  _g1:
  
  li a0, 1
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ; (0, 2)
  li t3, 0
  li t4, 2
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)

  ; (1, 1)
  li t3, 1
  li t4, 1
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g2
  mv t6, t3
  _g2:

  ; (2, 0)
  li t3, 2
  li t4, 0
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g3
  mv t6, t3
  _g3:
  
  li a0, 1
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ; (0, 3)
  li t3, 0
  li t4, 3
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)

  ; (1, 2)
  li t3, 1
  li t4, 2
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g4
  mv t6, t3
  _g4:

  ; (2, 1)
  li t3, 2
  li t4, 1
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g5
  mv t6, t3
  _g5:

  ; (3, 0)
  li t3, 3
  li t4, 0
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g6
  mv t6, t3
  _g6:
  
  li a0, 1
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ; (1, 3)
  li t3, 1
  li t4, 3
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)

  ; (2, 2)
  li t3, 2
  li t4, 2
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g7
  mv t6, t3
  _g7:

  ; (3, 1)
  li t3, 3
  li t4, 1
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g8
  mv t6, t3
  _g8:
  
  li a0, 1
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ; (2, 3)
  li t3, 2
  li t4, 3
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)

  ; (3, 2)
  li t3, 3
  li t4, 2
  mv t5, t3 
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t3, 0(t0)
  
  blt t3, t6 _g9
  mv t6, t3
  _g9:
  
  li a0, 1
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ; (3, 3)
  li t3, 3
  li t4, 3
  mv t5, t3
  mul t5, t5, t2
  add t5, t5, t4
  mv  t0, t1
  add t0, t0, t5
  lb t6, 0(t0)
  
  li a0, 1
  mv a1, t6
  ecall
  li a0, 11
  li a1, ' '
  ecall

  ret

; 0
; 1, 4
; 2, 5, 8
; 3, 7, 11, 15
; 14, 18, 22
; 19, 23
; 24
      
print_arr:
  mv t1, a0  ; t1: адрес входного массива
  li t3, 0  ; текущая строка
  print_arr_row:
    lw t2, N
    li t4, 0  ; t4: текущий столбец
    print_arr_col:
      mv t5, t3  ; t5: смещение
      mul t5, t5, t2
      add t5, t5, t4
      
      mv  t0, t1
      add t0, t0, t5
      lb t6, 0(t0)
  
      li a0, 1  ; вывод числа
      mv a1, t6
      ecall   
      li a0, 11
      li a1, ' '
      ecall
      
      addi t4, t4, 1
      blt t4, t2, print_arr_col
    
    li a0, 11  ; переход на следующую строку
    li a1, '\n'
    ecall

    addi t3, t3, 1
    lw t0, M
    blt t3, t0, print_arr_row
  li a0, 11
  li a1, '\n'
  ecall
  ret


_start:
  li a0, 13  ; 13 - open
  la a1, path
  lw a2, O_READONLY  ; только чтение
  ecall
  mv s0, a0  ; s0 - file descriptor
  
  li a0, 14  ; чтение
  mv a1, s0
  la a2, array
  lw a3, size_arr
  ecall

  la a0, array
  call print_arr
  
  la a0, array
  call func  ; задание
  
  li a0, 10
  ecall
