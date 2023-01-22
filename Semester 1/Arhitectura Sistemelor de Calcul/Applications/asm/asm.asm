bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sirS dd 44332211h, 88776655h, 87654321h, 12345678h ;
    l equ ($-sirS)/4 ;lung = nr de  elemente
    sirD times l db 0 ;rezervarea unui spatiu de lungime l pentru sirul destinatie  d si initializarea acestuia ; 33h, 77h, 65h, 34h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, sirS+4*l-1 ;pozitionarea pe ultimul dword al sirului, octetul de rang 3
        mov edi, sirD+l-1
        
        mov ecx, 1
        jecxz Sfarsit
        
        ;varianta 1
        repeta:
            lodsb
            lodsb
            stosb
            lodsw
            loop repeta
        Sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
