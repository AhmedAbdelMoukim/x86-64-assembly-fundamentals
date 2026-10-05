global main
extern printf
extern scanf

section .data
    fmt_in db "%ld",0
    fmt_sign db "Signe: %s",10,0
    fmt_parity db "Parité: %s",10,0
    txt_negatif db "négatif",0
    txt_nul db "nul",0
    txt_positif db "positif",0
    txt_pair db "pair",0
    txt_impair db "impair",0

section .bss
    nombre resq 1

section .text
main:
    push rbp
    mov rbp,rsp

    lea rdi,[rel fmt_in]
    lea rsi,[rel nombre]
    xor eax,eax
    call scanf

    mov rax,[rel nombre]
    cmp rax,0
    jl .negatif
    jg .positif

.nul:
    lea rdi,[rel fmt_sign]
    lea rsi,[rel txt_nul]
    xor eax,eax
    call printf
    jmp .fin

.negatif:
    lea rdi,[rel fmt_sign]
    lea rsi,[rel txt_negatif]
    xor eax,eax
    call printf
    jmp .parite

.positif:
    lea rdi,[rel fmt_sign]
    lea rsi,[rel txt_positif]
    xor eax,eax
    call printf

.parite:
    mov rax,[rel nombre]
    test rax,1
    jnz .impair

.pair:
    lea rdi,[rel fmt_parity]
    lea rsi,[rel txt_pair]
    xor eax,eax
    call printf
    jmp .fin

.impair:
    lea rdi,[rel fmt_parity]
    lea rsi,[rel txt_impair]
    xor eax,eax
    call printf

.fin:
    mov eax,0
    leave
    ret
