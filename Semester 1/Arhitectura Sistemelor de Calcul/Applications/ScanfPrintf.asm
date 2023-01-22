;4.Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze in urmatorul format: "<a> * <b> = <result>"
;Exemplu: "2 * 4 = 8"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.

bits 32

global start        

extern exit, printf, scanf            
import exit msvcrt.dll     
import printf msvcrt.dll     
import scanf msvcrt.dll      
                          
segment  data use32 class=data
    a dw 0                 ;definim variabila word a
    b dw 0                 ;definim variabila word b
    format db "%d", 0  ; %d <=> un numar decimal (baza 10)
	format1  db "a = ", 0  ;mesaj pentru selectarea numarului a
    format2  db "b = ", 0  ;mesaj pentru selectarea numarului b 
    message2  db "Produsul numerelor este: %d * %d = %d", 0 ;mesaj pentrua afisarea produsului numerelor a si b 
    
segment  code use32 class=code
    start:
                                               
        ; vom apela scanf(format, n) => se va citi un numar in variabila n
        ; punem parametrii pe stiva de la dreapta la stanga
        
        push dword format1  ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf]       ; apelam functia printf pentru afisare      
        add esp, 4*1        ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 1 = nr de parametri  
        
        push  dword a       ;punem pe stiva adresa variabilei a       
        push  dword format  ;punem pe stiva adresa string-ului
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2     ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        push dword format2  ; ! pe stiva se pune adresa string-ului, nu valoarea
        call [printf]       ; apelam functia printf pentru afisare      
        add esp, 4*1        ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 1 = nr de parametri

        push  dword b       ;punem pe stiva adresa variabilei a 
        push  dword format  ;punem pe stiva adresa string-ului
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2     ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        mov ax, word[a]     ;se pune in ax word-ul a
        imul word[b]        ;se face inmultirea cu semn a variabilelor a si b
        
        push dx             ;se pune in stiva partea high din rezultat
        push ax             ;se pune in stiva partea low din rezultat
        pop ebx             ;se ia de pe stiva intr-un dublu cuvant rezultatul din dx:ax
        
        mov ax,[a]          ;punem in ax valoarea variabilei a
        cwde                ;convertire cu semn de la cuvant la dublucuvant
        mov ecx,eax         ;salvam in ecx rezultatul
        
        mov ax, [b]         ;punem in ax valoarea variabilei b
        cwde                ;convertire cu semn de la cuvant la dublucuvant
        
        push  dword ebx     ;punem pe stiva valoarea rezultatului inmultirii
        push  dword eax     ;punem pe stiva valoarea variabilei b
        push  dword ecx     ;punem pe stiva valoarea variabilei a
        push  dword message2;punem pe stiva adresa mesajului de tip string
        call  [printf]      ; apelam functia printf pentru afisare   
        add  esp,4*4        ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 4 = nr de parametri
        
        ; exit(0)
        push  dword 0       ; punem pe stiva parametrul pentru exit
        call  [exit]        ; apelam exit pentru a incheia programul