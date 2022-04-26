global  _start

section .text
_start:
    xor rbx, rbx
    xor rax, rax
    inc rbx,
    mov rcx, 10
loopFib:
    add rax, rbx
    xchg rax, rbx
    loop loopFib		
