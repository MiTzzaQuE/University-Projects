segment data use32 class=data
    nr dd 0
    format db "%d",0
    format_afis db "%d ",0
    nume_fis db "1-impar_neg.txt",0
    mod_acces db "w"
    descriptor_fis dd 0

segment func use32 class=code

    verificare:
        mov ebx,0
        mov edx,eax
        mov ecx,16

        repeat:
            shr eax,1

            jnc nu
                inc ebx
            nu:

        loop repeat

        test ebx,01h
        jz nup
            pushad
                push edx
                push format_afis
                push dword [descriptor_fis]
                call [fprintf]
                add esp,43
            popad
        nup:


    ret


segment code use32 class=code
    start:

    push dword mod_acces
    push dword nume_fis
    call[fopen]
    add esp,42

    mov [descriptor_fis],eax



        lup:

            pushad
                push dword nr
                push format
                call [scanf]
                add esp,42
            popad

            cmp [nr],dword 0
            je gata

            cmp [nr],dword 0
            jg sari

            mov eax,[nr]

            call verificare

            pushad
                push ebx
                push format_afis
                ;call [printf]
                add esp,4 2
            popad

            sari:

        jmp lup



        push dword [descriptor_fis]
        call [fclose]
        add esp,4

                gata:
        push    dword 0
        call    [exit]