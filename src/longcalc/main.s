%macro FREE_POP 0
  mov dword [esp], 0x00
  add esp, 4
%endmacro

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

  dec eax
  add ecx, eax
  mov byte [ecx], 0x00
%endmacro

%macro EXIT 0
  mov eax, 0x01
  mov ebx, 0
  int 0x80
%endmacro

%macro CTOI 1
  sub %1, 48
%endmacro

atoi:                   ; atoi(out int*, in char* string, in int length), flag eax
  mov eax, 0
  mov ecx, [esp + 4]    ; load i into forloop
  mov ebx, [esp + 8]    ; points ebx to the input buffer

LOOPY:
  push ebx              ; save current buffer pointer
  movzx ebx, byte [ebx]
  CTOI ebx

  push ecx
  mov ecx, 10
  mul ecx               ; shift left base-10
  add eax, ebx          ; .. add the decoded ebx to eax
  pop ecx

  dec ecx
  jecxz LOOPY_END
  
  pop ebx               ; load current buffer pointer
  inc ebx
  cmp byte [ebx], 0
  jne LOOPY

LOOPY_END:
  mov ebx, [esp + 12]
  mov dword [ebx], eax
  xor eax, eax

  ret

strlen:                 ; void strlen(out int*, in char*)
  mov eax, 0x00            ; find the NULL character
  mov edi, [esp + 4]
  mov ecx, 80
  repne scasb

  mov dword [esp + 8], 80
  sub dword [esp + 8], ecx
  
  ret

section .data
S1:       db "Enter operator:",0
S1_LEN:   equ $-S1

S2:       db "Operand 1:",0
S2_LEN:   equ $-S2

S3:       db "Operand 2:",0
S3_LEN:   equ $-S3

section .bss
INPUT:    resb 80
; Allocating 3 dwords on the stack: a, b, and c
OPERAND_A resb 4

section .text
  global _start


_start:
  push ebp
  mov ebp, esp

  PRINT S1, S1_LEN
  READLINE INPUT
  PRINT INPUT, 80

  ; atoi(
  push OPERAND_A
  push INPUT
  ; strlen(
  push 0
  push INPUT
  call strlen
  FREE_POP
  ; )

  call atoi
  FREE_POP
  FREE_POP
  ; )

  EXIT
