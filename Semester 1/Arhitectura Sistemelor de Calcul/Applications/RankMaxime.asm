bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit ,printf
import exit msvcrt.dll
import printf msvcrt.dll 

segment data use32 class=data
    
    sir dd 1234a678h,12345678h,1ac3b47dh,0fedc9876h
    len equ ($-sir)/4
    maxim db 0
    rank db 0
    formatc db "%c",0
    formats db "%s",0
    format db "%d",0
    suma db 0
    
    rez times len db 0
    
segment code use32 class=code
    start: 
        mov esi,sir
        mov edi,rez
        mov ecx,len
        ;jecxz final
        
        repeta:
            mov byte[maxim],0
            ;mov byte[rank],0
            push ecx
            mov ecx,4
            
            determinare_maxim:
                lodsb
                cmp al,byte[maxim]
                jbe next
                mov byte[maxim],al
                mov byte[rank],cl
                next:
            loop determinare_maxim
            
            mov al,byte[maxim]
            add byte[suma],al
            mov al,byte[rank]
            
            add al,"0"
            stosb
            
            pop ecx
        
        loop repeta
        
        ;gata:
        
        pushad
        push dword rez
        push dword formats
        call[printf]
        add esp,8
        popad
        
        mov al,byte[suma]
        cbw
        cwde
        
        pushad
        push eax
        push dword format
        call[printf]
        add esp,8
        popad
        
        final:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program