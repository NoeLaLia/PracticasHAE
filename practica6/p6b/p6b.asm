
_interrupt:

;p6b.c,16 :: 		void interrupt(){
;p6b.c,18 :: 		}
L_end_interrupt:
L__interrupt1:
	RETFIE      1
; end of _interrupt

_main:

;p6b.c,19 :: 		void main() {
;p6b.c,21 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
