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
   sir db 0
   nume_fisier db "lab8.2.txt",0
   mod_acces db "a+",0          ;APPEND+, daca fisierul nu exista se va crea
   descriptor_fis dd -1         ;variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
   mesaj db 10,13,"numarul de caractere este: %d",10,13,0
   mesaj2 db 10,13,"Merge",0
   format db "%d",0
   len equ 100
   text times len+1 db 0
   text2 times len+1 db 0
   numarCaractere dd 0
   minim dd "9999999999",0
   contor dd 0
   
segment code use32 class=code
    start:
    push dword mod_acces            ;
    push dword nume_fisier          ;
    call [fopen]                    ;
    add esp,4*2                     ;
      
    ;  verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
    mov [descriptor_fis], eax       ;
    cmp eax, 0                      ;
    je final                        ;

    
    ;repeta: 
    
        push dword[descriptor_fis]  ;
        push dword len              ;
        push dword 1                ;
        push dword text             ;
        call [fread]                ;
        add esp, 4*4                ;
        cmp eax,0                   ;
        je gata                     ;
        add [numarCaractere],eax    ;
        
    ;jmp repeta                      ;
        
    gata:                           ;
    
    push dword text                 ;
    call [printf]                   ;
    add esp, 4*1                    ;
        
    push dword[numarCaractere]      ;
    push dword mesaj                ;
    call [printf]                   ;
    add esp, 4*2                    ;
    
    mov esi, text                   ;
    mov edi, text2
    mov ecx, dword[numarCaractere]  ;
    jecxz final                     ;
    cld
    
    mov ebx,0
    
    repeta:
        lodsb
        cmp al,' '
        je next
        stosb
        add ebx,1
        jmp next2
        
        next:
        
        push dword text2;+contor
        call [printf]
        add esp, 4*1
        add [contor],ebx
        mov ebx,0
        next2:
        
    loop repeta
        
        
    push dword [descriptor_fis]     ;
    call [fclose]                   ;
    add esp, 4                      ;
        
    final:                          ;
     
    push    dword 0     
    call    [exit]      