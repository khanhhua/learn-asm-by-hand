section .data
        greeting        db "Welcome to Arith Station",0,0xA
        greetingLen     equ $-greeting

        zeroFlagOnMsg   db "Zero Flag: 1",0,0xA
        zeroFlagOffMsg  db "Zero Flag: 0",0,0xA
        flagMsgLen      equ $-zeroFlagOffMsg
        signFlagOnMsg   db "Sign Flag: 1",0,0xA
        signFlagOffMsg  db "Sign Flag: 0",0,0xA

section .text

global  _start
        _start:
        ; Print the greeting
        ; mov eax, 0x04
        ; mov ebx, 0x01
        ; mov ecx, greeting
        ; mov edx, greetingLen
        ; int 0x80

        ; Do math and check flags
        mov eax, 0x00000111
        and eax, 0x00000000
        call flagsdump

        ; Do a core flagsdump
        ; jz show_zero_flag
        jmp EXIT

        flagsdump:
        pushfd
        test dword [esp], 0x80          ; flags: ZERO 0x40, SIGN 0x80
        mov eax, 0x04
        mov ebx, 0x01
        mov edx, flagMsgLen

        mov ecx, signFlagOnMsg
        jnz .skipnext1
        mov ecx, signFlagOffMsg
        .skipnext1:
        int 0x80

        test dword [esp], 0x40          ; flags: ZERO 0x40, SIGN 0x80
        mov eax, 0x04
        mov ebx, 0x01
        mov edx, flagMsgLen

        mov ecx, zeroFlagOnMsg
        jnz .skipnext0
        mov ecx, zeroFlagOffMsg
        .skipnext0:
        int 0x80

        EXIT:
        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

