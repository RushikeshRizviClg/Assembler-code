.model small
.data
	a dd 00065535h
.code
start:
	mov ax, @data
	mov ds,ax
	mov ax,word ptr a+2
	mov bx,0000h
     l10000:	cmp ax,00h	;check msb is zero
	jz l1000
	dec ax
	add bx,10000
	jmp l10000
      l1000:	mov ax,word ptr a
      l1001:	cmp ax,1000h
	jb l100
	sub ax,1000h
	add bx,1000
	jmp l1001
      l100:	cmp ax,100h
	jb l10
	sub ax,100h
	add bx,100
	jmp l100
      l10:	cmp ax,10h
	jb l1
	sub ax,10h
	add bx,10
	jmp l10
       l1:	add bx,ax
mov ah,4ch
int 21h
end start
end	