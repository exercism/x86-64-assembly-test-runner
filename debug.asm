extern printf

section .data
fmtd: db "%d", 0xA, 0x0
fmtzd: db "%zd", 0xA, 0x0
fmtu: db "%u", 0xA, 0x0
fmtzu: db "%zu", 0xA, 0x0
fmtx: db "%X", 0xA, 0x0
fmtzx: db "%zX", 0xA, 0x0
fmtf: db "%f", 0xA, 0x0
fmtc: db "%c", 0xA, 0x0
fmts: db "%s", 0xA, 0x0

%macro save_registers 0

    ; Preserve caller-save registers
    push rax
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11

    ; Preserve xmm registers
    sub rsp, 128
    movsd [rsp], xmm0
    movsd [rsp + 8], xmm1
    movsd [rsp + 16], xmm2
    movsd [rsp + 24], xmm3
    movsd [rsp + 32], xmm4
    movsd [rsp + 40], xmm5
    movsd [rsp + 48], xmm6
    movsd [rsp + 56], xmm7
    movsd [rsp + 64], xmm8
    movsd [rsp + 72], xmm9
    movsd [rsp + 80], xmm10
    movsd [rsp + 88], xmm11
    movsd [rsp + 96], xmm12
    movsd [rsp + 104], xmm13
    movsd [rsp + 112], xmm14
    movsd [rsp + 120], xmm15

%endmacro

%macro restore_registers 0

    ; Restore xmm registers
    movsd xmm0, [rsp]
    movsd xmm1, [rsp + 8]
    movsd xmm2, [rsp + 16]
    movsd xmm3, [rsp + 24]
    movsd xmm4, [rsp + 32]
    movsd xmm5, [rsp + 40]
    movsd xmm6, [rsp + 48]
    movsd xmm7, [rsp + 56]
    movsd xmm8, [rsp + 64]
    movsd xmm9, [rsp + 72]
    movsd xmm10, [rsp + 80]
    movsd xmm11, [rsp + 88]
    movsd xmm12, [rsp + 96]
    movsd xmm13, [rsp + 104]
    movsd xmm14, [rsp + 112]
    movsd xmm15, [rsp + 120]
    add rsp, 128

    ; Restore caller-save registers
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rax

%endmacro

%macro save_sp 0

    push rbp
    mov rbp, rsp

%endmacro

%macro restore_sp 0

    mov rsp, rbp
    pop rbp

%endmacro

%macro align_sp 0

    and rsp, -16

%endmacro

%macro debugd8 1

    save_registers
    movsx rsi, %1
    lea rdi, [rel fmtd]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugd16 1

    debugd8 %1

%endmacro

%macro debugd32 1

    debugd8 %1

%endmacro

%macro debugd64 1

    save_registers
    mov rsi, %1
    lea rdi, [rel fmtzd]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugu8 1

    save_registers
    movzx esi, %1
    lea rdi, [rel fmtu]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugu16 1

    debugu8 %1

%endmacro

%macro debugu32 1

    save_registers
    mov esi, %1
    lea rdi, [rel fmtu]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugu64 1

    save_registers
    mov rsi, %1
    lea rdi, [rel fmtzu]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugx8 1

    save_registers
    movzx esi, %1
    lea rdi, [rel fmtx]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugx16 1

    debugx8 %1

%endmacro

%macro debugx32 1

    save_registers
    mov esi, %1
    lea rdi, [rel fmtx]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugx64 1

    save_registers
    mov rsi, %1
    lea rdi, [rel fmtzx]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugf 1

    save_registers
    cvtss2sd xmm0, %1
    lea rdi, [rel fmtf]
    mov eax, 1
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugc 1

    save_registers
    movzx esi, %1
    lea rdi, [rel fmtc]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro

%macro debugs 1

    save_registers
    mov rsi, %1
    lea rdi, [rel fmts]
    xor eax, eax
    save_sp
    align_sp
    call printf wrt ..plt
    restore_sp
    restore_registers

%endmacro
