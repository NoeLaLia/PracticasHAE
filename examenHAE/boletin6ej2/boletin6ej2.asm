
_interrupt:

;boletin6ej2.c,4 :: 		void interrupt(){
;boletin6ej2.c,5 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej2.c,6 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej2.c,7 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej2.c,8 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej2.c,9 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej2.c,10 :: 		case 0:
L_interrupt3:
;boletin6ej2.c,11 :: 		if(PORTB.B3){
	BTFSS       PORTB+0, 3 
	GOTO        L_interrupt4
;boletin6ej2.c,12 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
	MOVLW       0
	MOVWF       _estado+1 
;boletin6ej2.c,13 :: 		PORTA.B0 = 1;
	BSF         PORTA+0, 0 
;boletin6ej2.c,14 :: 		x = 0;
	CLRF        _x+0 
	CLRF        _x+1 
;boletin6ej2.c,15 :: 		}
L_interrupt4:
;boletin6ej2.c,16 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2.c,17 :: 		case 1:
L_interrupt5:
;boletin6ej2.c,18 :: 		if(x == 30){
	MOVLW       0
	XORWF       _x+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt13
	MOVLW       30
	XORWF       _x+0, 0 
L__interrupt13:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;boletin6ej2.c,19 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
	MOVLW       0
	MOVWF       _estado+1 
;boletin6ej2.c,20 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;boletin6ej2.c,21 :: 		}
L_interrupt6:
;boletin6ej2.c,22 :: 		x++;
	INFSNZ      _x+0, 1 
	INCF        _x+1, 1 
;boletin6ej2.c,23 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2.c,24 :: 		case 2:
L_interrupt7:
;boletin6ej2.c,25 :: 		if(!PORTB.B3){
	BTFSC       PORTB+0, 3 
	GOTO        L_interrupt8
;boletin6ej2.c,26 :: 		estado = 0;
	CLRF        _estado+0 
	CLRF        _estado+1 
;boletin6ej2.c,27 :: 		}
L_interrupt8:
;boletin6ej2.c,28 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2.c,29 :: 		}
L_interrupt1:
	MOVLW       0
	XORWF       _estado+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt14
	MOVLW       0
	XORWF       _estado+0, 0 
L__interrupt14:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVLW       0
	XORWF       _estado+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVLW       1
	XORWF       _estado+0, 0 
L__interrupt15:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
	MOVLW       0
	XORWF       _estado+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVLW       2
	XORWF       _estado+0, 0 
L__interrupt16:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt7
L_interrupt2:
;boletin6ej2.c,30 :: 		}
L_interrupt0:
;boletin6ej2.c,31 :: 		}
L_end_interrupt:
L__interrupt12:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej2.c,32 :: 		void main() {
;boletin6ej2.c,33 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;boletin6ej2.c,34 :: 		TRISB.B3 = 1;
	BSF         TRISB+0, 3 
;boletin6ej2.c,36 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej2.c,37 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej2.c,38 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej2.c,40 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;boletin6ej2.c,42 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej2.c,43 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej2.c,44 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej2.c,45 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej2.c,47 :: 		while(1){
L_main9:
;boletin6ej2.c,48 :: 		asm nop;
	NOP
;boletin6ej2.c,49 :: 		}
	GOTO        L_main9
;boletin6ej2.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
