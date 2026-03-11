
_interrupt:

;p6b.c,19 :: 		void interrupt(){
;p6b.c,21 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;p6b.c,22 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6b.c,23 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p6b.c,24 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p6b.c,25 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6b.c,26 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6b.c,27 :: 		}
L_interrupt0:
;p6b.c,28 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;p6b.c,29 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6b.c,30 :: 		lectura = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _lectura+0 
	MOVLW       0
	MOVWF       _lectura+1 
;p6b.c,31 :: 		lectura += (ADRESH << 8);
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
;p6b.c,33 :: 		voltaje = lectura * (5.0/1024.0);
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
;p6b.c,34 :: 		temperatura = 100 * voltaje - 50;
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
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
;p6b.c,35 :: 		IntToStr(temperatura, texto);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;p6b.c,36 :: 		Lcd_Out(1,1, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6b.c,37 :: 		Lcd_Chr_Cp(223);
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p6b.c,38 :: 		}
L_interrupt1:
;p6b.c,39 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p6b.c,40 :: 		void main() {
;p6b.c,41 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6b.c,44 :: 		T0CON = 0b00010101;
	MOVLW       21
	MOVWF       T0CON+0 
;p6b.c,45 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6b.c,46 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6b.c,47 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p6b.c,48 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p6b.c,51 :: 		ADCON0 = 0b10011001;
	MOVLW       153
	MOVWF       ADCON0+0 
;p6b.c,52 :: 		ADCON1 = 0b10000100;
	MOVLW       132
	MOVWF       ADCON1+0 
;p6b.c,54 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6b.c,55 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6b.c,58 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6b.c,59 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6b.c,63 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p6b.c,65 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6b.c,66 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6b.c,67 :: 		while(1){ }
L_main2:
	GOTO        L_main2
;p6b.c,68 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
