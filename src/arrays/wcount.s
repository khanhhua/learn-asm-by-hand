; TITLE WordCount -- count the word in a file
; synopsis: wcount inputfile
section .data
        constp_fname dd 0x00000000      ; const pointer to filename

section .bss
        histogram db 64      ; histogram table ::
                                ; - key: byte[]
                                ; - count: dword
section .text
        global _start:

_start: mov ecx, [esp]         ; how many args are there?
        dec ecx              ; since the executable counts as 1
        jcxz EXIT

        ; Double-deference pointers
        mov ecx, [esp + 8]
        mov dword [constp_fname], ecx

        push 80
        push dword [constp_fname]
        call printn

        jmp EXIT

printn: push ebp                ; void printn(const char*, int)
        mov ebp, esp
        mov edi, [ebp+8]            ; search
        mov eax, 0x00           ; ..for null
        mov ecx, [ebp+12]             ; ..with upper limit
        repne scasb             ; by repeatedly comparing [edi] with eax
        jnz EXIT                ; Your string is damn long!
        dec edi
                                ; now determine string length
        mov edx, edi            ; by finding the difference
        sub edx, [constp_fname] ; between edi and [constp_fname]
        mov eax, 0x04           ; and we do the mighty print to stdout
        mov ebx, 0x01
        mov ecx, [constp_fname] ; load the pointer to ecx
        int 0x80

        ; Leave!
        mov esp, ebp
        pop ebp
        ret 8

EXIT:   mov eax, 0x01
        mov ebx, 0x00
        int 80h

