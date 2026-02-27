
_interrupt:

;d.c,10 :: 		void interrupt(){
;d.c,12 :: 		estado = !estado;
	MOVF        _estado+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _estado+0 
;d.c,14 :: 		x = PORTB; // para poder borrar el bit RBIF (define x global)
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;d.c,15 :: 		INTCON.RBIF=0; // se borra el bit RBIF después de llamar a la función tecla()
	BCF         INTCON+0, 0 
;d.c,16 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;d.c,18 :: 		void main()
;d.c,22 :: 		ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;d.c,25 :: 		TRISB.B5 = 1;
	BSF         TRISB+0, 5 
;d.c,26 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;d.c,31 :: 		INTCON2.RBPU = 0; // se habilitan las resistencias de pullup del puerto B
	BCF         INTCON2+0, 7 
;d.c,32 :: 		x = PORTB; // para poder borrar el RBIF
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;d.c,33 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;d.c,34 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;d.c,35 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;d.c,37 :: 		while(1) //bucle infinito
L_main0:
;d.c,39 :: 		if(estado == 1)
	MOVF        _estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;d.c,41 :: 		PORTA = 0xFF;
	MOVLW       255
	MOVWF       PORTA+0 
;d.c,42 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;d.c,43 :: 		PORTA = 0;
	CLRF        PORTA+0 
;d.c,44 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;d.c,45 :: 		}
	GOTO        L_main5
L_main2:
;d.c,48 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;d.c,49 :: 		}
L_main5:
;d.c,50 :: 		}
	GOTO        L_main0
;d.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
