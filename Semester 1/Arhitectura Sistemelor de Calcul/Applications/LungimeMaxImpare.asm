bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit , printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir db 12,13,10b,7,-3,100, 101b, 11h, 27, -1, 4, 1, 3, 5, 7, 9, 11
    lngsir equ $-sir
    secvmax resb 100
    lungmax db 0
    cont db 0
    format db "%d%c", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir
        mov ecx, lngsir
        
        parcurgere:
            lodsb
            test al, 01h
            jz verifica
            
            inc byte[cont]
            jmp sfarsit
            verifica:
                mov eax, 0
                mov al, byte[cont]
                cmp al, byte[lungmax]
                jbe sfarsit
                
                mov byte[lungmax], al
                sub esi, eax
                dec esi
                
                push ecx
                mov ecx, 0
                mov edi, secvmax
                mov cl, al
                stocheaza:
                    movsb
                loop stocheaza
                pop ecx
                inc esi
                mov byte[cont], 0
                
            sfarsit:
        loop parcurgere
        
        mov eax, 0
        mov al, byte[cont]
        cmp al, byte[lungmax]
        jbe sfarsit1
                
        mov byte[lungmax], al
        sub esi, eax
                
        push ecx
        mov ecx, 0
        mov edi, secvmax
        mov cl, al
        stocheaza1:
            movsb
        loop stocheaza1
        pop ecx
        
        sfarsit1:
        
        mov ecx, 0
        mov cl, byte[lungmax]
        mov esi, secvmax
        afisare:
            mov eax, 0
            lodsb
            push ecx
            push dword " "
            push eax            
            push dword format
            call [printf]
            add esp, 12            
            pop ecx
        loop afisare
        
        final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
