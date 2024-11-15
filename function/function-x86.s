section .data

section .text

global  _start

        write_n_bytes:       ; Write n bytes to stdout
        mov eax, 0x04         ; kernel write
        mov ebx, 0x01         ; destination stdout
        lea ecx, [esp+8]      ;   arg2: string
        mov edx, [esp+4]      ;   arg1: length
        int 0x80
        ret

        EXIT:
        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

        _start:
        ; Push 2 params: length, string onto stack
        push 0xA214948
        push 0x04
        call write_n_bytes
        call EXIT
