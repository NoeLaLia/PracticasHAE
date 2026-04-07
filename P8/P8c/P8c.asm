
_main:

;P8c.c,3 :: 		void main() {
;P8c.c,4 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;P8c.c,6 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;P8c.c,9 :: 		while(1) {
L_main0:
;P8c.c,10 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;P8c.c,12 :: 		SPI1_Write(salida >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        _salida+0, 0 
	MOVWF       R0 
	MOVF        _salida+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main3:
	BZ          L__main4
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main3
L__main4:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;P8c.c,13 :: 		SPI1_Write(salida << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        _salida+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;P8c.c,15 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;P8c.c,17 :: 		}
	GOTO        L_main0
;P8c.c,19 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
