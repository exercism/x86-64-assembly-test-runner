section .text
global add
add:
    lea eax, [rdi + rsi]
    ret
