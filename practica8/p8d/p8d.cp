#line 1 "C:/Users/noeli/Desktop/HAE/practica8/p8d/p8d.c"
void main() {
 char i = 0;
 float valor = 0;



 int D = 0;
 TRISC.B0 = 0;

 ADCON1 = 0x07;
 SPI1_Init();

 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);

 PORTC.B0 = 1;
 PORTC.B0 = 0;

 while(1){

 for(i = 0; i < 100; i++){
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;
 delay_us(270);
 valor += 5.12;
 D = (int)valor;
 PORTC.B0 = 0;
 }

 valor = 512;
 D = 512;

 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;
 delay_ms(70);
 PORTC.B0 = 0;

 for(i = 0; i < 100; i++){
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;
 PORTC.B0 = 0;
 delay_us(270);
 valor += 5.12;
 D = (int)valor;
 }

 valor = 0;
 D = 0;
 PORTC.B0 = 1;
 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 delay_us(56);

 }
}
