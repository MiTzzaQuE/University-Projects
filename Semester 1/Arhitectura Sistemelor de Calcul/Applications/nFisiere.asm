bits 32 

global start        

extern exit,scanf,fprintf,printf,fopen,fclose               
import scanf msvcrt.dll    
import fprintf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll
import fopen msvcrt.dll 
import fclose msvcrt.dll

segment data use32 class=data
    ; ...
    n db 0
    format db "%d",0
    format1 db "%s",0
    format2 db "%c",0
    string db "asacevanuseface",0
    i db 1
    caracter db '0'
    mod_acces db "w+",0
    descriptor dd -1
    nume_fisier db "output- .txt",0
    rez resb 12
   
segment code use32 class=code
    start:
        ; ...
        push dword n
        push dword format
        call [scanf]
        add esp,8
        
        generare:
            add byte[caracter],1
            mov esi,nume_fisier
            mov edi, rez
            mov ecx,12
            formare:
                lodsb
                cmp al,' '
                jne sf
                mov al,[caracter]
                sf:
                stosb
            loop formare
            
            push dword rez
            push dword format1
            call [printf]
            add esp,8
            
            creat:
                push dword mod_acces
                push dword rez
                call [fopen]
                add esp,8
                
                mov [descriptor],eax
                cmp eax,0
                je final
                
            mov ecx,0
            mov esi,string
            mov cl,[i]
            cld
            continut:
                mov eax,0
                pushad
                lodsb
                push eax
                push dword format2
                push dword [descriptor]
                call [fprintf]
                add esp,12
                popad
                inc esi
            loop continut
            
            add byte[i],1
            dec byte[n]
            
            cmp byte[n],0
            je final
            
        jmp generare    
        
        final:
        push    dword 0      
        call    [exit]       
