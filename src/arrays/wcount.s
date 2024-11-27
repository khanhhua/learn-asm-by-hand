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

        mov edi, ecx            ; search
        mov eax, 0x00           ; ..for null
        mov ecx, 80             ; ..with upper limit
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

EXIT:   mov eax, 0x01
        mov ebx, 0x00
        int 80h

