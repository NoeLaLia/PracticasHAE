#line 1 "C:/Users/noeli/Desktop/HAE/examenHAE/boletin6ej6/boletin6ej6.c"
#line 15 "C:/Users/noeli/Desktop/HAE/examenHAE/boletin6ej6/boletin6ej6.c"
int alfa = 28036;
char estado = 0;
void interrupt(){
 if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 switch(estado){
 case 0:
 if( PORTB.B0  &&  PORTA.B2 ){
 estado = 1;
  PORTD.B3  = 1;
  PORTC.B3  = 0;
  PORTC.B0  = 1;
  PORTD.B0  = 0;
  PORTC.B6  = 0;

 }
 else if( PORTA.B0  &&  PORTB.B2 ){
 estado = 3;
  PORTD.B3  = 0;
  PORTC.B3  = 0;
  PORTC.B0  = 0;
  PORTD.B0  = 0;
  PORTC.B6  = 1;
 }
 break;
 case 1:
 if( PORTA.B4 ){
 estado = 2;
  PORTC.B3  = 1;
  PORTC.B0  = 0;
 }
 break;
 case 2:
 if( PORTA.B0 ){
 estado = 0;
  PORTC.B3  = 0;
 }
 break;
 case 3:
 if( PORTB.B4 ){
 estado = 4;
  PORTD.B0  = 1;
  PORTC.B6  = 0;
 }
 break;
 case 4:
 if( PORTB.B0 ){
 estado = 0;
  PORTD.B0  = 0;
 }
 break;
 }
 }
}
void main() {
 TRISA = 0xFF;
 TRISB = 0xFF;
 TRISC = 0;
 TRISD = 0;
 ADCON1 = 0x07;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 T0CON = 0x11;

 INTCON.GIE = 1;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 T0CON.TMR0ON = 1;
 while(1){
 asm nop;
 }
}
