
_interrupt:

;boletin6ej4parte2.c,4 :: 		void interrupt(){
;boletin6ej4parte2.c,5 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej4parte2.c,6 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej4parte2.c,7 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej4parte2.c,8 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej4parte2.c,9 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej4parte2.c,10 :: 		case 0:
L_interrupt3:
;boletin6ej4parte2.c,11 :: 		if(PORTA.B2){
	BTFSS       PORTA+0, 2 
	GOTO        L_interrupt4
;boletin6ej4parte2.c,12 :: 		x = 0;
	CLRF        _x+0 
;boletin6ej4parte2.c,13 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej4parte2.c,14 :: 		PORTB.B1 = 1;
	BSF         PORTB+0, 1 
;boletin6ej4parte2.c,15 :: 		PORTB.B4 = 1;
	BSF         PORTB+0, 4 
;boletin6ej4parte2.c,16 :: 		}
L_interrupt4:
;boletin6ej4parte2.c,17 :: 		break;
	GOTO        L_interrupt2
;boletin6ej4parte2.c,18 :: 		case 1:
L_interrupt5:
;boletin6ej4parte2.c,19 :: 		x++;
	INCF        _x+0, 1 
;boletin6ej4parte2.c,20 :: 		if(x == 50){
	MOVF        _x+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;boletin6ej4parte2.c,21 :: 		PORTB.B4 = 0;
	BCF         PORTB+0, 4 
;boletin6ej4parte2.c,22 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;boletin6ej4parte2.c,23 :: 		}
L_interrupt6:
;boletin6ej4parte2.c,24 :: 		break;
	GOTO        L_interrupt2
;boletin6ej4parte2.c,25 :: 		case 2:
L_interrupt7:
;boletin6ej4parte2.c,26 :: 		x++;
	INCF        _x+0, 1 
;boletin6ej4parte2.c,27 :: 		if(x == 100){
	MOVF        _x+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;boletin6ej4parte2.c,28 :: 		PORTB.B1 = 0;
	BCF         PORTB+0, 1 
;boletin6ej4parte2.c,29 :: 		estado = 3;
	MOVLW       3
	MOVWF       _estado+0 
;boletin6ej4parte2.c,30 :: 		}
L_interrupt8:
;boletin6ej4parte2.c,31 :: 		break;
	GOTO        L_interrupt2
;boletin6ej4parte2.c,32 :: 		case 3:
L_interrupt9:
;boletin6ej4parte2.c,33 :: 		if(!PORTA.B2){
	BTFSC       PORTA+0, 2 
	GOTO        L_interrupt10
;boletin6ej4parte2.c,34 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej4parte2.c,35 :: 		}
L_interrupt10:
;boletin6ej4parte2.c,36 :: 		break;
	GOTO        L_interrupt2
;boletin6ej4parte2.c,37 :: 		}
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
;boletin6ej4parte2.c,38 :: 		}
L_interrupt0:
;boletin6ej4parte2.c,39 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej4parte2.c,40 :: 		void main() {
;boletin6ej4parte2.c,41 :: 		TRISA.B2 = 1;
	BSF         TRISA+0, 2 
;boletin6ej4parte2.c,42 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;boletin6ej4parte2.c,43 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej4parte2.c,44 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej4parte2.c,45 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej4parte2.c,47 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;boletin6ej4parte2.c,49 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej4parte2.c,50 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej4parte2.c,51 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej4parte2.c,52 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej4parte2.c,53 :: 		while(1){
L_main11:
;boletin6ej4parte2.c,54 :: 		asm nop;
	NOP
;boletin6ej4parte2.c,55 :: 		}
	GOTO        L_main11
;boletin6ej4parte2.c,56 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
