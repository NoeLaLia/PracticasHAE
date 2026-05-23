#line 1 "C:/Users/noeli/Desktop/HAE/examenHAE/boletin6ej4parte2/boletin6ej4parte2.c"
int alfa = 15536;
char x = 0;
char estado = 0;
void interrupt(){
 if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 switch(estado){
 case 0:
 if(PORTA.B2){
 x = 0;
 estado = 1;
 PORTB.B1 = 1;
 PORTB.B4 = 1;
 }
 break;
 case 1:
 x++;
 if(x == 50){
 PORTB.B4 = 0;
 estado = 2;
 }
 break;
 case 2:
 x++;
 if(x == 100){
 PORTB.B1 = 0;
 estado = 3;
 }
 break;
 case 3:
 if(!PORTA.B2){
 estado = 0;
 }
 break;
 }
 }
}
void main() {
 TRISA.B2 = 1;
 TRISB = 0x00;
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
