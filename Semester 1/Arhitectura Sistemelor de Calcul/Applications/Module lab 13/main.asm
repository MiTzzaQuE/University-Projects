;28.Se citeste de la tastatura un sir de caractere (litere mici si litere mari, cifre, caractere speciale, etc). Sa se formeze un sir nou doar cu literele mici si un sir nou doar cu literele mari. Sa se afiseze cele 2 siruri rezultate pe ecran.
bits 32

global start
extern exit, printf, scanf        
import exit msvcrt.dll     
import printf msvcrt.dll     
import scanf msvcrt.dll 

extern litere_mari
extern litere_mici

segment data use32 class=data
    format db "Dati sirul de caractere: ",0 ;mesaj
    format_s db "%s",0                      ;formatul pentru citire string caractere
    format_spatiu db 10,13,0                ;formatul pentru spatiu
    sir times 100 db 0                      ;sirul citit
    sir_mare times 100 db 0                 ;sirul cu litere mari
    sir_mic times 100 db 0                  ;sirul cu litere mici
    
segment code use32 class=code
    start:
        ;afisarea mesajului pentru citire
        push format
        call [printf]
        add esp, 4 
        ;citirea de la tastatura a unui sir de caractere
        push sir
        push format_s
        call [scanf]
        add esp, 4*2
        ;salvarea sirului sursa in esi, sirul destinatie in edi
        mov esi,sir
        mov edi,sir_mare
        ;apelarea funtiei de determinare a literelor mari
        call litere_mari
        ;afisarea pe ecran a sirului rezultat
        push sir_mare
        call [printf]
        add esp,4
        ;trecerea pe o linie noua 
        push format_spatiu
        call [printf]
        add esp,4
        ;salvarea sirului sursa in esi, sirul destinatie in edi
        mov esi,sir
        mov edi,sir_mic
        ;apelarea funtiei de determinare a literelor mici
        call litere_mici
        ;afisarea pe ecran a sirului rezultat
        push sir_mic
        call [printf]
        add esp,4
        
        push    dword 0      
        call    [exit]       
