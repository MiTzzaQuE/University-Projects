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
        ; ...
        s dd 0,-1,-2,-4,-8
        s1 db 0ffh,-2
        s2 dw 0ff00h,-2
        len equ $-$$
    
segment code use32 class=code
    start:
        ; ...
        mov al,-1
        cmp al,0
        je da
        jle nu
        
        da:
        mov al,1
        nu:
        mov al,2
        
        
        cld
        push ax
        mov ax,[esp+2]
        stosw
        lea edi,[edi-2]
        add esp,4
        
        push word 6Ah
        push word 12h
        pop eax
        
        mov eax,16>>4
        mov eax,len
        
        lea eax,[eax*2+10]
        
        push dword 0
        push dword -1
        push dword -2
        push dword -4
        push dword -8
        
        pop eax
        neg ax
        
        mov esi,s1
        mov edi,s2
        movsb
        inc edi
        scasw
        jg isGreater
        jl isLess
        
        isGreater:
            jmp final
        isLess:
        ;...
        final:
        push    dword 0      
        call    [exit]     