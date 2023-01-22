bits 32 

global start        

extern exit , scanf, printf           
import exit msvcrt.dll    
import scanf msvcrt.dll                        
import printf msvcrt.dll

segment data use32 class=data
    ; ...
    sir dd 1234A678h,12785634h,1A4D3C2Bh
    len equ ($-sir)/4
    rez times len dd 0
    contor db 0
    format db "%d",0
    formatc db "%c",0
    formath db "%X",0
    suma db 0

segment code use32 class=code
    start:
        ; ...
        mov esi,sir
        mov edi,rez
        mov ecx,len
        jecxz final
        
        repeta:
            mov eax,0
            lodsw
            mov bl,ah
            lodsw
            mov al,bl
            stosw
            
            ;pushad
            ;push dword eax
            ;push dword formath
            ;call[printf]
            ;add esp,8
            ;popad
            
            mov byte[contor],0
            baza2:
                cmp ax,0
                je next
                shl ax,1
                jnc pas
                inc byte[contor]
                pas:
                jmp baza2
            next:
            mov bl,byte[contor]
            add byte[suma],bl
            
        loop repeta
            
        push dword [suma]
        push dword format
        call [printf]
        add esp,8
        
        final: 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
