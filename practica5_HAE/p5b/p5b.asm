
_interrupt:

;p5b.c,4 :: 		void interrupt(){
;p5b.c,12 :: 		char a = PORTA.B0;
	MOVLW       0
	BTFSC       PORTA+0, 0 
	MOVLW       1
	MOVWF       R2 
;p5b.c,13 :: 		if(Q == 0){
	MOVF        _Q+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p5b.c,14 :: 		if(a == 0){
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;p5b.c,16 :: 		Q = 0;
	CLRF        _Q+0 
;p5b.c,17 :: 		}
L_interrupt1:
;p5b.c,18 :: 		if(a == 1){
	MOVF        R2, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;p5b.c,19 :: 		Q = 1;
	MOVLW       1
	MOVWF       _Q+0 
;p5b.c,20 :: 		}
L_interrupt2:
;p5b.c,21 :: 		}
L_interrupt0:
;p5b.c,22 :: 		if(Q == 1){
	MOVF        _Q+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;p5b.c,23 :: 		if(a == 0){
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;p5b.c,24 :: 		Q = 2;
	MOVLW       2
	MOVWF       _Q+0 
;p5b.c,25 :: 		PORTA.B3++;
	CLRF        R0 
	BTFSC       PORTA+0, 3 
	INCF        R0, 1 
	MOVLW       0
	MOVWF       R1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	BTFSC       R0, 0 
	GOTO        L__interrupt11
	BCF         PORTA+0, 3 
	GOTO        L__interrupt12
L__interrupt11:
	BSF         PORTA+0, 3 
L__interrupt12:
;p5b.c,26 :: 		}
L_interrupt4:
;p5b.c,27 :: 		if(a == 1){
	MOVF        R2, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;p5b.c,29 :: 		Q = 1;
	MOVLW       1
	MOVWF       _Q+0 
;p5b.c,30 :: 		}
L_interrupt5:
;p5b.c,31 :: 		}
L_interrupt3:
;p5b.c,32 :: 		if(Q == 2){
	MOVF        _Q+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;p5b.c,33 :: 		Q = 0;
	CLRF        _Q+0 
;p5b.c,34 :: 		}
L_interrupt6:
;p5b.c,35 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p5b.c,36 :: 		TMR0H = (alfa >> 8);
	CLRF        TMR0H+0 
;p5b.c,37 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p5b.c,39 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;p5b.c,41 :: 		void main() {
;p5b.c,42 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p5b.c,43 :: 		TRISA.B0 = 1;
	BSF         TRISA+0, 0 
;p5b.c,44 :: 		TRISA.B3 = 0;
	BCF         TRISA+0, 3 
;p5b.c,46 :: 		T0CON = 0b10010001;
	MOVLW       145
	MOVWF       T0CON+0 
;p5b.c,47 :: 		INTCON.TMR0IF = 0; // se pone el flag a 0
	BCF         INTCON+0, 2 
;p5b.c,48 :: 		INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
	BSF         INTCON+0, 5 
;p5b.c,49 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p5b.c,51 :: 		TMR0H = (alfa >> 8);
	CLRF        TMR0H+0 
;p5b.c,52 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p5b.c,56 :: 		while(1){
L_main7:
;p5b.c,58 :: 		}
	GOTO        L_main7
;p5b.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
