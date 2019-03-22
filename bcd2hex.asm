.model small
.stack 100
.data 
a dd 00065535h
.code
start:
	mov 	ax, @data	; Intialize data segment
	mov 	ds, ax
	mov 	ax, word ptr a+2	; checking msb no
	mov 	bx, 0000h	; intialize hex result
l11:	cmp 	ax, 0	; cmp ax
	jz 	l10
	dec 	ax	; if ax=1 then it 
			; means no>10000  
	add 	bx, 10000	; so add 10000 to bx
	jmp 	l11
l10:	mov 	ax, word ptr a	; load lsb part in ax
l2 :	cmp 	ax, 1000h	; if ax>1000h   
	jb 	l4			
	sub 	ax, 1000h 					
	add 	bx, 1000	; add 1000 to result
	jmp 	l2
l4 :	cmp 	ax, 100h	; if ax>100h    		      
	jb 	l6
	sub 	ax, 100h
	add 	bx, 100	; add 100 to result
	jmp 	l4
l6 :	cmp 	ax, 10h	; if ax>10h
	jb 	l8
	sub 	ax, 10h
	add 	bx, 10	; add 10 to result
	jmp 	l6
l8 :	add 	bx, ax	; add remainder 
			; to result
	mov 	ch, 04h	; Count of digits to be 	
			; displayed
	mov 	cl, 04h	; Count to roll by 4 bits
l9:	rol 	bx, cl	; roll bl so that msb 	
			; comes to lsb 
	mov 	dl, bl	; load dl with data to  	
			; displayed
	and 	dl, 0fH	; get only lsb
	cmp 	dl, 09	; check if digit is 0-9 
			; or letter A-F 	
	jbe 	l7
	add 	dl, 07	; if letter add 37H else only add 30H
l7:	add 	dl, 30H 
	mov	ah, 02	; Function 2 under  INT 21H (Display 	character)
	int 	21H
	dec 	ch	; Decrement Count
	jnz 	l9
	mov 	ah, 4cH	; Terminate Program
	int 	21H
end start
end
