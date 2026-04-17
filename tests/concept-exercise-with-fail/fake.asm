section .text
global add
add:
    lea eax, [rdi + rsi]
    ret

global mul
mul:
    mov eax, edi
    imul eax, esi
    inc eax
    ret
