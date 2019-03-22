.model small
.stack 100
.data
	array db 61h, 05h, 42h, 05H, 12H, 15h, 09h, 14h,  56h, 38h ; Array of10nos
	min 	db  0ffh    	
.code
start:
	mov 	ax, @data	; Initialize DS
	mov 	ds, ax	; 
	
	mov 	cl, 10       	; Initialise counter
	lea 	bx, array	; Initialise base pointer for array
	mov 	al, min     	; Get maximum number
back:	cmp 	al, [bx] 	; Compare number with maximum
	jc 	skip
	mov 	dl, [bx]	;  If no > this no swap
	mov 	al, dl      	;    
skip:  	 inc 	bx       	; Increment pointer
	dec 	cl          	; Decrement counter
	jnz 	back       	; check whether all the nos 	
			; have been scanned
	mov 	min, al      	; Store maximum number        
	mov 	ch, 02h	; Count of digits to be 	
			; displayed
	mov 	cl, 04h	; Count to roll by 4 bits
	mov 	bh, al	; Result in reg bh

l2:	rol 	bh, cl	; roll bl so that msb 
			; comes to lsb 
	mov 	dl, bh	; load dl with data to be 
			; displayed
	and 	dl, 0fH	; get only lsb
	cmp 	dl, 09	; check if digit is 0-9 
			; or letter A-F
	jbe 	l4
	add 	dl, 07	; if letter add 37H 
			; else only add 30H
l4:   	add 	dl, 30H
	mov 	ah, 02	; Function 2 under 
			; INT 21H 
			; (Display character)
	int 	21H
	dec 	ch	; Decrement Count 					
	jnz 	l2
	mov 	ah, 4cH	; Terminate Program
	int 	21H
end start
end
