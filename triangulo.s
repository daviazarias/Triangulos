.section .note.GNU-stack,"",@progbits

.section .rodata

ESCREVE = 1
STDOUT = 1

ntri:
    .asciz "Não é um triângulo.\n"
    TamNao = . - ntri

equil:
    .asciz "Triângulo equilátero.\n"
    TamEq = . - equil

isos:
    .asciz "Triângulo isósceles.\n"
    TamIs = . - isos

escal:
    .asciz "Triângulo escaleno.\n"
    TamEs = . - escal

.section .text

.globl triangulo

triangulo:
    movl %edi, %ebx
    movq $ESCREVE, %rax
    movq $STDOUT, %rdi

    xor %r10, %r10
    cmpl %r10d, %ebx
    jle .L3
    cmpl %r10d, %esi
    jle .L3
    cmpl %r10d, %edx
    jle .L3

    movl %ebx, %ecx
    addl %esi, %ecx
    cmpl %ecx, %edx
    jge .L3
    movl %esi, %ecx
    addl %edx, %ecx
    cmpl %ecx, %ebx
    jge .L3
    movl %ebx, %ecx
    addl %edx, %ecx
    cmpl %ecx, %esi
    jge .L3

.calc:
    cmpl %ebx, %esi
    jne .L1
    cmpl %ebx, %edx
    jne .L_Is

    movq $TamEq, %rdx
    leaq equil(%rip), %rsi
    syscall

    ret

.L1:
    cmpl %ebx, %edx
    jne .L2

.L_Is:
    movq $TamIs, %rdx
    leaq isos(%rip), %rsi
    syscall

    ret

.L2:
    cmpl %esi, %edx
    je .L_Is

    movq $TamEs, %rdx
    leaq escal(%rip), %rsi
    syscall

    ret

.L3:
    movq $TamNao, %rdx
    leaq ntri(%rip), %rsi
    syscall
    
    ret
