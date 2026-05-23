
_interrupt:

;boletin6ej1.c,4 :: 		void interrupt(){
;boletin6ej1.c,5 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej1.c,6 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej1.c,7 :: 		case 0:
L_interrupt3:
;boletin6ej1.c,8 :: 		if(PORTA.B0){
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt4
;boletin6ej1.c,9 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;boletin6ej1.c,10 :: 		PORTA.B3 = 1;
	BSF         PORTA+0, 3 
;boletin6ej1.c,11 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej1.c,12 :: 		}
L_interrupt4:
;boletin6ej1.c,13 :: 		break;
	GOTO        L_interrupt2
;boletin6ej1.c,14 :: 		case 1:
L_interrupt5:
;boletin6ej1.c,15 :: 		if(PORTB.B6){
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt6
;boletin6ej1.c,16 :: 		PORTA.B3 = 0;
	BCF         PORTA+0, 3 
;boletin6ej1.c,17 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;boletin6ej1.c,18 :: 		x = 0;
	CLRF        _x+0 
;boletin6ej1.c,19 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;boletin6ej1.c,20 :: 		}
L_interrupt6:
;boletin6ej1.c,21 :: 		break;
	GOTO        L_interrupt2
;boletin6ej1.c,22 :: 		case 2:
L_interrupt7:
;boletin6ej1.c,23 :: 		if(x == 40){
	MOVF        _x+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;boletin6ej1.c,24 :: 		estado = 3;
	MOVLW       3
	MOVWF       _estado+0 
;boletin6ej1.c,25 :: 		PORTB.B0 = 1;
	BSF         PORTB+0, 0 
;boletin6ej1.c,26 :: 		PORTA.B3 = 0;
	BCF         PORTA+0, 3 
;boletin6ej1.c,27 :: 		}
L_interrupt8:
;boletin6ej1.c,28 :: 		x++;
	INCF        _x+0, 1 
;boletin6ej1.c,29 :: 		break;
	GOTO        L_interrupt2
;boletin6ej1.c,30 :: 		case 3:
L_interrupt9:
;boletin6ej1.c,31 :: 		if(PORTB.B4){
	BTFSS       PORTB+0, 4 
	GOTO        L_interrupt10
;boletin6ej1.c,32 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;boletin6ej1.c,33 :: 		PORTA.B4 = 0;
	BCF         PORTA+0, 4 
;boletin6ej1.c,34 :: 		estado = 4;
	MOVLW       4
	MOVWF       _estado+0 
;boletin6ej1.c,35 :: 		}
L_interrupt10:
;boletin6ej1.c,36 :: 		break;
	GOTO        L_interrupt2
;boletin6ej1.c,37 :: 		case 4:
L_interrupt11:
;boletin6ej1.c,38 :: 		if(!PORTA.B0){
	BTFSC       PORTA+0, 0 
	GOTO        L_interrupt12
;boletin6ej1.c,39 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej1.c,40 :: 		}
L_interrupt12:
;boletin6ej1.c,41 :: 		break;
	GOTO        L_interrupt2
;boletin6ej1.c,42 :: 		}
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
	MOVF        _estado+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt11
L_interrupt2:
;boletin6ej1.c,43 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej1.c,44 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej1.c,45 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej1.c,46 :: 		}
L_interrupt0:
;boletin6ej1.c,47 :: 		}
L_end_interrupt:
L__interrupt16:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej1.c,48 :: 		void main() {
;boletin6ej1.c,49 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej1.c,50 :: 		TRISA = 0x01;
	MOVLW       1
	MOVWF       TRISA+0 
;boletin6ej1.c,51 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;boletin6ej1.c,52 :: 		TRISB.B4 = 1;
	BSF         TRISB+0, 4 
;boletin6ej1.c,53 :: 		TRISB.B6 = 1;
	BSF         TRISB+0, 6 
;boletin6ej1.c,54 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;boletin6ej1.c,55 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej1.c,56 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej1.c,58 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej1.c,59 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej1.c,60 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej1.c,61 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej1.c,62 :: 		while(1){
L_main13:
;boletin6ej1.c,63 :: 		asm nop;
	NOP
;boletin6ej1.c,64 :: 		}
	GOTO        L_main13
;boletin6ej1.c,65 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
