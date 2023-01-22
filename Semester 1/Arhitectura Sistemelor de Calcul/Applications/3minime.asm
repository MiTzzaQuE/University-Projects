bits 32 
global start        
extern exit , scanf, printf, fprintf, fopen        
import exit msvcrt.dll    
import scanf msvcrt.dll                          
import printf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll

segment data use32 class=data
    ; ...
    fisier db "numarMinim.txt", 0
    accesmode db "w+", 0
    descriptor dd -1
    curent dd 0
    format db "%c", 0
    format1 db "Numarul minim este %d%d%d", 0
    min1 dd -1
    min2 dd -1
    min3 dd -1

segment code use32 class=code
    start:
        citire:
            push dword curent
            push dword format
            call [scanf]
            add esp, 8
            
            mov eax, [curent]
        
            cmp eax, "!"
            je final
           
            sub eax, "0"
            
            test eax, 01h
            jz citire
            
            cmp eax, dword[min1]
            jae minim2
            
            mov dword[min1], eax
            jmp citire
            
            minim2:
            
            cmp eax, dword[min2]
            jae minim3
            
            mov dword[min2], eax
            jmp citire
            
            minim3:
            
            cmp eax, dword[min3]   
            jae citire
            
            mov dword[min3], eax
            jmp citire
            
        final:
        push dword accesmode
        push dword fisier
        call [fopen]
        add esp, 8
        
        mov [descriptor], eax
        
        push dword[min3]
        push dword[min2]
        push dword[min1]
        push dword format1
        push dword [descriptor]
        call [fprintf]
        add esp, 4*5
        
        push    dword 0      
        call    [exit]      
