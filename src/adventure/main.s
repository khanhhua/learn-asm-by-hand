global _start

%macro PRINT 2
	mov eax, 0x04
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro

section .data

Q1:
	db "You woke up on an desserted island...", 10, 0
Q1_LEN: equ $-Q1

Q2:
  db "There is a bag of bread. Would you eat?", 10, 0
Q2_LEN: equ $-Q2

Q2_1:
  db "You ate molded bread. You died.", 10, 0
Q2_1_LEN: equ $-Q2_1

Q2_2:
  db "You left the bread and walked toward the ocean.", 10, 0
Q2_2_LEN: equ $-Q2_2

section .bss

section .text

_start:
  PRINT Q1, Q1_LEN
	call readline

  PRINT Q2, Q2_LEN
  push 0
  call readline
  pop eax

  cmp eax, 'y'
  jne the_beach
  PRINT Q2_1, Q2_1_LEN
  call readline
  jmp exit

  the_beach:
  PRINT Q2_2, Q2_2_LEN
  call readline

	jmp exit

readline:
	mov eax, 0x03
	mov ebx, 0
  lea ecx, [esp + 4]
	mov edx, 1
	int 0x80

	ret

exit:
	mov eax, 0x01
	mov ebx, 0
	int 0x80
