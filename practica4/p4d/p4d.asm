
_interrupt:

;p4d.c,4 :: 		void interrupt(){
;p4d.c,6 :: 		if(PORTB.B5 == 0){
	BTFSC       PORTB+0, 5 
	GOTO        L_interrupt0
;p4d.c,7 :: 		espera = 0;
	CLRF        _espera+0 
;p4d.c,8 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;p4d.c,9 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p4d.c,10 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;p4d.c,11 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;p4d.c,13 :: 		if(espera % 20 == 0){
	MOVLW       20
	MOVWF       R4 
	MOVF        _espera+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;p4d.c,14 :: 		espera = 0;
	CLRF        _espera+0 
;p4d.c,15 :: 		PORTA.B0+=1;
	CLRF        R0 
	BTFSC       PORTA+0, 0 
	INCF        R0, 1 
	INCF        R0, 1 
	BTFSC       R0, 0 
	GOTO        L__interrupt8
	BCF         PORTA+0, 0 
	GOTO        L__interrupt9
L__interrupt8:
	BSF         PORTA+0, 0 
L__interrupt9:
;p4d.c,16 :: 		}
L_interrupt2:
;p4d.c,17 :: 		delay_ms(25);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_interrupt3:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt3
	DECFSZ      R12, 1, 1
	BRA         L_interrupt3
	NOP
;p4d.c,18 :: 		espera++;
	INCF        _espera+0, 1 
;p4d.c,19 :: 		}
L_interrupt1:
;p4d.c,20 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;p4d.c,21 :: 		void main() {
;p4d.c,22 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p4d.c,23 :: 		TRISB = 0xF0;
	MOVLW       240
	MOVWF       TRISB+0 
;p4d.c,24 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;p4d.c,26 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p4d.c,27 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;p4d.c,28 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;p4d.c,29 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p4d.c,31 :: 		while(1){}
L_main4:
	GOTO        L_main4
;p4d.c,33 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
