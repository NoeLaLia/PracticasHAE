
_interrupt:

;p3b.c,1 :: 		void interrupt(){
;p3b.c,3 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;p3b.c,4 :: 		PORTB.B3 += 1;
	CLRF        R0 
	BTFSC       PORTB+0, 3 
	INCF        R0, 1 
	INCF        R0, 1 
	BTFSC       R0, 0 
	GOTO        L__interrupt4
	BCF         PORTB+0, 3 
	GOTO        L__interrupt5
L__interrupt4:
	BSF         PORTB+0, 3 
L__interrupt5:
;p3b.c,5 :: 		}
L_end_interrupt:
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;p3b.c,7 :: 		void main() {
;p3b.c,8 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p3b.c,9 :: 		TRISB.B2 = 1; // se configura RB2 como entrada
	BSF         TRISB+0, 2 
;p3b.c,10 :: 		INTCON2.INTEDG2 = 1; //la interrupción la provoca flanco de subida
	BSF         INTCON2+0, 4 
;p3b.c,11 :: 		INTCON3.INT2IF = 0; // se pone el flag de la interrupción INT2 a 0
	BCF         INTCON3+0, 1 
;p3b.c,12 :: 		INTCON3.INT2IE = 1; // se habilita la interrupción INT2
	BSF         INTCON3+0, 4 
;p3b.c,13 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p3b.c,15 :: 		TRISB.B3 = 0;
	BCF         TRISB+0, 3 
;p3b.c,16 :: 		while(1){
L_main0:
;p3b.c,18 :: 		}
	GOTO        L_main0
;p3b.c,19 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
