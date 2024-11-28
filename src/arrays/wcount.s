; TITLE WordCount -- count the word in a file
; synopsis: wcount inputfile
section .data
        constp_fname dd 0x00000000      ; const pointer to filename

section .bss
        buffer db 64
                                ; histogram table ::
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

        push 64
        push buffer
        sub esp, 4              ; Local variable FILE* fd
        mov eax, 0x05
        mov ebx, [constp_fname]
        mov ecx, 0x00
        int 0x80

        mov [esp], eax
        .readloop:
        call readline           ; Result for bytes read is in eax
        cmp eax, 0
        jz EXIT
        sub esp, 12             ; Recover function parameters for readline

        push 65                 ; printn(&buffer, 65)
        push buffer
        call printn

        jmp .readloop


EXIT:   mov eax, 0x01
        mov ebx, 0x00
        int 80h

printn: push ebp                ; void printn(const char*, int)
        mov ebp, esp
        mov edi, [ebp+8]        ; search
        mov eax, 0x00           ; ..for null
        mov ecx, [ebp+12]       ; ..with upper limit
        repne scasb             ; by repeatedly comparing [edi] with eax
        jnz EXIT                ; Your string is damn long!
        dec edi
                                ; now determine string length
        mov edx, edi            ; by finding the difference
        sub edx, [ebp+8]        ; between edi and [constp_fname]
        mov eax, 0x04           ; and we do the mighty print to stdout
        mov ebx, 0x01
        mov ecx, [ebp+8]        ; load the pointer to ecx
        int 0x80

        ; Leave!
        mov esp, ebp
        pop ebp
        ret 8

readline:                       ; void readline(int fd, char*, int)
        push ebp
        mov ebp, esp
        mov eax, 0x03
        mov ebx, [ebp+8]
        mov ecx, [ebp+12]
        mov edx, [ebp+16]
        int 0x80

        ; Leave!
        mov esp, ebp
        pop ebp
        ret 12

