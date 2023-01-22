bits 32                         
segment code use32 public code
global litere_mici

litere_mici:
	repeta1:
            lodsb       ;incarcarea unui byte in al
            cmp al,"a"  ;verificare daca este litera mica
            jl next1
            cmp al,"z"
            jg next1
            stosb       ;in caz afirmativ punem byte ul in registrul destinatie
            next1:
            cmp al,""   ;conditie oprire
            je gata1    ;salt oprire
        jmp repeta1     ;salt pentru a trece la urmatorul caracter
    gata1:
	ret 4 ; in acest caz 4 reprezinta numarul de octeti ce trebuie eliberati de pe stiva (parametrul pasat procedurii)
    