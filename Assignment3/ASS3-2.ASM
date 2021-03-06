STACK 	SEGMENT	PARA	STACK
		DW		100H DUP(?)
STACK	ENDS

DATA	SEGMENT	PARA
	LEN 	EQU 7
	N		EQU 10	;TIMES OF LOOP
	X		DW 	7
	Y		DW  8
	Z		DW 	?
	STRING1 DB	'QIQI',20H,0,'$'
	STRING2 DB	'CHEN',20H,0,'$'	
	CHAR 	DB	'C'
	OP 		DB 	?
	NL		DB 	13,10,'$'
	MSGEQ 	DB 	'STRING1=STRING2',13,10,'$'
	MSGGT 	DB 	'STRING1>STRING2',13,10,'$'
	MSGLT   DB 	'STRING1<STRING2',13,10,'$'
	DOFOUND DB	'CHAR FOUND IN STRING2',13,10,'$'
	NOTFOUND DB 'CHAR NOT FOUND IN STRING2',13,10,'$'
DATA 	ENDS

CODE 	SEGMENT PARA
		ASSUME	CS:CODE,DS:DATA,SS:STACK
;PRINT A NEWLINE
NEWLINE MACRO
	PUSH  	DX
	PUSH 	AX
	MOV		DX,OFFSET NL
	MOV 	AH,9
	INT 	21H
	POP 	AX
	POP	 	DX
	ENDM
;GET OPERATION TO OP
GETOP 	MACRO
	GETOPM:
		MOV 	AH,1
		INT 	21H
		MOV 	OP,AL
		ENDM
;OUTPUT MSG
OUTPUT 	MACRO MSG
	PUSH 	DX
	PUSH 	AX
	MOV 	DX,OFFSET MSG
	MOV 	AH,9
	INT 	21H
	POP 	AX
	POP 	DX
	ENDM
;DISPLAY VALUE IN AX
DISP_VALUE PROC
	DISPLAY:
		PUSH 	DX
		PUSH 	CX
		PUSH	BX
		PUSH 	AX

		MOV 	CX,5
		MOV 	BX,10

	DLP1:
		XOR 	DX,DX
		DIV 	BX
		PUSH 	DX
		LOOP 	DLP1

		MOV 	BX,0
		MOV 	CX,5
	DLP2:
		POP 	DX
		CMP 	DL,0
		JNZ 	DLP2_1
		CMP 	BX,0
		JZ 		DLP2_2
	DLP2_1:
		MOV 	BX,1
		OR 		DL,30H
		MOV 	AH,2
		INT  	21H
	DLP2_2:
		LOOP 	DLP2

		NEWLINE
		POP 	AX
		POP 	BX
		POP 	CX
		POP 	DX
		RET
DISP_VALUE ENDP

DISP_STR2 PROC
	PRINTSTR2:
		PUSH 	DX
		MOV 	DX,OFFSET STRING2
		MOV 	AH,9
		INT 	21H
		NEWLINE
		POP 	DX
		RET
DISP_STR2 ENDP

MULTIPLE PROC
	MULTI:
		PUSH 	BP
		MOV 	BP,SP
		PUSH 	AX
		PUSH 	BX

		MOV 	AX,[BP+4]
		MOV 	BX,[BP+6]
		MUL 	BX
		MOV 	Z,AX

		POP 	BX
		POP 	AX
		POP 	BP

		RET 	4
MULTIPLE ENDP

MULTIPLE2 PROC
	MULTI2:
		MUL 	BX
		MOV 	Z,AX
		RET
MULTIPLE2 ENDP

STRCPY PROC
	STRCPYPROC:
		PUSH 	BP
		MOV 	BP,SP

		PUSH 	DI 
		PUSH 	SI
		MOV 	SI,[BP+4]
		MOV		DI,[BP+6]

		CLD
	CPYLP:
		LODSB
		STOSB
		CMP 	AL,0
		JNZ 	CPYLP
		POP 	SI
		POP 	DI
		POP 	BP
		RET 	4
STRCPY ENDP

STRCPY2 PROC
	STRCPY2PROC:
		CLD
	CPYLP2:
		LODSB
		STOSB
		CMP 	AL,0
		JNZ 	CPYLP2
		RET
STRCPY2 ENDP

STRCMP 	PROC
	STRCMPROC:
		PUSH 	BP
		MOV 	BP,SP

		PUSH 	DI
		PUSH 	SI

		MOV 	SI,[BP+4]
		MOV 	DI,[BP+6]
		CALL 	STRCMP2

		POP 	SI
		POP 	DI
		POP 	BP
		RET 	4
STRCMP 	ENDP

STRCMP2 PROC
	STRCMP2PROC:
		PUSH 	CX
		PUSH 	SI
		CLD
		PUSH 	SI
		MOV 	CX,1
	CMPLP2:
		LODSB
		CMP 	AL,0
		JZ 		CMPLPBEG2
		INC 	CX
		JMP 	SHORT CMPLP2
	CMPLPBEG2:
		POP 	SI
		REPE 	CMPSB
		JA 		L2_1
		JB 		L2_2
		OUTPUT 	MSGEQ
		JMP 	SHORT CMPRET2
	L2_1:
		OUTPUT 	MSGGT
		JMP 	SHORT CMPRET2
	L2_2:
		OUTPUT 	MSGLT
	CMPRET2:
		POP  	SI
		POP 	CX
		RET
STRCMP2 ENDP

