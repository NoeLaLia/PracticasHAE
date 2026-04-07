int salida = 757;

void main() {
   TRISC.B0 = 0;
   
   SPI1_Init();

   
   while(1) {
      PORTC.B0 = 0;

      SPI1_Write(salida >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
      SPI1_Write(salida << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
      
      PORTC.B0 = 1;

   }
   
}