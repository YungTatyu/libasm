global ft_strlen

; @param esi: pointer to the string
; @returns eax: length of the string
ft_strlen:
  mov ecx, 0
  jmp .loop

.loop:
  mov al, [esi]
  cmp al, 0
  je .done
  inc ecx
  inc esi
  jmp .loop

.done:
  mov eax, ecx
  ret
