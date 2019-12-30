%include "debug.asm"

section .data
str: db "test", 0

section .text
global add
add:
    lea rcx, [rel str]
    debugs rcx
    lea eax, [rdi + rsi]
    ret

global sub
sub:
    debugd32 edi
    debugd32 esi
    mov eax, edi
    sub eax, esi
    debugd32 eax
    ret

global mul
mul:
    mov rax, -1
    debugx8 al
    debugx16 ax
    debugx32 eax
    debugx64 rax
    mov eax, edi
    imul eax, esi
    ret
