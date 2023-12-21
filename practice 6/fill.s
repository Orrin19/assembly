.globl _start            
  
.rodata
  O_RDWR:    .word 0b0000100  ; 4
  O_CREAT:   .word 0b0100000  ; 64
  path:      .string "output.txt"
  array:     .byte 11, 23, 11, 21, 32, 16, 14, 15, 16, 21, 34, 23, 15, 43, 23, 33
  size_arr:  .word  16 # 4*4

.text
_start:
  li a0, 13  ; 13 - open
  la a1, path
  lw a2, O_RDWR
  lw t0, O_CREAT
  or a2, a2, t0  ; a2 = O_RDWR | O_CREAT
  ecall  ; открытие: путь, флаги открытия
  mv s0, a0  ; s0 - file descriptor

  li a0, 15  ; 15 - write
  mv a1, s0
  la a2, array
  lw a3, size_arr
  ecall  ; запись: дескриптор, что записывать, сколько записывать

  li a0, 16  ; 16 - close file
  mv a1, s0
  ecall  ; закрытие: дескриптор

  li a0, 10
  ecall
  