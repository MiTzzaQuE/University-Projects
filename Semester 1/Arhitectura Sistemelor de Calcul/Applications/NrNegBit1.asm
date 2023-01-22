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
    curent dd 0
    format db "%d",0
    formatc db "%c",0
    nume_fisier db "1-impar_neg.txt",0
    mod_acces db "w+",0
    descriptor dd -1
    contor db 0

segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp,8
        
        mov [descriptor],eax
        cmp eax,0
        je final
        
        citire:
            push dword curent
            push dword format
            call [scanf]
            add esp,8
            
            mov eax, [curent]
            cmp eax,0
            je final
            
            cmp eax,0
            jg citire
            
            mov ecx, 32
            mov byte[contor],0
            nrone:
                shr eax,1
                jnc sf
                add byte[contor],1
                sf:
            loop nrone
            
            mov bl,byte[contor]
            test bl,01h
            jz next
            
            push dword [curent]
            push dword format
            push dword [descriptor]
            call [fprintf]
            add esp,12
            
            push dword " "
            push dword formatc
            push dword [descriptor]
            call [fprintf]
            add esp,12
            
            next:
        jmp citire
        
        final:
        
        push    dword 0      
        call    [exit]       
