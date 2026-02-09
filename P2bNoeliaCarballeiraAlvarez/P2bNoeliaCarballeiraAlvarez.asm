
_main:

;P2bNoeliaCarballeiraAlvarez.c,1 :: 		void main() {
;P2bNoeliaCarballeiraAlvarez.c,3 :: 		char valores[] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111100, 0b00000111, 0b01111111, 0b01101111};
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
	MOVLW       7
	MOVWF       main_displays_L0+0 
	MOVLW       11
	MOVWF       main_displays_L0+1 
	MOVLW       13
	MOVWF       main_displays_L0+2 
	MOVLW       14
	MOVWF       main_displays_L0+3 
	CLRF        main_valorActual_L0+0 
;P2bNoeliaCarballeiraAlvarez.c,6 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;P2bNoeliaCarballeiraAlvarez.c,7 :: 		TRISC = 0;
	CLRF        TRISC+0 
;P2bNoeliaCarballeiraAlvarez.c,8 :: 		TRISD = 0;
	CLRF        TRISD+0 
;P2bNoeliaCarballeiraAlvarez.c,9 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;P2bNoeliaCarballeiraAlvarez.c,10 :: 		while(1){
L_main0:
;P2bNoeliaCarballeiraAlvarez.c,11 :: 		valorActual = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       main_valorActual_L0+0 
;P2bNoeliaCarballeiraAlvarez.c,12 :: 		for(i = 0; i < 4; i++){
	CLRF        main_i_L0+0 
L_main2:
	MOVLW       4
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;P2bNoeliaCarballeiraAlvarez.c,13 :: 		PORTC = valores[valorActual % 10];
	MOVLW       10
	MOVWF       R4 
	MOVF        main_valorActual_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       main_valores_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_valores_L0+0)
	MOVWF       FSR0L+1 
	MOVF        R0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;P2bNoeliaCarballeiraAlvarez.c,14 :: 		PORTD = displays[i];
	MOVLW       main_displays_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_displays_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_i_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;P2bNoeliaCarballeiraAlvarez.c,15 :: 		valorActual /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        main_valorActual_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       main_valorActual_L0+0 
;P2bNoeliaCarballeiraAlvarez.c,16 :: 		delay_ms(24);
	MOVLW       63
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
;P2bNoeliaCarballeiraAlvarez.c,12 :: 		for(i = 0; i < 4; i++){
	INCF        main_i_L0+0, 1 
;P2bNoeliaCarballeiraAlvarez.c,17 :: 		}
	GOTO        L_main2
L_main3:
;P2bNoeliaCarballeiraAlvarez.c,20 :: 		}
	GOTO        L_main0
;P2bNoeliaCarballeiraAlvarez.c,21 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
