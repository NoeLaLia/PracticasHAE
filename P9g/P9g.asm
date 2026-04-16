
_cambiar_canal:

;P9g.c,17 :: 		void cambiar_canal(unsigned char c) {
;P9g.c,18 :: 		ADCON0 = (c << 3) | 0x41;
	MOVF        FARG_cambiar_canal_c+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       65
	IORWF       R0, 0 
	MOVWF       ADCON0+0 
;P9g.c,19 :: 		canal = c;
	MOVF        FARG_cambiar_canal_c+0, 0 
	MOVWF       _canal+0 
	MOVLW       0
	MOVWF       _canal+1 
;P9g.c,20 :: 		}
L_end_cambiar_canal:
	RETURN      0
; end of _cambiar_canal

_interrupt:

;P9g.c,22 :: 		void interrupt() {
;P9g.c,23 :: 		vs = voltaje_vs*(5/1024);
	CLRF        _vs+0 
	CLRF        _vs+1 
;P9g.c,24 :: 		vref = voltaje_vref*(5/1024);
	CLRF        _vref+0 
	CLRF        _vref+1 
;P9g.c,26 :: 		if(INTCON.TMR0IF == 1) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;P9g.c,27 :: 		if (PORTA.B4 == 0) {
	BTFSC       PORTA+0, 4 
	GOTO        L_interrupt1
;P9g.c,28 :: 		estado = APAGADO;
	CLRF        _estado+0 
	CLRF        _estado+1 
;P9g.c,29 :: 		PORTA.B2 = 0; // c = 0
	BCF         PORTA+0, 2 
;P9g.c,30 :: 		} else {
	GOTO        L_interrupt2
L_interrupt1:
;P9g.c,32 :: 		switch(estado) {
	GOTO        L_interrupt3
;P9g.c,33 :: 		case APAGADO:
L_interrupt5:
;P9g.c,34 :: 		estado = CALENTANDO;
	MOVLW       1
	MOVWF       _estado+0 
	MOVLW       0
	MOVWF       _estado+1 
;P9g.c,35 :: 		break;
	GOTO        L_interrupt4
;P9g.c,37 :: 		case CALENTANDO:
L_interrupt6:
;P9g.c,38 :: 		PORTA.B2 = 1; // Encender resistencia
	BSF         PORTA+0, 2 
;P9g.c,39 :: 		if (vs >= (vref + alfa_adc)) {
	MOVF        _alfa_adc+0, 0 
	ADDWF       _vref+0, 0 
	MOVWF       R1 
	MOVF        _alfa_adc+1, 0 
	ADDWFC      _vref+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       _vs+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt20
	MOVF        R1, 0 
	SUBWF       _vs+0, 0 
L__interrupt20:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt7
;P9g.c,40 :: 		estado = ENFRIANDO;
	MOVLW       2
	MOVWF       _estado+0 
	MOVLW       0
	MOVWF       _estado+1 
;P9g.c,41 :: 		}
L_interrupt7:
;P9g.c,42 :: 		break;
	GOTO        L_interrupt4
;P9g.c,44 :: 		case ENFRIANDO:
L_interrupt8:
;P9g.c,45 :: 		PORTA.B2 = 0; // Apagar resistencia
	BCF         PORTA+0, 2 
;P9g.c,46 :: 		if (vs <= (vref - alfa_adc)) {
	MOVF        _alfa_adc+0, 0 
	SUBWF       _vref+0, 0 
	MOVWF       R1 
	MOVF        _alfa_adc+1, 0 
	SUBWFB      _vref+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _vs+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt21
	MOVF        _vs+0, 0 
	SUBWF       R1, 0 
L__interrupt21:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;P9g.c,47 :: 		estado = CALENTANDO;
	MOVLW       1
	MOVWF       _estado+0 
	MOVLW       0
	MOVWF       _estado+1 
;P9g.c,48 :: 		}
L_interrupt9:
;P9g.c,49 :: 		break;
	GOTO        L_interrupt4
;P9g.c,50 :: 		}
L_interrupt3:
	MOVLW       0
	XORWF       _estado+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt22
	MOVLW       0
	XORWF       _estado+0, 0 
L__interrupt22:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
	MOVLW       0
	XORWF       _estado+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt23
	MOVLW       1
	XORWF       _estado+0, 0 
L__interrupt23:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt6
	MOVLW       0
	XORWF       _estado+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt24
	MOVLW       2
	XORWF       _estado+0, 0 
L__interrupt24:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt8
L_interrupt4:
;P9g.c,51 :: 		}
L_interrupt2:
;P9g.c,52 :: 		ADCON0.B2 = 1;
	BSF         ADCON0+0, 2 
;P9g.c,53 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;P9g.c,54 :: 		}
L_interrupt0:
;P9g.c,55 :: 		if(PIR1.ADIF == 1) {
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt10
;P9g.c,56 :: 		switch(canal) {
	GOTO        L_interrupt11
;P9g.c,57 :: 		case VS:
L_interrupt13:
;P9g.c,58 :: 		voltaje_vs = ADRESL + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 0 
	MOVWF       _voltaje_vs+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       _voltaje_vs+1 
;P9g.c,59 :: 		cambiar_canal(VREF);
	MOVLW       1
	MOVWF       FARG_cambiar_canal_c+0 
	CALL        _cambiar_canal+0, 0
;P9g.c,60 :: 		break;
	GOTO        L_interrupt12
;P9g.c,61 :: 		case VREF:
L_interrupt14:
;P9g.c,62 :: 		voltaje_vref = ADRESL + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 0 
	MOVWF       _voltaje_vref+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       _voltaje_vref+1 
;P9g.c,63 :: 		cambiar_canal(VS);
	CLRF        FARG_cambiar_canal_c+0 
	CALL        _cambiar_canal+0, 0
;P9g.c,64 :: 		break;
	GOTO        L_interrupt12
;P9g.c,67 :: 		}
L_interrupt11:
	MOVLW       0
	XORWF       _canal+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt25
	MOVLW       0
	XORWF       _canal+0, 0 
L__interrupt25:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt13
	MOVLW       0
	XORWF       _canal+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt26
	MOVLW       1
	XORWF       _canal+0, 0 
L__interrupt26:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt14
L_interrupt12:
;P9g.c,69 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;P9g.c,70 :: 		}
L_interrupt10:
;P9g.c,71 :: 		}
L_end_interrupt:
L__interrupt19:
	RETFIE      1
