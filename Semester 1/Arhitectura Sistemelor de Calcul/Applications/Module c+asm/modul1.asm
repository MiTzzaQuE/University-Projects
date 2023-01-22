bits 32                         
segment code use32 public code
global _litere_mari

_litere_mari:
    push ebp
    mov ebp,esp
    mov esi, [ebp+8]
    mov edi, [ebp+12]
    cld
	repeta:
            lodsb
            cmp al,"A"
            jl next
            cmp al,"Z"
            jg next
            stosb
            next:
            cmp al,""
            je gata
        jmp repeta
    gata:
    mov esp,ebp
    pop ebp
	ret 