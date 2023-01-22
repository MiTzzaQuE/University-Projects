;27.Se dă un sir de caractere (definit in segmentul de date). Să se citească de la tastatură un caracter, să se determine numărul de apariţii al acelui caracter în şirul dat şi să se afişeze acel caracter împreună cu numărul de apariţii al acestuia.

bits 32

global start        

extern exit, printf, scanf        
import exit msvcrt.dll     
import printf msvcrt.dll     
import scanf msvcrt.dll      
                          
segment  data use32 class=data
    sir db "alabal  apor  toca la",0 ;declararea sirului sir
    len equ $-sir               ;lungimea sirului sir
    contor dd 0                 ;contorul in care retinem numarul de aparitii a caracterului citit
    caracter db 0               ;caracterul citit de la tastatură
    format db "Dati caracterul: ",0;formatul pentru citire
    format_c db "%c",0          ;formatul unui caracte de tip char
    format_nr db "%d",0         ;formatul pentru un numar in baza 10 
    mesaj db "Caracterul %c apare in text de %d ori",0;mesajul care se afiseaza pe ecran la finalul problemei
    
segment  code use32 class=code
    start:
     
        push format             ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf]           ; apelam functia printf pentru afisare     
        add esp, 4              ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 1 = nr de parametri 
        
        push caracter           ;  punem pe stiva adresa caracterului c
        push format_c           ; punem pe stiva adresa string-ului
        call [scanf]            ; apelam functia scanf pentru citire
        add esp, 4*2            ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        mov esi, sir            ; punem in registrul esi adresa sirului sir
        mov ecx, len            ; ecx = lungimea sirului sir
        mov ebx, dword[contor]  ; initializam un registru cu 0, contorul
        
        repeta:                 ; inceputul buclei
            lodsb               ; incarcarea in memorie/al a unui byte
            cmp al,[caracter]   ; comparam byte-ul incarcat in al cu valoarea caracterului
            jne altfel          ; daca nu sunt egale trece la urmatorul element din sir
            inc ebx             ; daca caracterul apare in sir, incrementam registrul ebx
                
            altfel:             ; eticheta la care sare daca caracterul nu este egal cu pozitia curenta din sir
            loop repeta         ; reluarea buclei cat timp ecx != 0
            
        push ebx                ; punem pe stiva adresa registrului ebx
        push dword[caracter]    ; punem pe stiva valoarea din variabila caracter(caracterul care trebuia verificat)
        push mesaj              ; pe stiva se pune adresa mesajului
        call [printf]           ; apelam functia printf pentru afisare
        add esp, 4*3            ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 3 = nr de parametri
        
        push  dword 0           ; punem pe stiva parametrul pentru exit
        call  [exit]            ; apelam exit pentru a incheia programul