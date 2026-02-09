
_main:

;P2aNoeliaCarballeiraAlvarez.c,1 :: 		void main() {
;P2aNoeliaCarballeiraAlvarez.c,2 :: 		char segundero = 0;
	CLRF        main_segundero_L0+0 
	CLRF        main_unidades_L0+0 
	CLRF        main_decenas_L0+0 
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
	MOVLW       124
	MOVWF       main_valores_L0+6 
	MOVLW       7
	MOVWF       main_valores_L0+7 
	MOVLW       127
	MOVWF       main_valores_L0+8 
	MOVLW       111
	MOVWF       main_valores_L0+9 
;P2aNoeliaCarballeiraAlvarez.c,7 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;P2aNoeliaCarballeiraAlvarez.c,8 :: 		TRISD = 0;
	CLRF        TRISD+0 
;P2aNoeliaCarballeiraAlvarez.c,9 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;P2aNoeliaCarballeiraAlvarez.c,10 :: 		while(1){
L_main0:
;P2aNoeliaCarballeiraAlvarez.c,11 :: 		for(segundero = 0; segundero < 60; segundero++){
	CLRF        main_segundero_L0+0 
L_main2:
	MOVLW       60
	SUBWF       main_segundero_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;P2aNoeliaCarballeiraAlvarez.c,12 :: 		unidades = segundero % 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        main_segundero_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_unidades_L0+0 
;P2aNoeliaCarballeiraAlvarez.c,13 :: 		decenas = (segundero / 10) % 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        main_segundero_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_decenas_L0+0 
;P2aNoeliaCarballeiraAlvarez.c,14 :: 		for(i = 0; i < 25; i++){
	CLRF        main_i_L0+0 
L_main5:
	MOVLW       25
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;P2aNoeliaCarballeiraAlvarez.c,15 :: 		PORTA = 0x02;
	MOVLW       2
	MOVWF       PORTA+0 
;P2aNoeliaCarballeiraAlvarez.c,16 :: 		PORTD = valores[unidades];
	MOVLW       main_valores_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_valores_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_unidades_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;P2aNoeliaCarballeiraAlvarez.c,17 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	NOP
	NOP
;P2aNoeliaCarballeiraAlvarez.c,18 :: 		PORTA = 0x01;
	MOVLW       1
	MOVWF       PORTA+0 
;P2aNoeliaCarballeiraAlvarez.c,19 :: 		PORTD = valores[decenas];
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
;P2aNoeliaCarballeiraAlvarez.c,20 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
	NOP
;P2aNoeliaCarballeiraAlvarez.c,14 :: 		for(i = 0; i < 25; i++){
	INCF        main_i_L0+0, 1 
;P2aNoeliaCarballeiraAlvarez.c,21 :: 		}
	GOTO        L_main5
L_main6:
;P2aNoeliaCarballeiraAlvarez.c,11 :: 		for(segundero = 0; segundero < 60; segundero++){
	INCF        main_segundero_L0+0, 1 
;P2aNoeliaCarballeiraAlvarez.c,23 :: 		}
	GOTO        L_main2
L_main3:
;P2aNoeliaCarballeiraAlvarez.c,24 :: 		}
	GOTO        L_main0
;P2aNoeliaCarballeiraAlvarez.c,25 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
