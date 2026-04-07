#line 1 "C:/Users/User/OneDrive - Universidade de Vigo/Escritorio/Universidad_info/HAE/P8/P8d.c"
int salida2_5 = 512;
int salida5 = 1023;
int salida0 = 0;

int i;

void escritura(int valorDAC) {
 PORTC.B0 = 0;

 SPI1_Write(valorDAC >> 6);
 SPI1_Write(valorDAC << 2);

 PORTC.B0 = 1;
}
void main() {
 TRISC.B0 = 0;

 SPI1_Init();

 while(1) {
 escritura(salida2_5);
 delay_ms(70);

 for(i = salida2_5; i < salida5; i++) {
 escritura(i);
 delay_us(54);
 }
 escritura(salida0);
 for(i = salida0; i < salida2_5; i++) {
 escritura(i);
 delay_us(54);
 }
 }


}
