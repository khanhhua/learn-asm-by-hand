bits 64                         ; x64 mode
        section .text                   ; section type
        global  _main                 ; default entry point
_main:  mov rax, 0x2000001      ; syscall 1: exit (
        mov rdi, 0              ;    retcode
        syscall                 ; )
