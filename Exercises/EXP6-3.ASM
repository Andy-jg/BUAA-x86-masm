STACK 	SEGMENT	PARA	STACK
		DW		100H DUP(?)
STACK	ENDS

DATA	SEGMENT	PARA
LEN 	EQU 	128
STR1	DB		LEN-1
		DB		?
		DB		LEN DUP(?)
STR2	DB		LEN-1
		DB		?
		DB		LEN DUP(?)
DATA 	ENDS

CODE 	SEGMENT PARA
		ASSUME	CS:CODE,DS:DATA,SS:STACK

STRCMP 	PROC
		PUSH 	CX
		CLD
		PUSH 	SI
		MOV 	CX,1

SLP1:	LODSB
		CMP 	AL,00H
		JZ 		SLP1_1
		INC 	CX
		JMP 	SHORT SLP1
SLP1_1:	POP 	SI
		REPE 	CMPSB
		JA 		SL1
		JB 		SL2
		MOV 	AX,0
		JMP 	SHORT RETURN
SL1:	MOV 	AX,1
		JMP  	SHORT RETURN
SL2:	MOV 	AX,2
RETURN:	POP 	CX
		RET
STRCMP  ENDP

MAIN	PROC 	FAR
		MOV 	AX,DATA
		MOV 	DS,AX
		MOV 	ES,AX

		MOV 	DX,OFFSET STR1
		MOV 	AH,0AH
		INT 	21H

; 		MOV		CL,STR1+1
; 		XOR 	CH,CH
; 		MOV 	SI,OFFSET STR1+2

; LP1:	INC 	SI
; 		LOOP 	LP1

; 		MOV 	BYTE PTR [SI],00H

		MOV 	DL,0DH
		MOV 	AH,2
		INT 	21H
		MOV 	DL,0AH
		MOV 	AH,2
		INT 	21H

		MOV 	DX,OFFSET STR2
		MOV 	AH,0AH
		INT 	21H

		MOV 	DL,0DH
		MOV 	AH,2
		INT 	21H
		MOV 	DL,0AH
		MOV 	AH,2
		INT 	21H

; 		MOV		CL,STR2+1
; 		XOR 	CH,CH
; 		MOV 	SI,OFFSET STR2+2

; LP2:	INC 	SI
; 		LOOP 	LP2

; 		MOV 	BYTE PTR [SI],00H

		MOV 	SI,OFFSET STR1+2
		MOV 	DI,OFFSET STR2+2
		CALL 	STRCMP

		MOV 	DX,AX
		ADD 	DX,30H
		MOV 	AH,2
		INT 	21H


EXIT:	MOV 	AX,4C00H
		INT 	21H
MAIN 	ENDP

CODE 	ENDS
		END 	MAIN