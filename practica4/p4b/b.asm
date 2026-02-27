
_interrupt:

;b.c,29 :: 		void interrupt(){
;b.c,31 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;b.c,33 :: 		unsigned char estado_actual = PORTB.B5; // leer puerto
	MOVLW       0
	BTFSC       PORTB+0, 5 
	MOVLW       1
	MOVWF       interrupt_estado_actual_L1+0 
;b.c,35 :: 		if(estado_anterior == 0 && estado_actual == 1)
	MOVF        _estado_anterior+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVF        interrupt_estado_actual_L1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
L__interrupt6:
;b.c,37 :: 		num++;   // solo flanco de subida
	INCF        _num+0, 1 
;b.c,38 :: 		}
L_interrupt3:
;b.c,39 :: 		estado_anterior = estado_actual;
	MOVF        interrupt_estado_actual_L1+0, 0 
	MOVWF       _estado_anterior+0 
;b.c,40 :: 		}
L_interrupt0:
;b.c,41 :: 		ByteToStr(num, txt);
	MOVF        _num+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       interrupt_txt_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(interrupt_txt_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;b.c,42 :: 		Lcd_Out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;b.c,44 :: 		x = PORTB; // para poder borrar el bit RBIF (define x global)
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;b.c,45 :: 		INTCON.RBIF=0; // se borra el bit RBIF después de llamar a la función tecla()
	BCF         INTCON+0, 0 
;b.c,46 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_main:

;b.c,48 :: 		void main()
;b.c,52 :: 		ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;b.c,55 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;b.c,56 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;b.c,59 :: 		Lcd_Init ();
	CALL        _Lcd_Init+0, 0
;b.c,61 :: 		INTCON2.RBPU = 0; // se habilitan las resistencias de pullup del puerto B
	BCF         INTCON2+0, 7 
;b.c,62 :: 		x = PORTB; // para poder borrar el RBIF
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;b.c,63 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;b.c,64 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;b.c,65 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;b.c,67 :: 		while(1) //bucle infinito
L_main4:
;b.c,70 :: 		}
	GOTO        L_main4
;b.c,71 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
