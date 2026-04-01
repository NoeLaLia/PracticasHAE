
_main:

;p8d.c,1 :: 		void main() {
;p8d.c,2 :: 		char i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_valor_L0+0 
	CLRF        main_valor_L0+1 
	CLRF        main_valor_L0+2 
	CLRF        main_valor_L0+3 
	CLRF        main_D_L0+0 
	CLRF        main_D_L0+1 
;p8d.c,8 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p8d.c,10 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p8d.c,11 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;p8d.c,13 :: 		SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        main_D_L0+0, 0 
	MOVWF       R0 
	MOVF        main_D_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main13:
	BZ          L__main14
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main13
L__main14:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,14 :: 		SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,16 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,17 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,19 :: 		while(1){
L_main0:
;p8d.c,21 :: 		for(i = 0; i < 100; i++){
	CLRF        main_i_L0+0 
L_main2:
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p8d.c,22 :: 		SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        main_D_L0+0, 0 
	MOVWF       R0 
	MOVF        main_D_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main15:
	BZ          L__main16
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main15
L__main16:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,23 :: 		SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,24 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,25 :: 		delay_us(270);
	MOVLW       179
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	NOP
	NOP
;p8d.c,26 :: 		valor += 5.12;
	MOVF        main_valor_L0+0, 0 
	MOVWF       R0 
	MOVF        main_valor_L0+1, 0 
	MOVWF       R1 
	MOVF        main_valor_L0+2, 0 
	MOVWF       R2 
	MOVF        main_valor_L0+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_valor_L0+0 
	MOVF        R1, 0 
	MOVWF       main_valor_L0+1 
	MOVF        R2, 0 
	MOVWF       main_valor_L0+2 
	MOVF        R3, 0 
	MOVWF       main_valor_L0+3 
;p8d.c,27 :: 		D = (int)valor;
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       main_D_L0+0 
	MOVF        R1, 0 
	MOVWF       main_D_L0+1 
;p8d.c,28 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,21 :: 		for(i = 0; i < 100; i++){
	INCF        main_i_L0+0, 1 
;p8d.c,29 :: 		}
	GOTO        L_main2
L_main3:
;p8d.c,31 :: 		valor = 512;
	MOVLW       0
	MOVWF       main_valor_L0+0 
	MOVLW       0
	MOVWF       main_valor_L0+1 
	MOVLW       0
	MOVWF       main_valor_L0+2 
	MOVLW       136
	MOVWF       main_valor_L0+3 
;p8d.c,32 :: 		D = 512;
	MOVLW       0
	MOVWF       main_D_L0+0 
	MOVLW       2
	MOVWF       main_D_L0+1 
;p8d.c,34 :: 		SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        main_D_L0+0, 0 
	MOVWF       R0 
	MOVF        main_D_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main17:
	BZ          L__main18
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main17
L__main18:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,35 :: 		SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,36 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,37 :: 		delay_ms(70);
	MOVLW       182
	MOVWF       R12, 0
	MOVLW       208
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
;p8d.c,38 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,40 :: 		for(i = 0; i < 100; i++){
	CLRF        main_i_L0+0 
L_main7:
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;p8d.c,41 :: 		SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        main_D_L0+0, 0 
	MOVWF       R0 
	MOVF        main_D_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main19:
	BZ          L__main20
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main19
L__main20:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,42 :: 		SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,43 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,44 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,45 :: 		delay_us(270);
	MOVLW       179
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	NOP
	NOP
;p8d.c,46 :: 		valor += 5.12;
	MOVF        main_valor_L0+0, 0 
	MOVWF       R0 
	MOVF        main_valor_L0+1, 0 
	MOVWF       R1 
	MOVF        main_valor_L0+2, 0 
	MOVWF       R2 
	MOVF        main_valor_L0+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_valor_L0+0 
	MOVF        R1, 0 
	MOVWF       main_valor_L0+1 
	MOVF        R2, 0 
	MOVWF       main_valor_L0+2 
	MOVF        R3, 0 
	MOVWF       main_valor_L0+3 
;p8d.c,47 :: 		D = (int)valor;
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       main_D_L0+0 
	MOVF        R1, 0 
	MOVWF       main_D_L0+1 
;p8d.c,40 :: 		for(i = 0; i < 100; i++){
	INCF        main_i_L0+0, 1 
;p8d.c,48 :: 		}
	GOTO        L_main7
L_main8:
;p8d.c,50 :: 		valor = 0;
	CLRF        main_valor_L0+0 
	CLRF        main_valor_L0+1 
	CLRF        main_valor_L0+2 
	CLRF        main_valor_L0+3 
;p8d.c,51 :: 		D = 0;
	CLRF        main_D_L0+0 
	CLRF        main_D_L0+1 
;p8d.c,52 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,53 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,54 :: 		SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
	MOVLW       6
	MOVWF       R2 
	MOVF        main_D_L0+0, 0 
	MOVWF       R0 
	MOVF        main_D_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main21:
	BZ          L__main22
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__main21
L__main22:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,55 :: 		SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,56 :: 		delay_us(56);
	MOVLW       37
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
;p8d.c,58 :: 		}
	GOTO        L_main0
;p8d.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
