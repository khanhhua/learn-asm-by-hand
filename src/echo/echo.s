section .bss
  input_str:    resb 80

section .text
  global _start

_start:
  mov eax, 0x03
  mov ebx, 0
  mov ecx, input_str
  mov edx, 80
  int 0x80

  mov eax, 0x04
  int 0x80

  ; Outtro
  mov eax, 0x01
  mov ebx, 0x00
  int 0x80

