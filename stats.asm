global main
extern printf
extern scanf

section .data
    fmt_in db "%ld",0
    fmt_somme db "Somme: %ld",10,0
    fmt_pos db "Positifs: %ld",10,0
    fmt_neg db "Négatifs: %ld",10,0
    fmt_zer db "Zéros: %ld",10,0
    fmt_min db "Min: %ld",10,0
    fmt_max db "Max: %ld",10,0

section .bss
    n resq 1
    i resq 1
    val resq 1
    somme resq 1
    pos resq 1
    negatifs resq 1
    zer resq 1
    minv resq 1
    maxv resq 1

section .text
main:
    push rbp
    mov rbp,rsp

    mov qword [rel somme],0
    mov qword [rel pos],0
    mov qword [rel negatifs],0
    mov qword [rel zer],0
    mov qword [rel i],0

    lea rdi,[rel fmt_in]
    lea rsi,[rel n]
    xor eax,eax
    call scanf

.boucle:
    mov rax,[rel i]
    cmp rax,[rel n]
    jge .affichage

    lea rdi,[rel fmt_in]
    lea rsi,[rel val]
    xor eax,eax
    call scanf

    mov rax,[rel somme]
    add rax,[rel val]
    mov [rel somme],rax

    mov rax,[rel val]
    cmp rax,0
    jg .positif
    jl .negatif
    inc qword [rel zer]
    jmp .minmax

.positif:
    inc qword [rel pos]
    jmp .minmax

.negatif:
    inc qword [rel negatifs]

.minmax:
    mov rax,[rel i]
    cmp rax,0
    jne .compare
    mov rax,[rel val]
    mov [rel minv],rax
    mov [rel maxv],rax
    jmp .suite

.compare:
    mov rax,[rel val]
    cmp rax,[rel minv]
    jge .testmax
    mov [rel minv],rax

.testmax:
    mov rax,[rel val]
    cmp rax,[rel maxv]
    jle .suite
    mov [rel maxv],rax

.suite:
    inc qword [rel i]
    jmp .boucle

.affichage:
    lea rdi,[rel fmt_somme]
    mov rsi,[rel somme]
    xor eax,eax
    call printf

    lea rdi,[rel fmt_pos]
    mov rsi,[rel pos]
    xor eax,eax
    call printf

    lea rdi,[rel fmt_neg]
    mov rsi,[rel negatifs]
    xor eax,eax
    call printf

    lea rdi,[rel fmt_zer]
    mov rsi,[rel zer]
    xor eax,eax
    call printf

    lea rdi,[rel fmt_min]
    mov rsi,[rel minv]
    xor eax,eax
    call printf

    lea rdi,[rel fmt_max]
    mov rsi,[rel maxv]
    xor eax,eax
    call printf

    mov eax,0
    leave
    ret
