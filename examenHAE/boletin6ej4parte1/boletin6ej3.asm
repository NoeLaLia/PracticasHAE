
_interrupt:

;boletin6ej3.c,4 :: 		void interrupt(){
;boletin6ej3.c,5 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej3.c,6 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej3.c,7 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej3.c,8 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej3.c,9 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej3.c,10 :: 		case 0:
L_interrupt3:
;boletin6ej3.c,11 :: 		if(PORTA.B0){
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt4
;boletin6ej3.c,12 :: 		x = 0;
	CLRF        _x+0 
;boletin6ej3.c,13 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;boletin6ej3.c,14 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej3.c,15 :: 		}
L_interrupt4:
;boletin6ej3.c,16 :: 		break;
	GOTO        L_interrupt2
;boletin6ej3.c,17 :: 		case 1:
L_interrupt5:
;boletin6ej3.c,18 :: 		if(x == 25 && PORTA.B0){
	MOVF        _x+0, 0 
	XORLW       25
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt8
L__interrupt16:
;boletin6ej3.c,19 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;boletin6ej3.c,20 :: 		}
L_interrupt8:
;boletin6ej3.c,21 :: 		if(x == 25 && !PORTA.B0){
	MOVF        _x+0, 0 
	XORLW       25
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
	BTFSC       PORTA+0, 0 
	GOTO        L_interrupt11
L__interrupt15:
;boletin6ej3.c,22 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej3.c,23 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;boletin6ej3.c,24 :: 		}
L_interrupt11:
;boletin6ej3.c,25 :: 		x++;
	INCF        _x+0, 1 
;boletin6ej3.c,26 :: 		break;
	GOTO        L_interrupt2
;boletin6ej3.c,27 :: 		case 2:
L_interrupt12:
;boletin6ej3.c,28 :: 		x = 0;
	CLRF        _x+0 
;boletin6ej3.c,29 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej3.c,30 :: 		}
	GOTO        L_interrupt2
L_interrupt1:
	MOVF        _estado+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVF        _estado+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
	MOVF        _estado+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt12
L_interrupt2:
;boletin6ej3.c,31 :: 		}
L_interrupt0:
;boletin6ej3.c,32 :: 		}
L_end_interrupt:
L__interrupt18:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej3.c,33 :: 		void main() {
;boletin6ej3.c,34 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej3.c,36 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej3.c,37 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej3.c,39 :: 		TRISA.B0 = 1;
	BSF         TRISA+0, 0 
;boletin6ej3.c,40 :: 		TRISA.B1 = 0;
	BCF         TRISA+0, 1 
;boletin6ej3.c,41 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;boletin6ej3.c,43 :: 		T0CON = 0x12;
	MOVLW       18
	MOVWF       T0CON+0 
;boletin6ej3.c,45 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej3.c,46 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej3.c,47 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej3.c,48 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej3.c,49 :: 		while(1){
L_main13:
;boletin6ej3.c,50 :: 		asm nop;
	NOP
;boletin6ej3.c,51 :: 		}
	GOTO        L_main13
;boletin6ej3.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
