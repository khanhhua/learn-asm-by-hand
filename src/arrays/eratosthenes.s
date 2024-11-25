section .title  "Sieves of Eratosthenes"

section .data
        count   dw      65000

section .bss
        nums    resw    65000

section .text
        global _start

        _start:
        ; Generate the brothers of 65000 integers
        mov ecx, [count]
        dec ecx
        mov dword eax, 0x00000000
        mov edi, nums           ; point edi to address of nums
        .Generate:
        inc eax
        stosw                   ; store content of eax to [edi] then inc edi

        dec ecx
        jcxz .Mark
        jmp .Generate

        .Mark:
        lea edi, [nums]
        mov ecx, 0x000000FF     ; Repeat 255 times
        .OuterLoop:
        jcxz EXIT
        dec ecx                 ; Counter for OuterLoop

        add edi, 0x02
        test word [edi], 0xFFFF ; edi points to denominator, should not be zero
        jz .OuterLoop           ; our dear continue statement!

        mov esi, edi            ; Align inner index with outer

        push ecx                ; save Counter for OuterLoop
        .InnerLoop:
        jcxz .ExitInner         ; Counter ecx is zero, goto EXIT
        dec ecx
        add esi, 0x02           ; Inner index is 2 bytes ahead of outer

        mov edx, 0x00000000
        mov word ax, [esi]      ; load nominator at [esi] into eax
        push word [edi]
        div word [esp]          ; mod by denominator at [edi], remainder is stored on edx
        add esp, 0x02

        test edx, 0xFFFFFFFF
        jnz .InnerLoop          ; any remainder means not divisible, do not drop
        mov word [esi], 0x0000  ; drop [esi] to zero
        jmp .InnerLoop

        .ExitInner:
        pop ecx
        jmp .OuterLoop

        EXIT:
        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

