
_interrupt:

;c.c,30 :: 		void interrupt(){
;c.c,32 :: 		if(INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;c.c,34 :: 		unsigned char estado_actual = PORTB.B5; // leer puerto
	MOVLW       0
	BTFSC       PORTB+0, 5 
	MOVLW       1
	MOVWF       interrupt_estado_actual_L1+0 
;c.c,36 :: 		if(estado_anterior == 0 && estado_actual == 1)
	MOVF        _estado_anterior+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
	MOVF        interrupt_estado_actual_L1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
L__interrupt6:
;c.c,38 :: 		num++;   // solo flanco de subida
	INCF        _num+0, 1 
;c.c,39 :: 		}
L_interrupt3:
;c.c,40 :: 		estado_anterior = estado_actual;
	MOVF        interrupt_estado_actual_L1+0, 0 
	MOVWF       _estado_anterior+0 
;c.c,41 :: 		}
L_interrupt0:
;c.c,42 :: 		ByteToStr(num, txt);
	MOVF        _num+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _txt+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;c.c,44 :: 		x = PORTB; // para poder borrar el bit RBIF (define x global)
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;c.c,45 :: 		INTCON.RBIF=0; // se borra el bit RBIF después de llamar a la función tecla()
	BCF         INTCON+0, 0 
;c.c,46 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_main:

;c.c,48 :: 		void main()
;c.c,52 :: 		ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;c.c,55 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;c.c,56 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;c.c,59 :: 		Lcd_Init ();
	CALL        _Lcd_Init+0, 0
;c.c,60 :: 		Lcd_Out(1,1, "Turno:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;c.c,61 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;c.c,63 :: 		INTCON2.RBPU = 0; // se habilitan las resistencias de pullup del puerto B
	BCF         INTCON2+0, 7 
;c.c,64 :: 		x = PORTB; // para poder borrar el RBIF
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;c.c,65 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;c.c,66 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;c.c,67 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;c.c,69 :: 		while(1) //bucle infinito
L_main4:
;c.c,71 :: 		Lcd_Out(1,7,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;c.c,72 :: 		}
	GOTO        L_main4
;c.c,73 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
