#line 1 "C:/Users/Electronica/Desktop/practica7/p7b/p7b.c"
int alfa = 3036;
void interrupt(){
 if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 PORTB.B0++;
 }
}
void main() {
 T0CON = 0b00010100;

 TRISB.B0 = 0;
 ADCON1 = 0x07;
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.GIE = 1;

 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 T0CON.TMR0ON = 1;
 while(1){
 }
}
