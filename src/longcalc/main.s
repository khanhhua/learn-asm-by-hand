%macro PRINT 2
  mov eax, 0x04
  mov ecx, %1
  mov edx, %2
  int 0x80
%endmacro

%macro READLINE 1
  mov eax, 0x03
  mov ebx, 0
  lea ecx, %1
  mov edx, 80
  int 0x80
%endmacro

%macro EXIT 0
  mov eax, 0x01
  mov ebx, 0
  int 0x80
%endmacro

section .data
S1:       db "Enter operator:",0
S1_LEN:   equ $-S1

S2:       db "Operand 1:",0
S2_LEN:   equ $-S2

S3:       db "Operand 2:",0
S3_LEN:   equ $-S3

section .bss
INPUT:    resb 80

section .text
  global _start


_start:
  push ebp
  mov ebp, esp

  PRINT S1, S1_LEN
  READLINE INPUT
  PRINT INPUT, 80

  EXIT
