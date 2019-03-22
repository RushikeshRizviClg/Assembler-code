.model small
.data
	A DB 02h
	B DB 06h
	msg DB "Hello world$"
.code
start:
	MOV AX,@data
	MOV DS,AX
	MOV AH,09H
	LEA DX,msg
	INT 21H
MOV AL,A
MOV BL,B
ADD AL,BL
MOV DL,AL
ADD DL,30H

MOV AH,02H
INT 21H

MOV AH,4CH
INT 21H

end start
end