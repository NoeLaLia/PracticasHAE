
_interrupt:

;p7d.c,20 :: 		void interrupt(){
;p7d.c,22 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;p7d.c,23 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7d.c,24 :: 		lectura = ADRESL + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _lectura+0 
	MOVF        R1, 0 
	MOVWF       _lectura+1 
;p7d.c,25 :: 		voltaje = lectura * (5.0 / 1024.0);
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
;p7d.c,26 :: 		RLdr = 15000 * (5 / voltaje - 1);
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       129
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       96
	MOVWF       R5 
	MOVLW       106
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _RLdr+0 
	MOVF        R1, 0 
	MOVWF       _RLdr+1 
	MOVF        R2, 0 
	MOVWF       _RLdr+2 
	MOVF        R3, 0 
	MOVWF       _RLdr+3 
;p7d.c,27 :: 		Lux =  pow((RLdr / 127410), (-1.0 / 0.8582));
	MOVLW       0
	MOVWF       R4 
	MOVLW       217
	MOVWF       R5 
	MOVLW       120
	MOVWF       R6 
	MOVLW       143
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_pow_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_pow_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_pow_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_pow_x+3 
	MOVLW       62
	MOVWF       FARG_pow_y+0 
	MOVLW       38
	MOVWF       FARG_pow_y+1 
	MOVLW       149
	MOVWF       FARG_pow_y+2 
	MOVLW       127
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
	MOVF        R0, 0 
	MOVWF       _Lux+0 
	MOVF        R1, 0 
	MOVWF       _Lux+1 
	MOVF        R2, 0 
	MOVWF       _Lux+2 
	MOVF        R3, 0 
	MOVWF       _Lux+3 
;p7d.c,28 :: 		FloatToStr(Lux, texto);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;p7d.c,29 :: 		Lcd_Out(1, 1, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7d.c,30 :: 		}
L_interrupt0:
;p7d.c,31 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt1
;p7d.c,32 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7d.c,33 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p7d.c,34 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p7d.c,35 :: 		PORTB.B0++;
	CLRF        R0 
	BTFSC       PORTB+0, 0 
	INCF        R0, 1 
	MOVLW       0
	MOVWF       R1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	BTFSC       R0, 0 
	GOTO        L__interrupt6
	BCF         PORTB+0, 0 
	GOTO        L__interrupt7
L__interrupt6:
	BSF         PORTB+0, 0 
L__interrupt7:
;p7d.c,36 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7d.c,37 :: 		}
L_interrupt1:
;p7d.c,38 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p7d.c,39 :: 		void main() {
;p7d.c,40 :: 		T0CON = 0b00010100;
	MOVLW       20
	MOVWF       T0CON+0 
;p7d.c,42 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7d.c,43 :: 		ADCON0 = 0b10110001;
	MOVLW       177
	MOVWF       ADCON0+0 
;p7d.c,44 :: 		ADCON1 = 0b10000010;
	MOVLW       130
	MOVWF       ADCON1+0 
;p7d.c,45 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7d.c,46 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p7d.c,48 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7d.c,49 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7d.c,52 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p7d.c,53 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7d.c,55 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p7d.c,56 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p7d.c,57 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7d.c,58 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p7d.c,59 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7d.c,60 :: 		while(1){
L_main2:
;p7d.c,61 :: 		}
	GOTO        L_main2
;p7d.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
