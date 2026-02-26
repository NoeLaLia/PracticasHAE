#line 1 "C:/Users/noeli/Desktop/HAE/practica4/p4d/p4d.c"
char x;
char espera;

void interrupt(){

 if(PORTB.B5 == 0){
 espera = 0;
 PORTA.B0 = 0;
 x = PORTB;
 INTCON.RBIF = 0;
 }
 else{
 if(espera % 20 == 0){
 espera = 0;
 PORTA.B0+=1;
 }
 delay_ms(25);
 espera++;
 }
}
void main() {
 ADCON1 = 0x07;
 TRISB = 0xF0;
 TRISA.B0 = 0;

 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1){}

}
