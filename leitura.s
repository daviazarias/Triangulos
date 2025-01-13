.section .note.GNU-stack,"",@progbits

.section .data
    sinal: .byte 0

.text

.globl ler_int

# Chamada de sistema para ler uma string de caracteres da entrada padrão.
# Tamanho da string a ser lida deve ser colocado em %rsi.

leitura:
    xor %rax, %rax
    mov %rsi, %rdx
    mov %rdi, %rsi
    xor %rdi, %rdi
    syscall

    ret

ler_int:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp # Aumentando a pilha.

    movq %rdi, %r10
    movq %rsp, %rdi # %rdi agora tem o endereço para o início do buffer.
    movl $12, %esi # Colocando o tamanho da string em %esi.
    call leitura

    # O primeiro caractere da string é interpretado como caractere de sinal.
    # Se for igual a ascii 45 (-), o número é negativo, caso contrário, é não negativo.
    movb (%rsp), %al
    movb %al, sinal(%rip)

    movl $10, %r9d # R9d = 10
    xor %ecx, %ecx
    dec %ecx # ECX = -1
    xor %eax, %eax # EAX = EDX = 0
    xor %edx, %edx

.ite:
    inc %ecx
    cmpl $12, %ecx
    jge .out
    movb (%rsp, %rcx), %dil # (%rsp, %ecx) = %dil = buf[i]
    cmpl %r9d, %edi
    je .out

    cmpb $47, %dil
    jle .ite
    cmpb $58, %dil
    jge .ite

    mull %r9d
    addl %edi, %eax
    subl $48, %eax
    jmp .ite

.out:
    movl %eax, (%r10)
    cmpl $12, %ecx
    jne .sig

    movq %rsp, %rdi
    movl $12, %esi
    call leitura

    xor %rcx, %rcx
    dec %rcx
    movl (%r10), %eax
    jmp .ite

.sig:
    cmpb $45, sinal(%rip)
    jne .fim
    negl (%r10)

.fim:
    addq $16, %rsp # Restaurando o tamanho inicial da pilha.
    popq %rbp
    ret
