#line 1 "C:/Users/noeli/Desktop/HAE/p3c/p3c.c"
#line 9 "C:/Users/noeli/Desktop/HAE/p3c/p3c.c"
char numeroActual = 80;
void interrupt(){


 if(INTCON.INT0IF == 1){


 INTCON.INT0IF = 0;

 if(numeroActual != 0){
 numeroActual--;
 }
 }

 else if(INTCON3.INT1IF == 1){

 INTCON3.INT1IF = 0;

 if(numeroActual != 99){
 numeroActual++;

 }
}
}
void main() {
 char valores[] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111};


 char temp = 0;
 char decenas = 0;
 char unidades = 0;
 ADCON1 = 0x07;
 TRISD = 0;
 TRISE = 0;

 TRISB.B1 = 1;
 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;

 TRISB.B0 = 1;
 INTCON2.INTEDG0 = 1;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;

 INTCON.GIE = 1;




 while(1){
 temp = numeroActual;
 unidades = temp % 10;
 temp /= 10;
 decenas = temp % 10;

 PORTE = 0b101;
 PORTD = valores[unidades];

 delay_ms(5);

 PORTE = 0b110;
 PORTD = valores[decenas];
 delay_ms(5);
 }
}
