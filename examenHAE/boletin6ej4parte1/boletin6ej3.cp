#line 1 "C:/Users/noeli/Desktop/HAE/examenHAE/boletin6ej4parte1/boletin6ej3.c"
int alfa = 25536;
char estado = 0;
char x = 0;
void interrupt(){
 if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 switch(estado){
 case 0:
 if(PORTA.B0){
 x = 0;
 PORTC.B0 = 1;
 estado = 1;
 }
 break;
 case 1:
 if(x == 25 && PORTA.B0){
 estado = 2;
 }
 if(x == 25 && !PORTA.B0){
 estado = 0;
 PORTC.B0 = 0;
 }
 x++;
 break;
 case 2:
 x = 0;
 estado = 1;
 }
 }
}
void main() {
 ADCON1 = 0x07;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 TRISA.B0 = 1;
 TRISA.B1 = 0;
 TRISC.B0 = 0;

 T0CON = 0x12;

 INTCON.GIE = 1;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 T0CON.TMR0ON = 1;
 while(1){
 asm nop;
 }
}
