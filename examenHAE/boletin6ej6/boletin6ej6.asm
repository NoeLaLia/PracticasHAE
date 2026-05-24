
_interrupt:

;boletin6ej6.c,17 :: 		void interrupt(){
;boletin6ej6.c,18 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;boletin6ej6.c,19 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej6.c,20 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej6.c,21 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej6.c,22 :: 		switch(estado){
	GOTO        L_interrupt1
;boletin6ej6.c,23 :: 		case 0:
L_interrupt3:
;boletin6ej6.c,24 :: 		if(bc && ar){
	BTFSS       PORTB+0, 0 
	GOTO        L_interrupt6
	BTFSS       PORTA+0, 2 
	GOTO        L_interrupt6
L__interrupt22:
;boletin6ej6.c,25 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;boletin6ej6.c,26 :: 		v = 1;
	BSF         PORTD+0, 3 
;boletin6ej6.c,27 :: 		ma1 = 0;
	BCF         PORTC+0, 3 
;boletin6ej6.c,28 :: 		ma0 = 1;
	BSF         PORTC+0, 0 
;boletin6ej6.c,29 :: 		mb1 = 0;
	BCF         PORTD+0, 0 
;boletin6ej6.c,30 :: 		mb0 = 0;
	BCF         PORTC+0, 6 
;boletin6ej6.c,32 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;boletin6ej6.c,33 :: 		else if(ac && br){
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt10
	BTFSS       PORTB+0, 2 
	GOTO        L_interrupt10
L__interrupt21:
;boletin6ej6.c,34 :: 		estado = 3;
	MOVLW       3
	MOVWF       _estado+0 
;boletin6ej6.c,35 :: 		v = 0;
	BCF         PORTD+0, 3 
;boletin6ej6.c,36 :: 		ma1 = 0;
	BCF         PORTC+0, 3 
;boletin6ej6.c,37 :: 		ma0 = 0;
	BCF         PORTC+0, 0 
;boletin6ej6.c,38 :: 		mb1 = 0;
	BCF         PORTD+0, 0 
;boletin6ej6.c,39 :: 		mb0 = 1;
	BSF         PORTC+0, 6 
;boletin6ej6.c,40 :: 		}
L_interrupt10:
L_interrupt7:
;boletin6ej6.c,41 :: 		break;
	GOTO        L_interrupt2
;boletin6ej6.c,42 :: 		case 1:
L_interrupt11:
;boletin6ej6.c,43 :: 		if(ad){
	BTFSS       PORTA+0, 4 
	GOTO        L_interrupt12
;boletin6ej6.c,44 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;boletin6ej6.c,45 :: 		ma1 = 1;
	BSF         PORTC+0, 3 
;boletin6ej6.c,46 :: 		ma0 = 0;
	BCF         PORTC+0, 0 
;boletin6ej6.c,47 :: 		}
L_interrupt12:
;boletin6ej6.c,48 :: 		break;
	GOTO        L_interrupt2
;boletin6ej6.c,49 :: 		case 2:
L_interrupt13:
;boletin6ej6.c,50 :: 		if(ac){
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt14
;boletin6ej6.c,51 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej6.c,52 :: 		ma1 = 0;
	BCF         PORTC+0, 3 
;boletin6ej6.c,53 :: 		}
L_interrupt14:
;boletin6ej6.c,54 :: 		break;
	GOTO        L_interrupt2
;boletin6ej6.c,55 :: 		case 3:
L_interrupt15:
;boletin6ej6.c,56 :: 		if(bd){
	BTFSS       PORTB+0, 4 
	GOTO        L_interrupt16
;boletin6ej6.c,57 :: 		estado = 4;
	MOVLW       4
	MOVWF       _estado+0 
;boletin6ej6.c,58 :: 		mb1 = 1;
	BSF         PORTD+0, 0 
;boletin6ej6.c,59 :: 		mb0 = 0;
	BCF         PORTC+0, 6 
;boletin6ej6.c,60 :: 		}
L_interrupt16:
;boletin6ej6.c,61 :: 		break;
	GOTO        L_interrupt2
;boletin6ej6.c,62 :: 		case 4:
L_interrupt17:
;boletin6ej6.c,63 :: 		if(bc){
	BTFSS       PORTB+0, 0 
	GOTO        L_interrupt18
;boletin6ej6.c,64 :: 		estado = 0;
	CLRF        _estado+0 
;boletin6ej6.c,65 :: 		mb1 = 0;
	BCF         PORTD+0, 0 
;boletin6ej6.c,66 :: 		}
L_interrupt18:
;boletin6ej6.c,67 :: 		break;
	GOTO        L_interrupt2
;boletin6ej6.c,68 :: 		}
L_interrupt1:
	MOVF        _estado+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVF        _estado+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt11
	MOVF        _estado+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt13
	MOVF        _estado+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt15
	MOVF        _estado+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt17
L_interrupt2:
;boletin6ej6.c,69 :: 		}
L_interrupt0:
;boletin6ej6.c,70 :: 		}
L_end_interrupt:
L__interrupt24:
	RETFIE      1
; end of _interrupt

_main:

;boletin6ej6.c,71 :: 		void main() {
;boletin6ej6.c,72 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;boletin6ej6.c,73 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;boletin6ej6.c,74 :: 		TRISC = 0;
	CLRF        TRISC+0 
;boletin6ej6.c,75 :: 		TRISD = 0;
	CLRF        TRISD+0 
;boletin6ej6.c,76 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;boletin6ej6.c,77 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;boletin6ej6.c,78 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;boletin6ej6.c,80 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;boletin6ej6.c,82 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;boletin6ej6.c,83 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;boletin6ej6.c,84 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;boletin6ej6.c,85 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;boletin6ej6.c,86 :: 		while(1){
L_main19:
;boletin6ej6.c,87 :: 		asm nop;
	NOP
;boletin6ej6.c,88 :: 		}
	GOTO        L_main19
;boletin6ej6.c,89 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
