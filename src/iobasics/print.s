; Stack width is so wide as the architecture
; byte = db
; word = dw
; double-word = dd
section .data

section .bss

section .text

global _start
        _start:
        push 0x0000022C         ; 4bytes less on the stack
        call print_int          ; call label does push $eip onto stack

        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

        print_int:              ; print_int doubleword=32bit
        ; 4bytes for the first param
        sub esp, 0x03           ; Reserves 3 bytes on stack for char str[3]
        lea ecx, [esp + 2]
        mov eax, [esp + 7]      ; Points eax to the 1st param (of 4bytes in size)
        mov ebx, 0x0A
        .loop:
        mov edx, 0
        div ebx
        add edx, 48     ; ASCII character "0" offset
        or [ecx], edx   ; Write edx to the head of str
        sub ecx, 1      ; "Append" an empty head to str, in final interation it points to invalid memory location
        test eax, 0xFFFF
        jnz .loop

        lea ecx, [esp]
        mov eax, 0x04
        mov ebx, 0x01
        mov edx, 3
        int 0x80

        add esp, 0x03
        ret                     ; used in tandem with "call", pops stack to $eip

