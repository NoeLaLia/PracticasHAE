
_interrupt:

;P8f.c,5 :: 		void interrupt() {
;P8f.c,6 :: 		if(INTCON.TMR0IF == 1) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;P8f.c,7 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;P8f.c,8 :: 		SPI1_Write(valorMuestreo >> 6);
	MOVLW       6
	MOVWF       R2 
	MOVF        _valorMuestreo+0, 0 
	MOVWF       R0 
	MOVF        _valorMuestreo+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__interrupt6:
	BZ          L__interrupt7
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__interrupt6
L__interrupt7:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;P8f.c,9 :: 		SPI1_Write(valorMuestreo << 2);
	MOVF        _valorMuestreo+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;P8f.c,11 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;P8f.c,12 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;P8f.c,13 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;P8f.c,14 :: 		T0CON.B7 = 1;
	BSF         T0CON+0, 7 
;P8f.c,15 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;P8f.c,17 :: 		}
L_interrupt0:
;P8f.c,18 :: 		if(PIR1.ADIF == 1) {
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;P8f.c,19 :: 		voltaje = ADRESL + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _voltaje+0 
	MOVF        R3, 0 
	MOVWF       _voltaje+1 
;P8f.c,20 :: 		valorMuestreo = voltaje * 4;
	MOVF        R2, 0 
	MOVWF       _valorMuestreo+0 
	MOVF        R3, 0 
	MOVWF       _valorMuestreo+1 
	RLCF        _valorMuestreo+0, 1 
	BCF         _valorMuestreo+0, 0 
	RLCF        _valorMuestreo+1, 1 
	RLCF        _valorMuestreo+0, 1 
	BCF         _valorMuestreo+0, 0 
	RLCF        _valorMuestreo+1, 1 
;P8f.c,22 :: 		ADCON0.B2 = 1; // lanza nueva conversión
	BSF         ADCON0+0, 2 
;P8f.c,23 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;P8f.c,24 :: 		}
L_interrupt1:
;P8f.c,28 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;P8f.c,30 :: 		void main() {
;P8f.c,31 :: 		TRISA.B2 = 1;
	BSF         TRISA+0, 2 
;P8f.c,32 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;P8f.c,34 :: 		T0CON = 0x10;
	MOVLW       16
	MOVWF       T0CON+0 
;P8f.c,35 :: 		ADCON0 = 0x51;
	MOVLW       81
	MOVWF       ADCON0+0 
;P8f.c,36 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;P8f.c,38 :: 		INTCON.TMR0IF = 0; // se pone el flag a 0
	BCF         INTCON+0, 2 
;P8f.c,39 :: 		INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
	BSF         INTCON+0, 5 
;P8f.c,41 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;P8f.c,42 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;P8f.c,43 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;P8f.c,44 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;P8f.c,46 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;P8f.c,47 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;P8f.c,49 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;P8f.c,51 :: 		T0CON.B7 = 1;
	BSF         T0CON+0, 7 
;P8f.c,53 :: 		ADCON0.B2 = 1; // lanza nueva conversión
	BSF         ADCON0+0, 2 
;P8f.c,57 :: 		while(1) {
L_main2:
;P8f.c,59 :: 		}
	GOTO        L_main2
;P8f.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
