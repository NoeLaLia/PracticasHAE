#line 1 "C:/Users/Ivan/Documents/Ing. Informatica/HAE/Practicas/Practica4/d/d.c"



char x;
unsigned char estado = 0;




void interrupt(){

 estado = !estado;

 x = PORTB;
 INTCON.RBIF=0;
}

void main()
{


 ADCON1 = 0x07;


 TRISB.B5 = 1;
 TRISA.B0 = 0;




 INTCON2.RBPU = 0;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1)
 {
if(estado == 1)
 {
 PORTA = 0xFF;
 delay_ms(500);
 PORTA = 0;
 delay_ms(500);
 }
 else
 {
 PORTA.B0 = 0;
 }
 }
}
