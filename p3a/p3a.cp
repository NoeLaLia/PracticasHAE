#line 1 "C:/Users/noeli/Desktop/HAE/p3a/p3a.c"
#line 14 "C:/Users/noeli/Desktop/HAE/p3a/p3a.c"
void main() {
 char botonPulsado = 0;
 TRISB.B2 = 1;
 TRISB.B3 = 0;
 while(1){
 if(PORTB.B2 == 1 && botonPulsado == 0){
 botonPulsado = 1;
 PORTB.B3 += 1;

 }
 if(PORTB.B2 == 0 && botonPulsado == 1){
 botonPulsado = 0;
 }
 delay_ms(25);

 }
}
