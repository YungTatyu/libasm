section .data
str db 'hello', 0x0A, 0

section .text
global _start

_start:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, str        ; メッセージ
    mov rdx, 6          ; バイト数（"hello\n"）
    syscall

    mov rax, 60         ; syscall: exit
    xor rdi, rdi
    syscall

