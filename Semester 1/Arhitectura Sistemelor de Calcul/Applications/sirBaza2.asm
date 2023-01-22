bits 32 

global start        

extern exit , scanf, printf          
import exit msvcrt.dll    
import scanf msvcrt.dll                        
import printf msvcrt.dll


segment data use32 class=data
    ; ...
    sir dq 1110111b, 100000000b,0ABCD0002E7FCh,5
    len equ ($-sir)/8
    rez times len dd 0
    contor db 0
    format db "%x",0
    formatc db "%c",0
    unu db "1"
    zero db "0"
    ok db 0

segment code use32 class=code
    start:
        ; ...
        mov esi,sir
        mov edi,rez
        mov ecx,len
        
        repeta:
            lodsd
            push eax
            mov ebx,0
            mov byte[contor],0
            degree2:
                
                shl eax,1
                jc bit
                mov dl,[contor]
                cmp dl,3
                jb nu_e_bun
                inc ebx
                nu_e_bun:
                mov byte[contor],-1
                bit:
                inc byte[contor]
                cmp eax,0
                je next
                jmp degree2
                
            next:
            
            mov dl,[contor]
            cmp dl,3
            jb nu_e_bun2
            inc ebx
            nu_e_bun2:
            
            pop eax
            cmp ebx,2
            jb next2
            
            stosd
            push ecx
            mov byte[ok],0
            mov ecx,32
            baza2:
                shl eax,1
                jc unu1
                mov bl,[ok]
                cmp bl,0
                je gata1
                pushad
                push dword [zero]
                push dword formatc
                call [printf]
                add esp,8
                popad 
                jmp gata1
                unu1:
                mov byte[ok],1
                pushad
                push dword [unu]
                push dword formatc
                call [printf]
                add esp,8
                popad
                gata1:
            loop baza2
            pop ecx    
            next2:
            
            pushad
            push dword " "
            push dword formatc
            call[printf]
            add esp,8
            popad
            
            lodsd
            
            dec ecx
            cmp ecx,0
            je final
        jmp NEAR repeta
        
        final:
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
