bits 32 

global start

extern exit, fopen, fclose, fread, fprintf, system
import exit msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import system msvcrt.dll

segment code use32 class=code
    start:
    push mod_acces
    push nume_fisier
    call [fopen]
    add esp, 8

    cmp eax, 0
    je sa_terminat
    mov [descriptor], eax

    push dword [descriptor]
    push 100
    push 1
    push sir
    call [fread]
    add esp, 16

    mov ecx, eax
    mov esi, sir

    push ecx
    push mod_scriere
    push nume_fisier1
    call [fopen]
    add esp, 8
    mov [descriptor_scriere], eax
    cmp eax, 0
    je sa_terminat
    pop ecx


    parcurgere_sir:
    mov eax, 0
    lodsb

    test byte [nr_prop], 01h
    jz par
        push ecx
        push eax
        push afis_char
        push dword [descriptor_scriere]
        call [fprintf]
        add esp, 8
        pop eax
        pop ecx
    par:

    cmp al, '!'
    jne nu_e_gata_prop
        inc byte [nr_prop] 
    nu_e_gata_prop:

    loop parcurgere_sir


    sa_terminat:

    push dword [descriptor]
    call [fclose]
    add esp, 4

    push dword [descriptor_scriere]
    call [fclose]
    add esp, 4

    push dword nume_fisier1
    call [system]
    add esp, 4

    push 0
    call [exit]

segment data use32

    format db "%d", 0
    sir times 101 db 0
    afis_str db "%s", 10, 0
    nume_fisier db "fisier1.txt", 0
    nume_fisier1 db "fisier2.txt", 0
    mod_acces db "r", 0
    afis_char db "%c", 0
    descriptor dd 0
    descriptor_scriere dd 0
    nr_prop db 1
    ghilimele db '"', 0
    mod_scriere db "w", 0