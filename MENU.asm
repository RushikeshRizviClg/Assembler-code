;Program 2: WRITE AN ASSEMBLY LANGUAGE PROGRAM FOR MENU DRIVEN OPERATION.
;Code:
PRINT MACRO MES                 ;macro to print message on the screen.
    MOV AH, 09H
    LEA DX, MES
    INT     21H
ENDM
.MODEL SMALL
.DATA
    A Dw 000Ch
    B DW 0002h
    X DB 12H
    Y DB 02H
    MSG1 DB "ENTER CHOICE 1.ADD 2.SUB 3.MUL 4.div$"
    MSG4 DB " ANSWER = $"
    MSG5 DB "SORRY WRONG INPUT$"
    
.CODE
START:  
    MOV AX,@DATA                    ;for data segment initialization
    MOV DS,AX

    PRINT MSG1                  ;MSG TO ENTER CHOICE
    
    CALL READ                   ;input from keyboard
    MOV CL,AL
    CMP CL,31H                  ;compare user input value
    JNZ A2
                            ; if yes execute next line else goto A2 
ADDITION PROC NEAR                  ; addition procedure
    MOV AX,A
    MOV BX,B
    ADD AX,BX
    CALL DISP
ADDITION ENDP
    
    MOV AH,4CH                  ;break 
    INT 21H

A2:     CMP CL,32H                  ;check if choice is 2
    JNZ A3                      ;if yes execute next line else goto A3
SUBTRACT PROC NEAR                  ;subtract procedure/subroutine
    MOV AX,A
    MOV BX,B
    SUB AX,BX
    CALL DISP
    SUBTRACT ENDP   
    
    MOV AH,4CH                  ;break
    INT 21H
    
A3: CMP CL,33H                  ;check if choice is 3
    JNZ A4                      ;if yes execute next line else goto A4
    MULTIPLICATION PROC NEAR
    MOV AL,X
    MOV BL,Y
    MUL BL
    CALL DISP
    MULTIPLICATION ENDP
    MOV AH,4CH                  ;break
    INT 21H

A4:     CMP CL,34H                  ;check if choice is 5
    JNZ A5                      ;if yes then execute next line else goto a5
    DIVI PROC NEAR
    MOV AX,A                    ;16 BIT OPERAND IN AX
    MOV BL,Y                    ;8 BIT OPERAND IN BL
    DIV BL                      ; EX: 4095/2 = 2047 R 1 2047 = 07FFh - won't fit in AL  
                            ;DIVID OVERFLOW
    CALL DISP           
    DIVI ENDP
    MOV AH,4CH
    INT 21H

A5:     PRINT MSG5                  ;if wrong input
    MOV AH,4CH
    INT 21H
        
READ PROC NEAR                      ;To read value from user for choice
    MOV AH,01H
    INT 21H
    RET
    READ ENDP

DISP PROC NEAR                      ;logic behind display
    mov     ch,04h                  ; Count of digits to be displayed
    mov     cl,04h                  ; Count to roll by 4 bits
    mov     bx,Ax
    PRINT MSG4
l2: rol     bx,cl                   ; roll bl so that msb comes to lsb 
    mov     dl,bl                   ; load dl with data to be displayed
    and     dl,0fH                  ; get only lsb
    cmp     dl,09h                  ; check if digit is 0-9 or letter A-F
    jbe     l4
    add     dl, 07h                 ; if letter add 37H else only add 30H
l4: add     dl, 30H
    mov     ah,02h
    int     21h
    dec     ch                  ; Decrement Count
    jnz     l2
    mov     ah, 02h
    mov     dl,' '
    int     21h 
DISP endp

    MOV AH,4CH                  ;termination of  program
    INT 21H
END START
END