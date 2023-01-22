bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit ,printf
import exit msvcrt.dll
import printf msvcrt.dll 

segment data use32 class=data

 sir2 times 20 dd 0
 format db "%c",0
 format2 db "%d",0
 sir1 DD 1245AB36h, 23456789h, 1212F1EEh
 sir3 times 100 db 0
segment code use32 class=code
    start: 
        mov esi,sir1
        mov edi,sir2
        repeta:
            lodsd
            cmp eax,0
            je final
            cmp ah,0
            jge pas
            mov al,ah
            stosb
            pas:
        jmp repeta


        final:

        mov esi,sir2
        rep2:
            lodsb
            cmp al,0
            je finalfinal

            mov ecx,8
            baza2:
                shl al,1
                jnc paspas
                pushad
                mov ebx,0
                mov bl,'1'
 
                push ebx
                push format
                call [printf]
                add esp,8
                popad

                jmp aici1
                paspas:
                pushad
                mov ebx,0
                mov bl,'0'
 
                push ebx
                push format
                call [printf]
                add esp,8
                popad
                aici1:
            loop baza2
            
            pushad
            push dword " "
            push dword format
            call[printf]
            add esp,8
            popad
            
            jmp rep2
 
        finalfinal:
 
        mov esi,sir2
        reprep:
            lodsb
            cmp al,0
            je gata_examen

            cbw
            cwde
            mov ebx,eax
            pushad 
            push dword ebx
            push dword format2
            call [printf]
            add esp,8
            popad
            
        jmp reprep
        
        gata_examen:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program