bits 32 
global start        

extern exit              
import exit msvcrt.dll  
extern scanf              
import scanf msvcrt.dll  
extern fopen              
import fopen msvcrt.dll 
extern fclose              
import fclose msvcrt.dll 
extern fprintf              
import fprintf msvcrt.dll 
extern printf              
import printf msvcrt.dll 
segment data use32 class=data
    nr dd 0
    fisier db "fisierexamen.txt",0
    acces db "w",0
    format db "%d",0
    spatiu db " ",0
    descriptor dd 0
    contor dd 0
segment code use32 class=code
    start:
        push dword acces
       push dword fisier
       call [fopen]
       add esp,4*2
       
       mov [descriptor],eax
       cmp eax,0
       je final
       
       repeta:
       pushad
       push dword nr
       push dword format
       call [scanf]
       add esp,4*2
       popad
       
       mov eax,dword[nr]
       cmp eax,dword 0
       je gata
       
       mov edx,eax
       cmp eax,1
       jle next

       mov dword [contor],0
       do:
       inc dword [contor]
       shl eax,1
       jc am_gasit_1
       jmp do
       
       am_gasit_1:
       mov ecx,32
       sub ecx,[contor]
       mov ebx,0
       
       cautam_0:
       shl eax,1
       jc peste
       inc ebx
       peste:
       loop cautam_0
       
       ;push dword ebx
       ;push dword format
       ;call [printf]
       ;add esp,4*2
       
       cmp ebx,01h
       jz nu_afisam
       cmp ebx,0
       je nu_afisam
       push dword edx
       push dword format
       push dword [descriptor]
       call [fprintf]
       add esp,4*3
       push dword spatiu
       push dword [descriptor]
       call [fprintf]
       add esp,4*2
       
       nu_afisam:
       
       
       
       
       next:
       jmp repeta
       gata:
       push dword [descriptor]
       call [fclose]
       add esp,4
       final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
