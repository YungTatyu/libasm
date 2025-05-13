global _start


section .data
  msg db "Hello, World!", 0x0a 
  len equ $ - msg             ; 文字列の長さ

section .text
_start:
  mov eax, 4; write syscall
  mov ebx, 1 ; stdout
  mov ecx, msg 
  mov edx, len ; length
  int 0x80 ; perform syscall
  mov eax, 1
  mov ebx, 42
  sub ebx, 29
  mov ebx, 0
  int 0x80
