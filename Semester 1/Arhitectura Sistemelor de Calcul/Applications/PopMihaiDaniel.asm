bits 32 
global start        

extern exit , scanf, printf, fprintf, fopen ,fread ,fclose            
import exit msvcrt.dll    
import scanf msvcrt.dll                        
import printf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
segment data use32 class=data
    fisier db "numere_egale.txt", 0
    accesmode db "r", 0
    descriptor dd -1
    
    formats db "%s",0
    formatc db "%c",0
    ok dd 0
    contor dd 0
    sir times 100 db 0
    rez times 100 db 0
    
    
segment code use32 class=code
    start:
        ;deschidem fisierul din care se citesc numerele
        push dword accesmode
        push dword fisier
        call [fopen]
        add esp,8
        ;conditie de iesire daca nu s-a deschis bine fisierul
        mov [descriptor],eax
        cmp eax,0
        je final
        ;citirea numerelor din fisier
        push dword [descriptor]
        push dword 100
        push dword 1
        push dword sir
        call [fread]
        add esp,4*4
        
        ;push dword sir
        ;push dword formats
        ;call [printf]
        ;add esp,8
        
        mov esi,sir
        ;mov edi,rez
        ;parcurgera sirul de numere citit
        repeta:
            lodsb
            ;cu ajutorul variabilei ok retinem prima cifra din numar
            cmp dword[ok],0
            jne next
            mov bl,al           ;in bl se retine prima cifra din nr
            mov dword[ok],1
            next:
            ;daca am ajuns la final se verifica si ultimul nr daca e bun
            cmp al,""
            je afisare
            ;cand ajungem la caracterul # verificam daca nr are prima si ultima cifra egale
            cmp al,"#"
            jne next2
            
            afisare:
            mov eax,0
            mov dword[ok],0
            dec esi
            dec esi
            lodsb
            cmp al,bl
            jne next3
            sub esi,[contor]
            mov ecx,[contor]
            repeta2:            ;parcurgerea numarului inca o data pentru afisare daca este bun
                push eax
                push ecx
                mov eax,0
                lodsb
                cmp al,"#"
                je nu
                push eax
                push dword formatc
                call [printf]
                add esp,8
                nu:
                pop ecx
                pop eax
            loop repeta2
            ;afisare spatiu intre numere
            pushad
            push dword " "
            push dword formatc
            call [printf]
            add esp,8
            popad
            ;resetarea variabilelor
            next3:
            inc esi
            mov dword[contor],0
            next2:
            ;numarul de cifre a unui numar
            inc dword[contor]
            ;conditie de oprire
            cmp al,""
            je final
        jmp repeta
        
        final:
        ;inchidea fisierului
        push dword[descriptor]
        call [fclose]
        add esp,4
        push    dword 0      
        call    [exit]      
