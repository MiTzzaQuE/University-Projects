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
    
    
    accesmode db "r+", 0
    descriptor dd -1
    
    fisier_output db "output.txt",0
    accesmode2 db "w+",0
    descriptor2 dd -1
    formats db "%s",0
    formatc db "%c",0
    format db "%x",0
    n dd 0
    nr dd 0
    
    
    contor_c dd 0
    contor_nr dd 0
    fisier_input times 100 db 0
    rez times 100 db 0
    sir db 0
segment code use32 class=code
    start:
        push dword fisier_input
        push dword formats
        call [scanf]
        add esp, 8
        
        push dword n
        push dword format
        call [scanf]
        add esp,8
        
        push dword accesmode
        push dword fisier_input
        call [fopen]
        add esp,8
        
        mov [descriptor],eax
        cmp eax,0
        je final
        
        push dword [descriptor]
        push dword 100
        push dword 1
        push dword sir
        call [fread]
        add esp,4*4
        
        ;push dword sir
        ;push dword formats
        ;call [printf]
        ;add esp,8
        
        mov esi,sir
        mov edi,rez
        mov ecx,[n]
        
        repeta:
            lodsb
            cmp al,""
            je final
            
            cmp al," "
            jne next
            
            aici:
            
            cmp ecx,[contor_c]
            jne afisare
            
            pushad
            push dword rez
            push dword formats
            call [printf]
            add esp,8
            
            push dword " "
            push dword formatc
            call [printf]
            add esp,8
            popad
            afisare:
            
            
            ;mov edi,rez
            mov dword[contor_c],0
            mov dword[nr],0
            jmp repeta
            
            next:
            
            cmp al,0Ah
            je aici
            
            mov ebx,[nr]
            stosb
            cmp eax,"a"
            jne here1
            inc dword [nr]
            here1:
            cmp eax,"e"
            jne here2
            inc dword[nr]
            here2:
            cmp eax,"i"
            jne here3
            inc dword [nr]
            here3:
            cmp eax,"o"
            jne here4
            inc dword [nr]
            here4:
            cmp eax,"u"
            jne here5
            inc dword [nr]
            here5:
            cmp ebx,[nr]
            jne vocala
            inc dword[contor_c]
            vocala:
        
        jmp repeta
        
        
        final:
        
        
        push    dword 0      
        call    [exit]      
