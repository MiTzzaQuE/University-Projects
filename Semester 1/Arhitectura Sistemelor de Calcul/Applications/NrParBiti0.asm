bits 32 
global start        

extern exit, scanf, fprintf ,printf ,fopen         
import exit msvcrt.dll    
import scanf msvcrt.dll        
import fprintf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll

segment data use32 class=data
    ; ...
    curent dd 0
    format db "%d", 0
    format1 db "%c", 0
    fisie db "Baciu.txt", 0
    accesmode db "w", 0
    descriptor dd -1
    contor db 0

segment code use32 class=code
    start:
        ; ...
        
        push dword accesmode
        push dword fisie
        call [fopen]
        add esp, 8
        
        mov [descriptor], eax
        
        cmp eax, 0
        je final
        
        citire:
            push dword curent
            push dword format
            call [scanf]
            add esp, 8
            
            mov ebx, [curent]
            cmp ebx, 0
            je final
            
            cmp ebx, 0
            cmp ebx, 0
            jl aici
            
            mov ecx, 32
            mov byte[contor], 0
            nrzero:
                shr ebx, 1
                jc sf
                add byte[contor], 1
                sf:
            loop nrzero
            
            mov dl, [contor]
            test dl, 01h
            jnz aici
            
            push dword [curent]
            push dword format
            push dword [descriptor]
            call [fprintf]
            add esp, 12
            
            push dword " "
            push dword format1
            push dword [descriptor]
            call [fprintf]
            add esp, 12
            
            aici:
            jmp citire
 
        final:
        push    dword 0    
        call    [exit]      
