// Printed from Lean (Lang.lean). Not written or edited by hand.
#if defined(__ELF__) && defined(__linux__)
.section .note.GNU-stack,"",%progbits
#endif
#ifdef __APPLE__
#define CALL(f) _##f
#else
#define CALL(f) f@PLT
#endif
.intel_syntax noprefix
.text
.global b3l_adler32
.global _b3l_adler32
.p2align 4
b3l_adler32:
_b3l_adler32:
    push rbx
    push rbp
    push r12
    push r13
    push r14
    mov rbx, rdi
    mov rbp, rsi
    mov rax, 2
    mov r12, rax
    mov rax, 0
    mov r13, rax
    mov rax, 0
    mov r14, rax
.Lb3l_adler32_0:
    mov rax, r14
    mov rcx, rbp
    cmp rax, rcx
    jae .Lb3l_adler32_1
    mov rax, r12
    mov rcx, rbx
    add rcx, r14
    movzx ecx, byte ptr [rcx]
    add rax, rcx
    mov r12, rax
    mov rax, r12
    mov rcx, 65521
    cmp rax, rcx
    jae .Lb3l_adler32_2
    jmp .Lb3l_adler32_3
.Lb3l_adler32_2:
    mov rax, r12
    sub rax, 65521
    mov r12, rax
.Lb3l_adler32_3:
    mov rax, r13
    add rax, r12
    mov r13, rax
    mov rax, r13
    mov rcx, 65521
    cmp rax, rcx
    jae .Lb3l_adler32_4
    jmp .Lb3l_adler32_5
.Lb3l_adler32_4:
    mov rax, r13
    sub rax, 65521
    mov r13, rax
.Lb3l_adler32_5:
    mov rax, r14
    add rax, 1
    mov r14, rax
    jmp .Lb3l_adler32_0
.Lb3l_adler32_1:
    mov rax, r13
    shl rax, 16
    or rax, r12
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx
    ret
