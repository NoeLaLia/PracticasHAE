
_interrupt:

;p3c.c,10 :: 		void interrupt(){
;p3c.c,13 :: 		if(INTCON.INT0IF == 1){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;p3c.c,16 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p3c.c,18 :: 		if(numeroActual != 0){
	MOVF        _numeroActual+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;p3c.c,19 :: 		numeroActual--;
	DECF        _numeroActual+0, 1 
;p3c.c,20 :: 		}
L_interrupt1:
;p3c.c,21 :: 		}
	GOTO        L_interrupt2
L_interrupt0:
;p3c.c,23 :: 		else if(INTCON3.INT1IF == 1){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt3
;p3c.c,25 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p3c.c,27 :: 		if(numeroActual != 99){
	MOVF        _numeroActual+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt4
;p3c.c,28 :: 		numeroActual++;
	INCF        _numeroActual+0, 1 
;p3c.c,30 :: 		}
L_interrupt4:
;p3c.c,31 :: 		}
L_interrupt3:
L_interrupt2:
;p3c.c,32 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;p3c.c,33 :: 		void main() {
;p3c.c,34 :: 		char valores[] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111};
	MOVLW       63
	MOVWF       main_valores_L0+0 
	MOVLW       6
	MOVWF       main_valores_L0+1 
	MOVLW       91
	MOVWF       main_valores_L0+2 
	MOVLW       79
	MOVWF       main_valores_L0+3 
	MOVLW       102
	MOVWF       main_valores_L0+4 
	MOVLW       109
	MOVWF       main_valores_L0+5 
	MOVLW       125
	MOVWF       main_valores_L0+6 
	MOVLW       7
	MOVWF       main_valores_L0+7 
	MOVLW       127
	MOVWF       main_valores_L0+8 
	MOVLW       111
	MOVWF       main_valores_L0+9 
	CLRF        main_decenas_L0+0 
;p3c.c,40 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p3c.c,41 :: 		TRISD = 0;
	CLRF        TRISD+0 
;p3c.c,42 :: 		TRISE = 0;
	CLRF        TRISE+0 
;p3c.c,44 :: 		TRISB.B1 = 1; // se configura RB1 como entrada
	BSF         TRISB+0, 1 
;p3c.c,45 :: 		INTCON2.INTEDG1 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 5 
;p3c.c,46 :: 		INTCON3.INT1IF = 0; // se pone el flag de la interrupción INT1 a 0
	BCF         INTCON3+0, 0 
;p3c.c,47 :: 		INTCON3.INT1IE = 1; // se habilita la interrupción INT1
	BSF         INTCON3+0, 3 
;p3c.c,49 :: 		TRISB.B0 = 1; //se configura RB0 como entrada
	BSF         TRISB+0, 0 
;p3c.c,50 :: 		INTCON2.INTEDG0 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 6 
;p3c.c,51 :: 		INTCON.INT0IF = 0; //se pone el flag de la interrupción INT0 a 0
	BCF         INTCON+0, 1 
;p3c.c,52 :: 		INTCON.INT0IE = 1; //se habilita la interrupción INT0
	BSF         INTCON+0, 4 
;p3c.c,54 :: 		INTCON.GIE = 1; //se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p3c.c,59 :: 		while(1){
L_main5:
;p3c.c,61 :: 		unidades = temp % 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _numeroActual+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _numeroActual+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
;p3c.c,63 :: 		decenas = temp % 10;
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_decenas_L0+0 
;p3c.c,65 :: 		PORTE = 0b101;
	MOVLW       5
	MOVWF       PORTE+0 
;p3c.c,66 :: 		PORTD = valores[unidades];
	MOVLW       main_valores_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_valores_L0+0)
	MOVWF       FSR0L+1 
	MOVF        FLOC__main+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p3c.c,68 :: 		delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	NOP
	NOP
;p3c.c,70 :: 		PORTE = 0b110;
	MOVLW       6
	MOVWF       PORTE+0 
;p3c.c,71 :: 		PORTD = valores[decenas];
	MOVLW       main_valores_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_valores_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_decenas_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p3c.c,72 :: 		delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	NOP
	NOP
;p3c.c,73 :: 		}
	GOTO        L_main5
;p3c.c,74 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
