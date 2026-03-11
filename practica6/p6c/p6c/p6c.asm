
_interrupt:

;p6c.c,28 :: 		void interrupt(){
;p6c.c,30 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;p6c.c,31 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p6c.c,32 :: 		if(estado_actual == 2){
	MOVLW       0
	XORWF       _estado_actual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt13
	MOVLW       2
	XORWF       _estado_actual+0, 0 
L__interrupt13:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;p6c.c,33 :: 		estado_actual = 0;
	CLRF        _estado_actual+0 
	CLRF        _estado_actual+1 
;p6c.c,34 :: 		}
	GOTO        L_interrupt2
L_interrupt1:
;p6c.c,36 :: 		estado_actual++;
	INFSNZ      _estado_actual+0, 1 
	INCF        _estado_actual+1, 1 
;p6c.c,37 :: 		}
L_interrupt2:
;p6c.c,38 :: 		mostrar_pantalla = 1;
	MOVLW       1
	MOVWF       _mostrar_pantalla+0 
;p6c.c,39 :: 		}
L_interrupt0:
;p6c.c,40 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;p6c.c,41 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6c.c,42 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p6c.c,43 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p6c.c,44 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6c.c,45 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6c.c,46 :: 		}
L_interrupt3:
;p6c.c,47 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt4
;p6c.c,49 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6c.c,50 :: 		lectura = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _lectura+0 
	MOVLW       0
	MOVWF       _lectura+1 
;p6c.c,51 :: 		lectura += (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _lectura+0, 0 
	ADDWF       R0, 1 
	MOVF        _lectura+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _lectura+0 
	MOVF        R1, 0 
	MOVWF       _lectura+1 
;p6c.c,53 :: 		voltaje = lectura * (5.0/1024.0);
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _voltaje+0 
	MOVF        R1, 0 
	MOVWF       _voltaje+1 
	MOVF        R2, 0 
	MOVWF       _voltaje+2 
	MOVF        R3, 0 
	MOVWF       _voltaje+3 
;p6c.c,54 :: 		temperatura_celsius = 100 * voltaje - 50;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura_celsius+0 
	MOVF        R1, 0 
	MOVWF       _temperatura_celsius+1 
;p6c.c,55 :: 		mostrar_pantalla = 1;
	MOVLW       1
	MOVWF       _mostrar_pantalla+0 
;p6c.c,56 :: 		}
L_interrupt4:
;p6c.c,57 :: 		if(mostrar_pantalla){
	MOVF        _mostrar_pantalla+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
;p6c.c,58 :: 		if(estado_actual == CELSIUS){
	MOVLW       0
	XORWF       _estado_actual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt14
	MOVLW       0
	XORWF       _estado_actual+0, 0 
L__interrupt14:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;p6c.c,59 :: 		temperatura_mostrar = temperatura_celsius;
	MOVF        _temperatura_celsius+0, 0 
	MOVWF       _temperatura_mostrar+0 
	MOVF        _temperatura_celsius+1, 0 
	MOVWF       _temperatura_mostrar+1 
;p6c.c,60 :: 		caracter_temperatura = 'C';
	MOVLW       67
	MOVWF       _caracter_temperatura+0 
;p6c.c,61 :: 		}
L_interrupt6:
;p6c.c,62 :: 		if(estado_actual == KELVIN){
	MOVLW       0
	XORWF       _estado_actual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVLW       2
	XORWF       _estado_actual+0, 0 
L__interrupt15:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;p6c.c,63 :: 		temperatura_mostrar = temperatura_celsius + 273;
	MOVLW       17
	ADDWF       _temperatura_celsius+0, 0 
	MOVWF       _temperatura_mostrar+0 
	MOVLW       1
	ADDWFC      _temperatura_celsius+1, 0 
	MOVWF       _temperatura_mostrar+1 
;p6c.c,64 :: 		caracter_temperatura = 'K';
	MOVLW       75
	MOVWF       _caracter_temperatura+0 
;p6c.c,65 :: 		}
L_interrupt7:
;p6c.c,66 :: 		if(estado_actual == FARENHEIT){
	MOVLW       0
	XORWF       _estado_actual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVLW       1
	XORWF       _estado_actual+0, 0 
L__interrupt16:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;p6c.c,67 :: 		temperatura_mostrar = ((float)temperatura_celsius * 1.8) + 32;
	MOVF        _temperatura_celsius+0, 0 
	MOVWF       R0 
	MOVF        _temperatura_celsius+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       102
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura_mostrar+0 
	MOVF        R1, 0 
	MOVWF       _temperatura_mostrar+1 
;p6c.c,68 :: 		caracter_temperatura = 'F';
	MOVLW       70
	MOVWF       _caracter_temperatura+0 
;p6c.c,69 :: 		}
L_interrupt8:
;p6c.c,70 :: 		mostrar_pantalla = 0;
	CLRF        _mostrar_pantalla+0 
;p6c.c,71 :: 		IntToStr(temperatura_mostrar, texto);
	MOVF        _temperatura_mostrar+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temperatura_mostrar+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;p6c.c,72 :: 		Lcd_Out(1,1, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,73 :: 		Lcd_Chr_Cp(223);
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p6c.c,74 :: 		Lcd_Chr_Cp(caracter_temperatura);
	MOVF        _caracter_temperatura+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p6c.c,75 :: 		}
L_interrupt5:
;p6c.c,76 :: 		}
L_end_interrupt:
L__interrupt12:
	RETFIE      1
; end of _interrupt

_main:

;p6c.c,77 :: 		void main() {
;p6c.c,78 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6c.c,79 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;p6c.c,82 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p6c.c,83 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;p6c.c,85 :: 		INTCON.INTEDG0 = 1;
	BSF         INTCON+0, 6 
;p6c.c,88 :: 		T0CON = 0b00010101;
	MOVLW       21
	MOVWF       T0CON+0 
;p6c.c,89 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6c.c,90 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6c.c,91 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p6c.c,92 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p6c.c,95 :: 		ADCON0 = 0b10011001;
	MOVLW       153
	MOVWF       ADCON0+0 
;p6c.c,96 :: 		ADCON1 = 0b10000100;
	MOVLW       132
	MOVWF       ADCON1+0 
;p6c.c,98 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6c.c,99 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6c.c,102 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6c.c,103 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6c.c,107 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p6c.c,109 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6c.c,110 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6c.c,111 :: 		while(1){ }
L_main9:
	GOTO        L_main9
;p6c.c,112 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
