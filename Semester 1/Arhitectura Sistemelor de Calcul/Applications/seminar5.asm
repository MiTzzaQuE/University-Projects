;Se dă un sir de caractere (definit in segmentul de date). Să se citească de la tastatură un caracter, să se determine numărul de apariţii al acelui caracter în şirul dat şi să se afişeze acel caracter împreună cu numărul de apariţii al acestuia.
bits 32
global start        

extern exit, printf, scanf        
import exit msvcrt.dll     
import printf msvcrt.dll     
import scanf msvcrt.dll      
                          
segment  data use32 class=data
    a dd 26 
    b db "Noiembrie", 0
    c dd 2020 
    d db "ASC",0
    text  db "Suntem in %d %s %d si avem seminar de %s", 0 
    
segment  code use32 class=code
    start:
     
        push dword d 
        push dword [c] 
        push dword b 
        push dword [a]
        push dword text
        call [printf] 
        add esp, 4*5 
        
        ; exit(0)
        push  dword 0       
        call  [exit]        