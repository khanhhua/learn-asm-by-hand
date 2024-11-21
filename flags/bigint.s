section .data
        num1    db 0xFF
        num2    db 0x0F
        result  dd 0x00
        str     resb 64
section .text

global _start
        _start:
        mov eax, num1
        add eax, num2
        mov dword [result], eax
        call print

        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

        print:
        mov eax, result                 ; load the number to be printed
        lea ecx, str
        .collect:
        div 0x0000000A                  ; Unsigned division with remainder into EDX
        mov [ecx], edx                  ; Stock the remainder onto Stack
        inc ecx                         ; increment the pointer
        test eax, 0xFFFFFFFF
        jnz .collect
        ; Backrolling str
        .loop:
        dec ecx
        add byte [ecx], 48

        test ecx, str                    ; base matches
        jnz .loop
        ret

        pushstr:
        ret

        modulo:                         ; (int % 10)
        div 10

        ascii:                          ; Convert byte into ASCII code
        add eax, 48                     ; TODO: Check eax [0,9] boundary
