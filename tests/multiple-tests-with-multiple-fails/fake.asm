section .text
global add
add:
    lea eax, [rdi + rsi]
    ret

global sub
sub:
    mov eax, edi
    sub eax, esi
    ret

global mul
mul:
    mov eax, edi
    imul eax, esi
    ret
