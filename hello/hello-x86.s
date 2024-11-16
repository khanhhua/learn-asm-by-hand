section .data

        msg:     db      "Hello World",0xA,0
        newline: db      0xa

section .bss

section .text
        global  _start

        _start:
        mov ebx, 0x01
        mov ecx, msg
        mov edx, 13
        mov eax, 0x04
        int 0x80

        mov eax, 0x01 ; call exit {
        mov ebx, 0x00 ;   status code = 0
        int 0x80      ; }

