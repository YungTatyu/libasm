global foo        ; グローバルシンボルとして公開（Cやmain.sから使える）

section .text
foo:
    mov rax, 42   ; 戻り値 42 を rax に入れる（関数の戻り値）
    ret           ; リターン
