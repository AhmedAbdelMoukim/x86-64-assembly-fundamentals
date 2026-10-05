global main
extern printf
extern scanf

section .data
    menu_txt db "--- Menu ---",10,"1. Addition",10,"2. Soustraction",10,"3. Minimum",10,"4. Maximum",10,"5. Quitter",10,"Choix:",10,0
    fmt_in db "%ld",0
    fmt_result db "Résultat: %ld",10,0
    txt_invalid db "Choix invalide!",10,0
    txt_bye db "Au revoir!",10,0

section .bss
    choix resq 1
    a resq 1
    b resq 1
    resultat resq 1

section .text
main:
    push rbp
    mov rbp,rsp

.boucle:
    lea rdi,[rel menu_txt]
    xor eax,eax
    call printf

    lea rdi,[rel fmt_in]
    lea rsi,[rel choix]
    xor eax,eax
    call scanf

    mov rax,[rel choix]
    cmp rax,1
    je .addition
    cmp rax,2
    je .soustraction
    cmp rax,3
    je .minimum
    cmp rax,4
    je .maximum
    cmp rax,5
    je .quitter

    lea rdi,[rel txt_invalid]
    xor eax,eax
    call printf
    jmp .boucle

.lire:
    lea rdi,[rel fmt_in]
    lea rsi,[rel a]
    xor eax,eax
    call scanf
    lea rdi,[rel fmt_in]
    lea rsi,[rel b]
    xor eax,eax
    call scanf
    ret

.addition:
    call .lire
    mov rax,[rel a]
    add rax,[rel b]
    mov [rel resultat],rax
    jmp .afficher

.soustraction:
    call .lire
    mov rax,[rel a]
    sub rax,[rel b]
    mov [rel resultat],rax
    jmp .afficher

.minimum:
    call .lire
    mov rax,[rel a]
    mov rcx,[rel b]
    cmp rax,rcx
    jle .min_a
    mov [rel resultat],rcx
    jmp .afficher
.min_a:
    mov [rel resultat],rax
    jmp .afficher

.maximum:
    call .lire
    mov rax,[rel a]
    mov rcx,[rel b]
    cmp rax,rcx
    jge .max_a
    mov [rel resultat],rcx
    jmp .afficher
.max_a:
    mov [rel resultat],rax

.afficher:
    lea rdi,[rel fmt_result]
    mov rsi,[rel resultat]
    xor eax,eax
    call printf
    jmp .boucle

.quitter:
    lea rdi,[rel txt_bye]
    xor eax,eax
    call printf
    mov eax,0
    leave
    ret
