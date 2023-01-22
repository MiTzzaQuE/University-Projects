bits 32                         
segment code use32 public code
global _litere_mici

_litere_mici:
    push ebp
    mov ebp,esp
    mov esi, [ebp+8]
    mov edi, [ebp+12]
    cld
	repeta1:
            lodsb
            cmp al,"a"
            jl next1
            cmp al,"z"
            jg next1
            stosb
            next1:
            cmp al,""
            je gata1
        jmp repeta1
    gata1:
    mov esp,ebp
    pop ebp
	ret