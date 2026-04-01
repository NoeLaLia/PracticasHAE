
_interrupt:

;p8f.c,11 :: 		void interrupt(){
;p8f.c,13 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;p8f.c,15 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p8f.c,16 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p8f.c,17 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p8f.c,18 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p8f.c,19 :: 		}
L_interrupt0:
;p8f.c,20 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;p8f.c,21 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p8f.c,23 :: 		lectura = ADRESL + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       _lectura+0 
	MOVF        R4, 0 
	MOVWF       _lectura+1 
;p8f.c,25 :: 		SPI1_Write(lectura >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
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
;p8f.c,26 :: 		SPI1_Write(lectura << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        _lectura+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8f.c,27 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8f.c,28 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8f.c,31 :: 		}
L_interrupt1:
;p8f.c,32 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p8f.c,34 :: 		void main() {
;p8f.c,35 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p8f.c,36 :: 		TRISC.B6 = 0;
	BCF         TRISC+0, 6 
;p8f.c,37 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;p8f.c,39 :: 		ADCON0 = 0b10010001;
	MOVLW       145
	MOVWF       ADCON0+0 
;p8f.c,41 :: 		ADCON1 = 0b10000000;
	MOVLW       128
	MOVWF       ADCON1+0 
;p8f.c,43 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p8f.c,44 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p8f.c,46 :: 		T0CON = 0b00011000;
	MOVLW       24
	MOVWF       T0CON+0 
;p8f.c,48 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p8f.c,49 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p8f.c,50 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p8f.c,51 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p8f.c,54 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p8f.c,55 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p8f.c,56 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p8f.c,57 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p8f.c,59 :: 		while(1){
L_main2:
;p8f.c,60 :: 		}
	GOTO        L_main2
;p8f.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
