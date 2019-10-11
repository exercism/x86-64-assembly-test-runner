section .text
global invalid
invalid:
    lea eax, [rdi + rsi]
    ret
