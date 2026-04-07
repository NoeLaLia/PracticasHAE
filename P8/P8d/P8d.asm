
_escritura:

;P8d.c,7 :: 		void escritura(int valorDAC) {
;P8d.c,8 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;P8d.c,10 :: 		SPI1_Write(valorDAC >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        FARG_escritura_valorDAC+0, 0 
	MOVWF       R0 
	MOVF        FARG_escritura_valorDAC+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__escritura12:
	BZ          L__escritura13
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__escritura12
L__escritura13:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;P8d.c,11 :: 		SPI1_Write(valorDAC << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        FARG_escritura_valorDAC+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;P8d.c,13 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;P8d.c,14 :: 		}
L_end_escritura:
	RETURN      0
; end of _escritura

_main:

;P8d.c,15 :: 		void main() {
;P8d.c,16 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;P8d.c,18 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;P8d.c,20 :: 		while(1) {
L_main0:
;P8d.c,21 :: 		escritura(salida2_5);
	MOVF        _salida2_5+0, 0 
	MOVWF       FARG_escritura_valorDAC+0 
	MOVF        _salida2_5+1, 0 
	MOVWF       FARG_escritura_valorDAC+1 
	CALL        _escritura+0, 0
;P8d.c,22 :: 		delay_ms(70);
	MOVLW       182
	MOVWF       R12, 0
	MOVLW       208
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
;P8d.c,24 :: 		for(i = salida2_5; i < salida5; i++) {
	MOVF        _salida2_5+0, 0 
	MOVWF       _i+0 
	MOVF        _salida2_5+1, 0 
	MOVWF       _i+1 
L_main3:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _salida5+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
	MOVF        _salida5+0, 0 
	SUBWF       _i+0, 0 
L__main15:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;P8d.c,25 :: 		escritura(i);
	MOVF        _i+0, 0 
	MOVWF       FARG_escritura_valorDAC+0 
	MOVF        _i+1, 0 
	MOVWF       FARG_escritura_valorDAC+1 
	CALL        _escritura+0, 0
;P8d.c,26 :: 		delay_us(54);
	MOVLW       35
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	NOP
	NOP
;P8d.c,24 :: 		for(i = salida2_5; i < salida5; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;P8d.c,27 :: 		}
	GOTO        L_main3
L_main4:
;P8d.c,28 :: 		escritura(salida0);
	MOVF        _salida0+0, 0 
	MOVWF       FARG_escritura_valorDAC+0 
	MOVF        _salida0+1, 0 
	MOVWF       FARG_escritura_valorDAC+1 
	CALL        _escritura+0, 0
;P8d.c,29 :: 		for(i = salida0; i < salida2_5; i++) {
	MOVF        _salida0+0, 0 
	MOVWF       _i+0 
	MOVF        _salida0+1, 0 
	MOVWF       _i+1 
L_main7:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _salida2_5+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVF        _salida2_5+0, 0 
	SUBWF       _i+0, 0 
L__main16:
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;P8d.c,30 :: 		escritura(i);
	MOVF        _i+0, 0 
	MOVWF       FARG_escritura_valorDAC+0 
	MOVF        _i+1, 0 
	MOVWF       FARG_escritura_valorDAC+1 
	CALL        _escritura+0, 0
;P8d.c,31 :: 		delay_us(54);
	MOVLW       35
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	NOP
	NOP
;P8d.c,29 :: 		for(i = salida0; i < salida2_5; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;P8d.c,32 :: 		}
	GOTO        L_main7
L_main8:
;P8d.c,33 :: 		}
	GOTO        L_main0
;P8d.c,36 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
