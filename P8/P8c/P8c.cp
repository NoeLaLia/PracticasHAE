#line 1 "C:/Users/User/OneDrive - Universidade de Vigo/Escritorio/Universidad_info/HAE/P8/P8c.c"
int salida = 757;

void main() {
 TRISC.B0 = 0;

 SPI1_Init();


 while(1) {
 PORTC.B0 = 0;

 SPI1_Write(salida >> 6);
 SPI1_Write(salida << 2);

 PORTC.B0 = 1;

 }

}
