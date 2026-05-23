
_interrupt:

;boletin6ej5parte1.c,3 :: 		void interrupt(){
;boletin6ej5parte1.c,4 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej5parte1.c,5 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej5parte1.c,6 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej5parte1.c,7 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej5parte1.c,8 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej5parte1.c,9 :: 		case 0:
L_interrupt3:
;boletin6ej5parte1.c,10 :: 		if(PORTA.B5){
	BTFSS       PORTA+0, 5 
	GOTO        L_interrupt4
;boletin6ej5parte1.c,11 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej5parte1.c,12 :: 		}
L_interrupt4:
;boletin6ej5parte1.c,13 :: 		break;
	GOTO        L_interrupt2
;boletin6ej5parte1.c,14 :: 		case 1:
L_interrupt5:
;boletin6ej5parte1.c,15 :: 		if(!PORTA.B5){
	BTFSC       PORTA+0, 5 
	GOTO        L_interrupt6
;boletin6ej5parte1.c,16 :: 		PORTC.B0++;
	CLRF        R0 
	BTFSC       PORTC+0, 0 
	INCF        R0, 1 
	MOVLW       0
	MOVWF       R1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	BTFSC       R0, 0 
	GOTO        L__interrupt11
	BCF         PORTC+0, 0 
	GOTO        L__interrupt12
L__interrupt11:
	BSF         PORTC+0, 0 
L__interrupt12:
;boletin6ej5parte1.c,17 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej5parte1.c,18 :: 		}
L_interrupt6:
;boletin6ej5parte1.c,19 :: 		break;
	GOTO        L_interrupt2
;boletin6ej5parte1.c,20 :: 		}
L_interrupt1:
	MOVF        _estado+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVF        _estado+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
L_interrupt2:
;boletin6ej5parte1.c,21 :: 		}
L_interrupt0:
;boletin6ej5parte1.c,22 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej5parte1.c,23 :: 		void main() {
;boletin6ej5parte1.c,24 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej5parte1.c,25 :: 		TRISA.B5 = 1;
	BSF         TRISA+0, 5 
;boletin6ej5parte1.c,26 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;boletin6ej5parte1.c,27 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;boletin6ej5parte1.c,28 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej5parte1.c,29 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej5parte1.c,31 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;boletin6ej5parte1.c,33 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej5parte1.c,34 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej5parte1.c,35 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej5parte1.c,36 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej5parte1.c,37 :: 		while(1){
L_main7:
;boletin6ej5parte1.c,38 :: 		asm nop;
	NOP
;boletin6ej5parte1.c,39 :: 		}
	GOTO        L_main7
;boletin6ej5parte1.c,41 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
