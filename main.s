.section .note.GNU-stack,"",@progbits

.section .text

.globl _start

_start:
    pushq %rbp
    movq %rsp, %rbp
    subq $12, %rsp

    movq %rsp, %rdi
    call ler_int

    leaq 4(%rsp), %rdi
    call ler_int

    leaq 8(%rsp), %rdi
    call ler_int

    movl (%rsp), %edi
    movl 4(%rsp), %esi
    movl 8(%rsp), %edx
    call triangulo

    addq $12, %rsp
    popq %rbp

    xor %rdi, %rdi
    movq $60, %rax
    syscall