FIND PROC
	FINDCHAR:
		PUSH 	BP
		MOV	 	BP,SP
		PUSH 	CX

		MOV 	DI,[BP+6]
		MOV 	CX,LEN
		DEC 	CX
		MOV 	AX,[BP+4]
		CLD
		REPNZ 	SCASB
		JZ 	FOUND
		OUTPUT 	NOTFOUND
		JMP 	SHORT FIND_RETURN
	FOUND:
		OUTPUT 	DOFOUND
	FIND_RETURN:
		POP 	CX
		POP 	BP
		RET		4
FIND ENDP

FIND2 PROC
	FIND2PROC:
		PUSH 	CX
		PUSH 	DI
		MOV 	CX,LEN
		DEC 	CX
		CLD
		REPNZ 	SCASB
		JZ 		FOUND2
		OUTPUT 	NOTFOUND
		JMP 	SHORT FIND2RETURN
	FOUND2:
		OUTPUT 	DOFOUND
	FIND2RETURN:
		POP 	DI
		POP 	CX
		RET
FIND2 ENDP

TOLOWER PROC
	TOLOW:
		PUSH 	BP
		MOV 	BP,SP
		PUSH 	SI
		PUSH 	DI
		PUSH 	CX
		PUSH 	AX

		MOV 	SI,[BP + 4]
		MOV 	DI,SI
		MOV 	CX,LEN
		CLD
	TOLOW_LP:
		LODSB
		CMP 	AL,'A'
		JB 		TOLOW_CONTINUE
		CMP 	AL,'Z'
		JA 		TOLOW_CONTINUE
		ADD 	AL,20H
	TOLOW_CONTINUE:
		STOSB
		LOOP 	TOLOW_LP
		
		POP 	AX
		POP 	CX
		POP 	DI
		POP 	SI
		POP 	BP
		RET 	2
TOLOWER ENDP

TOLOWER2 PROC
	TOLOW2:
		PUSH 	SI
		PUSH 	DI
		PUSH 	CX
		PUSH 	AX
		MOV 	DI,SI
		MOV 	CX,LEN
		DEC 	CX
		CLD
	TOLOW_LP2:
		LODSB
		CMP 	AL,'A'
		JB 		TOLOW_CONTINUE2
		CMP 	AL,'Z'
		JA 		TOLOW_CONTINUE2
		ADD 	AL,20H
	TOLOW_CONTINUE2:
		STOSB
		LOOP 	TOLOW_LP2
		POP 	AX
		POP 	CX
		POP 	DI
		POP 	SI
		RET
TOLOWER2 ENDP

SWITCH 	PROC
	SWITCHPROC:
		PUSH 	CX
	S0:
		CMP 	OP,'A'
		JNE		S1
		PUSH 	X
		PUSH 	Y
		CALL 	MULTIPLE
		MOV 	AX,Z
		CALL 	DISP_VALUE
		JMP 	CONTINUE
	S1:
		CMP 	OP,'B'
		JNE		S2
		MOV 	DX,OFFSET STRING2
		PUSH 	DX
		MOV 	DX,OFFSET STRING1
		PUSH 	DX
		CALL 	STRCPY
		OUTPUT 	STRING2
		NEWLINE
		JMP 	CONTINUE
	S2:
		CMP 	OP,'C'
		JNE		S3
		MOV 	DX,OFFSET STRING2
		PUSH 	DX
		MOV 	DX,OFFSET STRING1
		PUSH 	DX
		CALL 	STRCMP
		JMP 	CONTINUE
	S3:
		CMP 	OP,'D'
		JNE		S4
		MOV 	DX,OFFSET STRING2
		PUSH 	DX
		MOV 	DL,CHAR
		XOR 	DH,DH
		PUSH 	DX
		CALL 	FIND
		JMP 	CONTINUE
	S4:
		CMP 	OP,'E'
		JNE		S5
		MOV 	DX,OFFSET STRING1
		PUSH 	DX
		CALL 	TOLOWER
		OUTPUT 	STRING1
		NEWLINE
		JMP 	CONTINUE
	S5:
		CMP 	OP,'a'
		JNE		S6
		MOV 	AX,X
		MOV 	BX,Y
		CALL 	MULTIPLE2
		MOV		AX,Z
		CALL 	DISP_VALUE
		JMP 	CONTINUE
	S6:
		CMP 	OP,'b'
		JNE		S7
		MOV	 	SI,OFFSET STRING1
		MOV 	DI,OFFSET STRING2
		CALL 	STRCPY2
		OUTPUT 	STRING2
		NEWLINE
		JMP 	CONTINUE
	S7:
		CMP 	OP,'c'
		JNE		S8
		MOV 	SI,OFFSET STRING1
		MOV 	DI,OFFSET STRING2
		CALL 	STRCMP2
		JMP 	CONTINUE
	S8:
		CMP 	OP,'d'
		JNE		S9
		MOV	 	DI,OFFSET STRING2
		MOV 	AL,CHAR
		CALL	FIND2
		JMP 	CONTINUE
	S9:
		CMP 	OP,'e'
		JNE		CONTINUE
		MOV 	SI,OFFSET STRING2
		CALL 	TOLOWER2
		OUTPUT 	STRING2
		NEWLINE
	CONTINUE:
		POP 	CX	
		RET
SWITCH 	ENDP

MAIN	PROC 	FAR
	MAINPROC:
		MOV 	AX,DATA
		MOV 	DS,AX
		MOV 	ES,AX

		MOV 	CX,N
	MAINLOOP:
		GETOP
		NEWLINE
		CALL 	SWITCH
		LOOP 	MAINLOOP

	EXIT:	
		MOV 	AX,4C00H
		INT 	21H
MAIN 	ENDP

CODE 	ENDS
		END 	MAIN