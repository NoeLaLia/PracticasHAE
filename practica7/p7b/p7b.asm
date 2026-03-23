
_interrupt:

;p7b.c,2 :: 		void interrupt(){
;p7b.c,3 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;p7b.c,4 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7b.c,5 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p7b.c,6 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p7b.c,7 :: 		PORTB.B0++;
	CLRF        R0 
	BTFSC       PORTB+0, 0 
	INCF        R0, 1 
	MOVLW       0
	MOVWF       R1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	BTFSC       R0, 0 
	GOTO        L__interrupt5
	BCF         PORTB+0, 0 
	GOTO        L__interrupt6
L__interrupt5:
	BSF         PORTB+0, 0 
L__interrupt6:
;p7b.c,8 :: 		}
L_interrupt0:
;p7b.c,9 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;p7b.c,10 :: 		void main() {
;p7b.c,11 :: 		T0CON = 0b00010100;
	MOVLW       20
	MOVWF       T0CON+0 
;p7b.c,13 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7b.c,14 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p7b.c,15 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7b.c,16 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7b.c,17 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7b.c,19 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;p7b.c,20 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;p7b.c,21 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7b.c,22 :: 		while(1){
L_main1:
;p7b.c,23 :: 		}
	GOTO        L_main1
;p7b.c,24 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
