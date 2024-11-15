section .data
        greeting        db "Welcome to Arith Station",0,0xA
        greetingLen     equ $-greeting

        zeroFlagMsg    db "Zero Flag on",0,0xA
        zeroFlagMsgLen equ $-zeroFlagMsg

section .text

global  _start
        _start:
        ; Print the greeting
        mov eax, 0x04
        mov ebx, 0x01
        mov ecx, greeting
        mov edx, greetingLen
        int 0x80

        ; Do math and check flags
        mov eax, 0xFFFF
        sub eax, eax
        ; Do a core flagsdump
        jz show_zero_flag
        jmp EXIT

        show_zero_flag:
        ; Print carry flag on message
        mov eax, 0x04
        mov ebx, 0x01
        mov ecx, zeroFlagMsg
        mov edx, zeroFlagMsgLen
        int 0x80
        jmp EXIT

        flagsdump:
        pushf
        mov eax, 0x04
        mov ebx, 0x01
 
        pop ecx
        mov edx, 0x04
        int 0x80
        ret             ; Set EBP back to callee frame

        EXIT:
        mov eax, 0x01
        mov ebx, 0x00
        int 0x80

