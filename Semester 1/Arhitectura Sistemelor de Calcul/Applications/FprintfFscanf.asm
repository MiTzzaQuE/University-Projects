;4.Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de cifre impare si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.

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
   nume_fisier db "lab8.txt",0  ; definim numele fisierului din care citim
   mod_acces db "r",0           ; READ, daca fisierul nu exista se va crea
   descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
   mesaj db "Numarul de cifre impare din fisier este: %d",0;mesajul care trebuie afisat impreuna cu rezultatul
   len equ 100                  ; definirea unei constante care reprezinta lungimea maxima a sirului
   text times len+1 db 0        ; alocarea in memorie a unui numar 'len+1' de 0-uri
   numarCaractere dd 0          ; contor in care retinem lungimea sirului
   mesaj2 db 10,13,"numarul de caractere este: %d",0;mesaj pentru numarul de caractere
   mesaj3 db 10,13,"numarul de cifre impare din fisier este: %d",0;mesaj pentru numarul cifrelor pare din fisier
   contor dd 0                  ; contor care retine cate cifre impare exista in text
segment code use32 class=code
    start:
    push dword mod_acces        ;punem pe stiva adresa modului de acces cu care vrem sa lucram (read)
    push dword nume_fisier      ;se pune pe stiva adresa numelui fisierului
    call [fopen]                ;apelarea functiei de deschidere a fisierului
    add esp,4*2                 ;eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
      
    ;  verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
    mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
    cmp eax, 0                  ; se compara valoarea din ecx cu 0
    je final                    ; daca e 0 sare la finalui programului
    
    repeta:                     ;eticheta de inceput
        ; citim textul in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, len, descriptor_fis)
        push dword[descriptor_fis]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4            ; dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
        
        cmp eax,0               ;daca nu s-a citit nimic se sare la final
        je gata
        add [numarCaractere],eax;in variabila numarCaractere retinem lungimea textului citit
        
    jmp repeta                  ;saltul la eticheta repeta
        
    gata:                       ;iesirea din functia de citire
    
    push dword text             ;se pune pe stiva adresa textului citit
    call [printf]               ;apelarea functiei de afisare pe ecran
    add esp, 4*1                ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 1 = nr de parametri
        
    push dword[numarCaractere]  ;se pune pe stiva, iar apoi afisata pe ecran valoarea in care retinem lungimea textului citit
    push dword mesaj2
    call [printf]
    add esp, 4*2
    
    mov esi, text               ;punem in registrul esi adresa textului citit
    mov ecx, dword[numarCaractere];punem in ecx lungimea textului
    jecxz final                 ;daca lungimea este 0 se sare la final
    
    repeta1:                    ;parcurgerea textului
        lodsb                   ;se incarca in memorie/al un byte
        cmp al,'0'              ;se verifica daca e cifra
        jl next
        cmp al,'9'
        jg next
        test al,01h             ;se verifica paritatea cifrei
        je next ;               !!!!!!!!!!! vream explicatii
        add dword[contor],1     ;daca e impar crestem valoarea contorului cu 1
        
        next:                   ;eticheta la care se sare daca caracterul incarcat in memorie nu e cifra
        loop repeta1            ;repetarea buclei
                
    push dword[contor]          ;se pune pe stiva valoarea contorului
    push dword mesaj3           ;se pune pe stiva adresa mesajului 3 pentru afisare
    call [printf]               ;se apeleaza functia de afisare pe ecran
    add esp, 4*2                ;eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
    push dword [descriptor_fis] ;punem pe stiva valoare descriptorului pentru a putea inchide fisierul
    call [fclose]
    add esp, 4
            
    final:                      ;eticheta la care se sare in caz in care fisierul este gol
     
    push  dword 0               ; punem pe stiva parametrul pentru exit
    call  [exit]                ; apelam exit pentru a incheia programul