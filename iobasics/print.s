section .data
        num     dd      192

section .bss

section .text

global _start
        _start:
        call print_int

        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

        print_int:
        sub esp, 0x03           ; Reserves 3 bytes on stack for char str[3]
        lea ecx, [esp + 0x02]
        mov eax, [num]
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
        ret

