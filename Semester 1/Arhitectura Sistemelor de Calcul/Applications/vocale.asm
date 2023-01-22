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
    ; ...
    fisier db "vocale.txt", 0
    accesmode db "r", 0
    descriptor dd -1
    n dd 0
    nr dd 0
    format db "%c", 0
    formatnr db "%d",0
    cons times 100 db 0

segment code use32 class=code
    start:
       
       push dword accesmode
       push dword fisier
       call [fopen]
       add esp,4*2
       
       mov [descriptor],eax
       cmp eax,0
       je final
       mov edi,cons
       
       repeta:
       
       push dword [descriptor]
       push 1
       push 1
       push dword nr
       call [fread]
       add esp,4*4
       
            mov ebx,dword [n]
            mov eax, [nr]
        
            cmp eax, "!"
            je final
            
            cmp eax,"a"
            jne here1
            inc dword [n]
            here1:
            cmp eax,"e"
            jne here2
            inc dword[n]
            here2:
            cmp eax,"i"
            jne here3
            inc dword [n]
            here3:
            cmp eax,"o"
            jne here4
            inc dword [n]
            here4:
            cmp eax,"u"
            jne here5
            inc dword [n]
            here5:
            cmp ebx,[n]
            jne vocala
            stosb
            
            vocala:
            jmp repeta
            
        final:
        push dword [n]
        push formatnr
        call [printf]
        add esp,8
        
        mov ecx,dword [n]
        mov esi,cons
        repeta2:
        mov eax,0
        lodsb
        
        push ecx
        push dword eax
        push dword format
        call [printf]
        add esp,8
        pop ecx
        
        loop repeta2
        push dword[descriptor]
        call [fclose]
        add esp,4
        
        push    dword 0      
        call    [exit]      
