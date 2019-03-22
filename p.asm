Code:
.model small
.data
num1 dw 0180
num2 dw 0060
GCD DW ?
.code
start:
    mov     ax, @data       ; initialise DS
    mov     ds, ax      
   
    MOV AX,88h
    mov     bx, ax

    mov     ch, 04h         ; Count of digits to be displayed
    mov     cl, 04h         ; Count to roll by 4 bits   
l2: rol     bx, cl          ; roll bl so that msb comes to lsb 
    mov     dl, bl          ; load dl with data  to be displayed
    and     dl, 0fH         ; get only lsb
    cmp     dl, 09          ; check if digit is 0-9 or letter A-F
    jbe     l4
    add     dl, 07          ; if letter add 37H else only add  30H
l4: add     dl, 30H
    mov     ah, 02          ; INT 21H (Display character)
    int     21H
    dec     ch          ; Decrement Count
    jnz     l2
    dec     dh
    cmp     dh, 0
    mov     ah, 4ch         ; Terminate Program
    int     21h
end start
end