section .data
        num     dd      192

section .bss
        str:    resb    3
        strlen: equ     $-str

section .text

global _start
        _start:
        call print_int

        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

        print_int:
        lea ecx, [str + strlen - 1]
        mov eax, [num]
        mov ebx, 0x0A
        .loop:
        mov edx, 0
        div ebx
        add edx, 48     ; ASCII character "0" offset
        or [ecx], edx
        sub ecx, 1
        test eax, 0xFFFF
        jnz .loop

        mov ecx, str
        mov eax, 0x04
        mov ebx, 0x01
        mov edx, strlen
        int 0x80

        ret

