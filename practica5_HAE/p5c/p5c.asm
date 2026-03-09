
_interrupt:

;p5c.c,4 :: 		void interrupt(){
;p5c.c,7 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;p5c.c,8 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p5c.c,10 :: 		if(!timer_activo){
	MOVF        _timer_activo+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;p5c.c,11 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p5c.c,12 :: 		timer_activo = 1;
	MOVLW       1
	MOVWF       _timer_activo+0 
;p5c.c,13 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p5c.c,14 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p5c.c,15 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p5c.c,17 :: 		}
L_interrupt1:
;p5c.c,18 :: 		}
L_interrupt0:
;p5c.c,20 :: 		if(INTCON3.INT1IF){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt2
;p5c.c,21 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p5c.c,22 :: 		if(!timer_activo){
	MOVF        _timer_activo+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;p5c.c,23 :: 		PORTC.B6 = 1;
	BSF         PORTC+0, 6 
;p5c.c,24 :: 		timer_activo = 1;
	MOVLW       1
	MOVWF       _timer_activo+0 
;p5c.c,25 :: 		TMR0H = (beta >> 8);
	MOVF        _beta+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _beta+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p5c.c,26 :: 		TMR0L = beta;
	MOVF        _beta+0, 0 
	MOVWF       TMR0L+0 
;p5c.c,27 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p5c.c,28 :: 		}
L_interrupt3:
;p5c.c,29 :: 		}
L_interrupt2:
;p5c.c,30 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;p5c.c,31 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p5c.c,32 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p5c.c,33 :: 		PORTC.B6 = 0;
	BCF         PORTC+0, 6 
;p5c.c,34 :: 		timer_activo = 0;
	CLRF        _timer_activo+0 
;p5c.c,35 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p5c.c,37 :: 		}
L_interrupt4:
;p5c.c,38 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_main:

;p5c.c,39 :: 		void main() {
;p5c.c,40 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p5c.c,41 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;p5c.c,42 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;p5c.c,43 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p5c.c,44 :: 		TRISC.B6 = 0;
	BCF         TRISC+0, 6 
;p5c.c,47 :: 		INTCON2.INTEDG0 = 1;
	BSF         INTCON2+0, 6 
;p5c.c,48 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p5c.c,49 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;p5c.c,52 :: 		INTCON2.INTEDG1 = 1;
	BSF         INTCON2+0, 5 
;p5c.c,53 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p5c.c,54 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;p5c.c,56 :: 		T0CON = 0b00010110;
	MOVLW       22
	MOVWF       T0CON+0 
;p5c.c,58 :: 		INTCON.TMR0IF = 0; // se pone el flag a 0
	BCF         INTCON+0, 2 
;p5c.c,59 :: 		INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
	BSF         INTCON+0, 5 
;p5c.c,65 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p5c.c,68 :: 		while(1){
L_main5:
;p5c.c,71 :: 		}
	GOTO        L_main5
;p5c.c,72 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
