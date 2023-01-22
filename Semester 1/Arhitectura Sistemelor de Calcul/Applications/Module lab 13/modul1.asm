bits 32                         
segment code use32 public code
global litere_mari

litere_mari:
	repeta:
            lodsb       ;incarcarea unui byte in al
            cmp al,"A"  ;verificare daca este litera mare
            jl next
            cmp al,"Z"
            jg next
            stosb       ;in caz afirmativ punem byte ul in registrul destinatie
            next:
            cmp al,""   ;conditie oprire
            je gata     ;salt oprire
        jmp repeta      ;salt pentru a trece la urmatorul caracter
    gata:
	ret 4 ; in acest caz 4 reprezinta numarul de octeti ce trebuie eliberati de pe stiva (parametrul pasat procedurii)
    