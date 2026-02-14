
_main:

;p3a.c,14 :: 		void main() {
;p3a.c,15 :: 		char botonPulsado = 0;
	CLRF        main_botonPulsado_L0+0 
;p3a.c,16 :: 		TRISB.B2 = 1;
	BSF         TRISB+0, 2 
;p3a.c,17 :: 		TRISB.B3 = 0;
	BCF         TRISB+0, 3 
;p3a.c,18 :: 		while(1){
L_main0:
;p3a.c,19 :: 		if(PORTB.B2 == 1 && botonPulsado == 0){
	BTFSS       PORTB+0, 2 
	GOTO        L_main4
	MOVF        main_botonPulsado_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
L__main10:
;p3a.c,20 :: 		botonPulsado = 1;
	MOVLW       1
	MOVWF       main_botonPulsado_L0+0 
;p3a.c,21 :: 		PORTB.B3 += 1;
	CLRF        R0 
	BTFSC       PORTB+0, 3 
	INCF        R0, 1 
	INCF        R0, 1 
	BTFSC       R0, 0 
	GOTO        L__main12
	BCF         PORTB+0, 3 
	GOTO        L__main13
L__main12:
	BSF         PORTB+0, 3 
L__main13:
;p3a.c,23 :: 		}
L_main4:
;p3a.c,24 :: 		if(PORTB.B2 == 0 && botonPulsado == 1){
	BTFSC       PORTB+0, 2 
	GOTO        L_main7
	MOVF        main_botonPulsado_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
L__main9:
;p3a.c,25 :: 		botonPulsado = 0;
	CLRF        main_botonPulsado_L0+0 
;p3a.c,26 :: 		}
L_main7:
;p3a.c,27 :: 		delay_ms(25);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	NOP
;p3a.c,29 :: 		}
	GOTO        L_main0
;p3a.c,30 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
