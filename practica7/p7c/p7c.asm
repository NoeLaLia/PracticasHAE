
_interrupt:

;p7c.c,18 :: 		void interrupt(){
;p7c.c,20 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;p7c.c,21 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7c.c,22 :: 		lectura = ADRESL + (ADRESH << 8);
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
;p7c.c,23 :: 		voltaje = lectura * (5.0 / 1024.0);
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
;p7c.c,24 :: 		FloatToStr(voltaje, texto);
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
;p7c.c,25 :: 		Lcd_Out(1, 1, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7c.c,26 :: 		}
L_interrupt0:
;p7c.c,27 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt1
;p7c.c,28 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7c.c,29 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p7c.c,30 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p7c.c,31 :: 		PORTB.B0++;
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
;p7c.c,32 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7c.c,33 :: 		}
L_interrupt1:
;p7c.c,34 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p7c.c,35 :: 		void main() {
;p7c.c,36 :: 		T0CON = 0b00010100;
	MOVLW       20
	MOVWF       T0CON+0 
;p7c.c,38 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7c.c,39 :: 		ADCON0 = 0b10110001;
	MOVLW       177
	MOVWF       ADCON0+0 
;p7c.c,40 :: 		ADCON1 = 0b10000010;
	MOVLW       130
	MOVWF       ADCON1+0 
;p7c.c,41 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7c.c,42 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p7c.c,44 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7c.c,45 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7c.c,48 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p7c.c,49 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7c.c,51 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p7c.c,52 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p7c.c,53 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7c.c,54 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p7c.c,55 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7c.c,56 :: 		while(1){
L_main2:
;p7c.c,57 :: 		}
	GOTO        L_main2
;p7c.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
