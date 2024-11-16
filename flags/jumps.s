section .text
global _start
        _start:
        mov eax, 0xFFFFFFFF
        or  eax, 0x00000001
        js $ + 6
        nop
        nop
        nop

        mov eax, 0x01
        mov ebx, 0x00
        int 0x80
