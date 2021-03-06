E EQU P2.7
RS EQU P2.6
LCD EQU P0

PUBLIC LCD_INIT
PUBLIC LCD_COMMAND
PUBLIC LCD_DATA

SEG_LCD SEGMENT CODE
	RSEG SEG_LCD

LCD_INIT:	;initialize LCD
	CLR E
	CLR RS
	MOV R4, #38H	;Use 2 lines and 5×7 matrix for LCD
	ACALL LCD_COMMAND
	ACALL DELAY
	MOV R4, #0CH	;LCD ON, Cursor OFF
	ACALL LCD_COMMAND
	ACALL DELAY
	MOV R4, #01H	;LCD clear
	ACALL LCD_COMMAND
	ACALL DELAY
RET
	
LCD_COMMAND:	;send command to LCD
	CLR RS
	MOV LCD, R4
	SETB E
	ACALL DELAY
	CLR E
RET
	
LCD_DATA:	;send data to LCD
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