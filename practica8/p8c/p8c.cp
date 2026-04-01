#line 1 "C:/Users/noeli/Desktop/HAE/practica8/p8c.c"
void main() {



 int D = 758;
 TRISC.B0 = 0;

 ADCON1 = 0x07;
 SPI1_Init();

 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);

 PORTC.B0 = 1;
 PORTC.B0 = 0;

 while(1){
 }
 }
