
_interrupt:

;p6a.c,18 :: 		void interrupt(){
;p6a.c,20 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;p6a.c,21 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6a.c,22 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p6a.c,23 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p6a.c,24 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6a.c,25 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6a.c,26 :: 		}
L_interrupt0:
;p6a.c,27 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;p6a.c,28 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6a.c,29 :: 		lectura = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _lectura+0 
	MOVLW       0
	MOVWF       _lectura+1 
;p6a.c,30 :: 		lectura += (ADRESH << 8);
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
;p6a.c,32 :: 		voltaje = lectura * (5.0 / 1024.0);
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
;p6a.c,33 :: 		FloatToStr(voltaje, escribir);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       interrupt_escribir_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(interrupt_escribir_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;p6a.c,34 :: 		Lcd_Out(1, 1, escribir);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_escribir_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_escribir_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6a.c,35 :: 		}
L_interrupt1:
;p6a.c,36 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p6a.c,38 :: 		void main() {
;p6a.c,39 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6a.c,41 :: 		T0CON = 0b00010100;
	MOVLW       20
	MOVWF       T0CON+0 
;p6a.c,43 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6a.c,44 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6a.c,45 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p6a.c,46 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p6a.c,48 :: 		ADCON1 = 0b10000100;
	MOVLW       132
	MOVWF       ADCON1+0 
;p6a.c,50 :: 		ADCON0 = 0b10011001;
	MOVLW       153
	MOVWF       ADCON0+0 
;p6a.c,55 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6a.c,57 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6a.c,59 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6a.c,60 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6a.c,61 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p6a.c,63 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6a.c,64 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6a.c,65 :: 		while(1){
L_main2:
;p6a.c,67 :: 		}
	GOTO        L_main2
;p6a.c,68 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
