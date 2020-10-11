section .bss
    a resb 1            ;Variable a

section .data
    crlf db 13,10
    crlflen equ $ - crlf

section .text

global _start

_start:
        mov eax,0
        mov [a],eax     ;A blir satt til 0.
        mov ecx,0       ;Teller i.
        call nylinje    
lokke:  cmp ecx,10      ;Starten av løkken
        jb increment    
        call decrement  
lm:     cmp ecx,19      
        inc ecx         
        jb lokke         
        call print      
        call nylinje
        mov eax,1
        mov ebx,0       
        int 0x80        ;Programmet avsluttes

;Øker A       
increment:
    mov eax,[a]
    inc eax
    mov [a],eax
    jmp lm  

;Minker A
decrement:
    mov eax,[a]
    dec eax
    mov [a],eax
    jmp lm   

print:
    push ebp
    mov ebp,esp
    mov edx,1
    mov ecx,[a]
    add ecx,'0'
    mov [a],ecx
    mov ecx,a
    mov ebx,1
    mov eax,4
    int 0x80
    pop ebp
    ret

nylinje:
    push eax
    push ebx
    push ecx
    push edx
    mov edx,crlflen
    mov ecx,crlf
    mov ebx,1
    mov eax,4
    int 0x80
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
