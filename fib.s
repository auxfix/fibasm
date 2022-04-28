global  _start

section .text
_start:
    xor rbx, rbx
    xor rax, rax
    inc rbx,
loopFib:
    add rax, rbx
    xchg rax, rbx
    cmp rbx, 10
    js loopFib		
