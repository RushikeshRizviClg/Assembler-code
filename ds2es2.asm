.model small
.data
	a dB 10h,11h,12h,13h,14h,15h,16h,17h,18h,19h
	b dB 10 dup(?)
.code
start:
	mov ax,@data
	mov ds,ax
	mov es,ax
	mov si,offset a
	mov di,offset b
	mov cx,000Ah
	cld
rep	movsb 
	
	mov bh,0Ah
	mov di,offset b    ;mov di to start position
l3:	mov bl,[di]
	mov ch,02h	; 10 two no. print
	mov cl,04h

l2:	rol bl,cl
	mov dl,bl
	and dl,0Fh	; masking higher msb i.e 35 give 5
	cmp dl,09h	
	jbe l1
	add dl,07h
l1:	add dl,30h
	
    	mov 	ah, 02	; INT 21H 
			; (Display character)
      	int 	21H
      	dec 	ch	; Decrement Count
      	jnz 	l2


	mov dl,' '		; print space	
	mov 	ah, 02	; INT 21H 
			; (Display character)
      	int 	21H	

	inc di
	dec bh
	jnz l3						
	mov 	ah, 4Ch
	int 	21h
end start 
end
 