; end of _interrupt

_main:

;P9g.c,74 :: 		void main() {
;P9g.c,75 :: 		TRISA.B2 = 1;
	BSF         TRISA+0, 2 
;P9g.c,76 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;P9g.c,77 :: 		TRISA.B1 = 0;
	BCF         TRISA+0, 1 
;P9g.c,78 :: 		TRISA.B4 = 0;
	BCF         TRISA+0, 4 
;P9g.c,79 :: 		ADCON0 = 0x41;
	MOVLW       65
	MOVWF       ADCON0+0 
;P9g.c,80 :: 		ADCON1 = 0xC4;
	MOVLW       196
	MOVWF       ADCON1+0 
;P9g.c,81 :: 		T0CON = 0x11;
	MOVLW       17
	MOVWF       T0CON+0 
;P9g.c,82 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;P9g.c,83 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;P9g.c,84 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;P9g.c,85 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;P9g.c,86 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;P9g.c,87 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;P9g.c,89 :: 		TMR0H = (alfa >> 8);
	MOVF        _alfa+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alfa+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       TMR0H+0 
;P9g.c,90 :: 		TMR0L = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       TMR0L+0 
;P9g.c,92 :: 		T0CON.B7 = 1;
	BSF         T0CON+0, 7 
;P9g.c,93 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;P9g.c,95 :: 		while(1){
L_main15:
;P9g.c,97 :: 		}
	GOTO        L_main15
;P9g.c,102 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
