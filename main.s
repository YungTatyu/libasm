section .data
    msg db "Hello, world!", 0xA  ; 改行付き文字列
    len equ $ - msg              ; 文字列の長さを自動計算

section .text
    global _start

_start:
    ; write(int fd, const void *buf, size_t count)
    mov rax, 1          ; syscall number: sys_write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg        ; buffer: 文字列のアドレス
    mov rdx, len        ; count: 文字列の長さ
    syscall

    ; exit(int status)
    mov rax, 60         ; syscall number: sys_exit
    xor rdi, rdi        ; exit status: 0
    syscall
