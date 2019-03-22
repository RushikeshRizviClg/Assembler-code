;Program 3: Write an ALP for Finding factorial of a given number
;Code:
.model small
.data
    num dw 04h                          
.code
Start: 
        mov ax, @data       
        mov ds, ax

        mov ax, 01          
        mov bx, num                                 
        call    fact            
        mov di, ax                  
                mov bp, 2                   
        mov bx, dx          
up1:    mov ch, 04h             
        mov cl, 04h             
l2:     rol bx, cl           
        mov dl, bl              
        and     dl, 0fH             
        cmp dl, 09              
        jbe     l4
        add     dl, 07              
l4:     add     dl, 30H
        mov ah, 02              
        int     21H
        dec     ch              
        jnz     l2
        mov bx, di              
        dec     bp              
        cmp bp, 00  
        jnz     up1
    mov ah, 4ch
    int 21h
fact proc near                      
    cmp bx,01h              
    jz  l11             
l12:    mul     bx              
    dec     bx              
    cmp bx, 01              
    jne l12
    ret
l11:    mov ax, 01
    ret             
    fact endp           
end start                   
end





