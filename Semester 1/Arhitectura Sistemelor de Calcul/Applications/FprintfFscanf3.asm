;27.Se da un fisier text. Fisierul contine numere (in baza 10) separate prin spatii. Sa se citeasca continutul acestui fisier, sa se determine minimul numerelor citite si sa se scrie rezultatul la sfarsitul fisierului.

bits 32 

global start        

extern exit, fopen, fprintf, fclose, fread
extern scanf
import scanf msvcrt.dll
extern printf
import printf msvcrt.dll
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll

segment data use32 class=data
    fisier db "file27.txt", 0       ; definim numele fisierului din care citim
    acces_mode db "a+", 0           ; APPEND+, modul in care lucram cu fisierul
    descriptor dd 0                 ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    afisare db "Numarul minim din fisier este %d", 0;mesajul care trebuie afisat impreuna cu rezultatul
    minim dd 255                    ;definim o variabila in care retinem minimul 
    curent db 0                     ;definim o variabila in care retinem numarul curent
    sir resb 100                    ;rezervam in memorie 100 byte-uri pentru sir
    len equ 100                     ;definim o constanta cu valoarea 100/lungimea maxima a unui text citit
    ten db 10                       ;definim o variabila 10 cu care cream numere in baza 10
    
segment code use32 class=code
    start:
        push dword acces_mode       ;punem pe stiva adresa modului de acces cu care vrem sa lucram (append)
        push dword fisier           ;se pune pe stiva adresa numelui fisierului
        call [fopen]                ;apelarea functiei de deschidere a fisierului
        add esp, 4*2                ;eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        ;  verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        mov [descriptor], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        cmp eax, 0                  ; se compara valoarea din ecx cu 0
        je final                    ; daca e 0 sare la finalui programului
        
        
        ; citim textul in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, len, descriptor_fis)
        push dword[descriptor]
        push dword len
        push dword 1
        push dword sir
        call [fread]
        add esp, 4*4                ; dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
        
        mov esi, 0                  ;punem in esi adresa de inceput a sirului 
        mov ecx, len                ;se pune in ecx lungimea sirului
        
        jecxz final                 ;daca ecx = 0 se sare la final
        
        repeta:                     ;inceputul buclei
            mov al, [sir+esi]       ;se pune in al valoarea curenta din sir
            cmp al, ' '             ;se verifica daca e spatiu sau nu
            je sf
            cmp al, 0               ;conditie de iesire din bucla
            je sf4
            mov bl, al              ;retinem in al adresa elementului curent
            sub bl, '0'             ;convertim din caracter in cifra
            mov al, [curent]        ;in al se pune valoarea numarului curent pentru a-l putea inmulti
            mul byte[ten]           ;se inmulteste cu 10/cream un numar nou
            add al, bl              ;adunam la rezultat cifra curenta 
            mov [curent], al        ;se pune in variabila curent rezultatul obtinut
            jmp sf2                 ;sare la eticheta sf2
            
            sf:
            mov bl, [curent]        ;in bl este pus numarul curent/creat
            mov byte[curent], 0     ;se reinitializeaza variabila curent
            cmp [minim], bl         ;compara numarul curent/creat cu minimul existent
            jb sf2                  ;daca nu mai mic decat minimul sare la eticheta sf2
            mov [minim], bl         ;altfel actualizam minimul
            
            sf2:
            inc esi                 ;incrementam registrul esi pentru a trece la urmatorul element/byte din sir
        loop repeta                 ;repetarea buclei
        sf4:                         ;eticheta de iesire din bucla
        mov bl, [curent]            ;verificarea cazului special in care ultimul numar poate fi mai mic decat minimul
        cmp [minim], bl
        jb sf3    
        mov [minim], bl
        sf3:
        
        push dword [minim]          ;punem pe stiva valoarea variabilei minim
        ;push dword [descriptor]
        push dword afisare          ;punem pe stiva adresa textului pentru afisare
        call [printf]               ;se apeleaza functia de afisare pe ecran
        add esp, 4*2                ;eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        ;push dword [descriptor]
        ;call [fclose]
        ;add esp, 4
        
        final:
        
        ; exit(0)
        push    dword 0             ; push the parameter for exit onto the stack
        call    [exit]              ; call exit to terminate the program
