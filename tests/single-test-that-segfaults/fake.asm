section .text
global add
add:
    xor eax, eax
    mov dword [rax], 123
    ret
