
_interrupt:

;p4c.c,20 :: 		void interrupt(){
;p4c.c,21 :: 		char textoInicial[] = {"Turno:   0"};
	MOVLW       84
	MOVWF       interrupt_textoInicial_L0+0 
	MOVLW       117
	MOVWF       interrupt_textoInicial_L0+1 
	MOVLW       114
	MOVWF       interrupt_textoInicial_L0+2 
	MOVLW       110
	MOVWF       interrupt_textoInicial_L0+3 
	MOVLW       111
	MOVWF       interrupt_textoInicial_L0+4 
	MOVLW       58
	MOVWF       interrupt_textoInicial_L0+5 
	MOVLW       32
	MOVWF       interrupt_textoInicial_L0+6 
	MOVLW       32
	MOVWF       interrupt_textoInicial_L0+7 
	MOVLW       32
	MOVWF       interrupt_textoInicial_L0+8 
	MOVLW       48
	MOVWF       interrupt_textoInicial_L0+9 
	CLRF        interrupt_textoInicial_L0+10 
;p4c.c,23 :: 		if(!primeraVez){
	MOVF        _primeraVez+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p4c.c,24 :: 		Lcd_Out(1,1, textoInicial);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_textoInicial_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_textoInicial_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p4c.c,25 :: 		primeraVez = 1;
	MOVLW       1
	MOVWF       _primeraVez+0 
;p4c.c,26 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;p4c.c,28 :: 		if(PORTB.B5 == 1){
	BTFSS       PORTB+0, 5 
	GOTO        L_interrupt2
;p4c.c,29 :: 		turno++;
	INCF        _turno+0, 1 
;p4c.c,30 :: 		ByteToStr(turno, texto);
	MOVF        _turno+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;p4c.c,31 :: 		Lcd_Out(1,8, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_texto_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p4c.c,33 :: 		}
L_interrupt2:
;p4c.c,34 :: 		}
L_interrupt1:
;p4c.c,35 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p4c.c,36 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;p4c.c,37 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;p4c.c,39 :: 		void main() {
;p4c.c,40 :: 		turno = 0;
	CLRF        _turno+0 
;p4c.c,41 :: 		primeraVez = 0;
	CLRF        _primeraVez+0 
;p4c.c,42 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p4c.c,43 :: 		TRISD = 0;
	CLRF        TRISD+0 
;p4c.c,44 :: 		TRISB.B5 = 1;
	BSF         TRISB+0, 5 
;p4c.c,45 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p4c.c,46 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;p4c.c,47 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;p4c.c,48 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p4c.c,50 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p4c.c,52 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p4c.c,53 :: 		INTCON.RBIF = 1;
	BSF         INTCON+0, 0 
;p4c.c,55 :: 		while(1){}
L_main3:
	GOTO        L_main3
;p4c.c,56 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
