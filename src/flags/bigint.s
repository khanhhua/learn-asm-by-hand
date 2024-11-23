section .data
        num1    db 0xFF
        num2    db 0x0F
        result  dd 0x00
section .bss
        arr     resb 64
section .text
        global _start
        _start:
        mov eax, [num1]
        add eax, [num2]
        mov dword [result], eax

        call print

        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

        print:
        push ebp
        mov ebp, esp
        sub esp, 4                     ; Preserve 4 bytes on stack
        lea edi, [ebp - 1]
        push dword [result]             ; [ebp - 8] Temporary for result, local variable
        push 0x00000000                 ; [ebp - 12] Address of returned value
        .loop:
        call modulo
        mov ecx, [ebp - 12]             ; Pop returned value onto eax
        add ecx, 48
        or [edi], ecx
        dec edi

        test dword [ebp - 8], 0xFFFFFFFF
        jnz .loop

        mov eax, 0x04
        mov ebx, 0x01
        lea ecx, [ebp - 4]
        mov edx, 4
        int 0x80

        mov esp, ebp                    ; teleport stack pointer to base, drop all local references
        pop ebp                         ; write back the old ebp and increment stack by 4 bytes
        ret

        modulo:                         ; (int % 10)
        push ebp
        mov ebp, esp

        mov edx, 0x00
        mov eax, [ebp + 12]             ; read the first parameter
        mov ecx, 0x0A
        div ecx
        mov [ebp + 8], edx              ; write to the return address
        mov [ebp + 12], eax

        mov esp, ebp                    ; teleport stack pointer to base, drop all local references
        pop ebp                         ; write back the old ebp and increment stack by 4 bytes
        ret                             ; pop the stack into instruction pointer, causing the jump

        ascii:                          ; Convert byte into ASCII code
        add eax, 48                     ; TODO: Check eax [0,9] boundary
