
_interrupt:

;boletin6ej2parte2.c,4 :: 		void interrupt(){
;boletin6ej2parte2.c,5 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej2parte2.c,6 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej2parte2.c,7 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej2parte2.c,8 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej2parte2.c,9 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej2parte2.c,10 :: 		case 0:
L_interrupt3:
;boletin6ej2parte2.c,11 :: 		if(PORTB.B3){
	BTFSS       PORTB+0, 3 
	GOTO        L_interrupt4
;boletin6ej2parte2.c,12 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej2parte2.c,13 :: 		}
L_interrupt4:
;boletin6ej2parte2.c,14 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2parte2.c,15 :: 		case 1:
L_interrupt5:
;boletin6ej2parte2.c,16 :: 		if(!PORTB.B3){
	BTFSC       PORTB+0, 3 
	GOTO        L_interrupt6
;boletin6ej2parte2.c,17 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;boletin6ej2parte2.c,18 :: 		x = 0;
	CLRF        _x+0 
;boletin6ej2parte2.c,19 :: 		PORTA.B0 = 1;
	BSF         PORTA+0, 0 
;boletin6ej2parte2.c,20 :: 		}
L_interrupt6:
;boletin6ej2parte2.c,21 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2parte2.c,22 :: 		case 2:
L_interrupt7:
;boletin6ej2parte2.c,23 :: 		if(x == 10){
	MOVF        _x+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;boletin6ej2parte2.c,24 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;boletin6ej2parte2.c,25 :: 		estado = 3;
	MOVLW       3
	MOVWF       _estado+0 
;boletin6ej2parte2.c,26 :: 		}
L_interrupt8:
;boletin6ej2parte2.c,27 :: 		x++;
	INCF        _x+0, 1 
;boletin6ej2parte2.c,28 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2parte2.c,29 :: 		case 3:
L_interrupt9:
;boletin6ej2parte2.c,30 :: 		if(!PORTB.B3){
	BTFSC       PORTB+0, 3 
	GOTO        L_interrupt10
;boletin6ej2parte2.c,31 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej2parte2.c,32 :: 		}
L_interrupt10:
;boletin6ej2parte2.c,33 :: 		break;
	GOTO        L_interrupt2
;boletin6ej2parte2.c,34 :: 		}
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
	GOTO        L_interrupt7
	MOVF        _estado+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt9
L_interrupt2:
;boletin6ej2parte2.c,35 :: 		}
L_interrupt0:
;boletin6ej2parte2.c,36 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej2parte2.c,37 :: 		void main() {
;boletin6ej2parte2.c,38 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;boletin6ej2parte2.c,39 :: 		TRISB.B3 = 1;
	BSF         TRISB+0, 3 
;boletin6ej2parte2.c,40 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej2parte2.c,41 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej2parte2.c,42 :: 		T0CON = 0x12;
	MOVLW       18
	MOVWF       T0CON+0 
;boletin6ej2parte2.c,44 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej2parte2.c,45 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej2parte2.c,46 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej2parte2.c,47 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej2parte2.c,48 :: 		while(1){
L_main11:
;boletin6ej2parte2.c,49 :: 		asm nop;
	NOP
;boletin6ej2parte2.c,50 :: 		}
	GOTO        L_main11
;boletin6ej2parte2.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
