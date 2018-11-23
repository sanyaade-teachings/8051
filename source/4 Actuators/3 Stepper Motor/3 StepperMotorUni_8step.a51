;Program: Rotate unipolar stepper motor using 8 steps
Stepper EQU P2	;P2.3-P2.0
ORG 00H
MAIN:
	MOV Stepper,#11110111B	;values for stepper
	ACALL DELAY
	MOV Stepper,#11110011B
	ACALL DELAY
	MOV Stepper,#11111011B
	ACALL DELAY
	MOV Stepper,#11111001B
	ACALL DELAY
	MOV Stepper,#11111101B
	ACALL DELAY
	MOV Stepper,#11111100B
	ACALL DELAY
	MOV Stepper,#11111110B
	ACALL DELAY
	MOV Stepper,#11110110B
	ACALL DELAY
	AJMP MAIN
	
DELAY:	;Function for delay
		MOV R1, #200
LOOP1:	MOV R2, #200
LOOP:	DJNZ R2, LOOP
		DJNZ R1, LOOP1
RET
END