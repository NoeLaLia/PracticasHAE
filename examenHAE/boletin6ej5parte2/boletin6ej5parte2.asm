
_interrupt:

;boletin6ej5parte2.c,3 :: 		void interrupt(){
;boletin6ej5parte2.c,4 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej5parte2.c,5 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej5parte2.c,6 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej5parte2.c,7 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej5parte2.c,8 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej5parte2.c,9 :: 		case 0:
L_interrupt3:
;boletin6ej5parte2.c,10 :: 		if(PORTA.B5){
	BTFSS       PORTA+0, 5 
	GOTO        L_interrupt4
;boletin6ej5parte2.c,11 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej5parte2.c,12 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;boletin6ej5parte2.c,13 :: 		}
L_interrupt4:
;boletin6ej5parte2.c,14 :: 		break;
	GOTO        L_interrupt2
;boletin6ej5parte2.c,15 :: 		case 1:
L_interrupt5:
;boletin6ej5parte2.c,16 :: 		if(!PORTA.B5){
	BTFSC       PORTA+0, 5 
	GOTO        L_interrupt6
;boletin6ej5parte2.c,17 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;boletin6ej5parte2.c,19 :: 		}
L_interrupt6:
;boletin6ej5parte2.c,20 :: 		break;
	GOTO        L_interrupt2
;boletin6ej5parte2.c,21 :: 		case 2:
L_interrupt7:
;boletin6ej5parte2.c,22 :: 		if(PORTA.B5){
	BTFSS       PORTA+0, 5 
	GOTO        L_interrupt8
;boletin6ej5parte2.c,23 :: 		estado = 3;
	MOVLW       3
	MOVWF       _estado+0 
;boletin6ej5parte2.c,25 :: 		}
L_interrupt8:
;boletin6ej5parte2.c,26 :: 		break;
	GOTO        L_interrupt2
;boletin6ej5parte2.c,27 :: 		case 3:
L_interrupt9:
;boletin6ej5parte2.c,28 :: 		if(!PORTA.B5){
	BTFSC       PORTA+0, 5 
	GOTO        L_interrupt10
;boletin6ej5parte2.c,29 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej5parte2.c,30 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;boletin6ej5parte2.c,31 :: 		}
L_interrupt10:
;boletin6ej5parte2.c,32 :: 		break;
	GOTO        L_interrupt2
;boletin6ej5parte2.c,33 :: 		}
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
;boletin6ej5parte2.c,34 :: 		}
L_interrupt0:
;boletin6ej5parte2.c,35 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej5parte2.c,36 :: 		void main() {
;boletin6ej5parte2.c,37 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej5parte2.c,38 :: 		TRISA.B5 = 1;
	BSF         TRISA+0, 5 
;boletin6ej5parte2.c,39 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;boletin6ej5parte2.c,41 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej5parte2.c,42 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej5parte2.c,44 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;boletin6ej5parte2.c,46 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej5parte2.c,47 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej5parte2.c,48 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej5parte2.c,49 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej5parte2.c,50 :: 		while(1){
L_main11:
;boletin6ej5parte2.c,51 :: 		asm nop;
	NOP
;boletin6ej5parte2.c,52 :: 		}
	GOTO        L_main11
;boletin6ej5parte2.c,53 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
