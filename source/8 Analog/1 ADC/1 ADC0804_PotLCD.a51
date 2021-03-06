;Program: Read potentiometer output using ADC0804 and display it on LCD
E EQU P2.7
RS EQU P2.6
LCD EQU P0
ADC_DATA EQU P1
ADC_WR EQU P3.3
ADC_INTR EQU P3.4
ORG 00H
	ACALL LCD_INIT
	MOV ADC_DATA,#0FFH	;make port = input
BACK:	CLR ADC_WR	;L-to-H to start conversion
	SETB ADC_WR
HERE:	JB ADC_INTR,HERE	;wait for end of conversion
	MOV A,ADC_DATA	;read the data
	MOV R4, #80H	;convert to ASCII
	ACALL LCD_COMMAND	; and display on LCD
	MOV B,#10
	DIV AB
	MOV R3,B
	MOV B,#10
	DIV AB
	ADD A,#30H
	MOV R4, A
	ACALL LCD_DATA
	MOV A,B
	ADD A,#30H
	MOV R4, A
	ACALL LCD_DATA
	MOV A,R3
	ADD A,#30H
	MOV R4, A
	ACALL LCD_DATA
	ACALL DELAY
	ACALL DELAY
	ACALL DELAY
	ACALL DELAY
	ACALL DELAY
	SJMP BACK

LCD_INIT:
	CLR E
	CLR RS
	MOV R4, #38H	;Use 2 lines and 5�7 matrix for LCD
	ACALL LCD_COMMAND
	ACALL DELAY
	MOV R4, #0CH	;LCD ON, Cursor OFF
	ACALL LCD_COMMAND
	ACALL DELAY
	MOV R4, #01H	;LCD clear
	ACALL LCD_COMMAND
	ACALL DELAY
RET

LCD_COMMAND:	;Function for LCD command
	CLR RS
	MOV LCD, R4
	SETB E
	ACALL DELAY
	CLR E
RET
	
LCD_DATA:	;Function for LCD data
	SETB RS
	MOV LCD, R4
	SETB E
	ACALL DELAY
	CLR E
RET
	
DELAY:	;Function for delay
		MOV R7, #200
LOOP1:	MOV R6, #200
LOOP:	DJNZ R6, LOOP
		DJNZ R7, LOOP1
RET
END