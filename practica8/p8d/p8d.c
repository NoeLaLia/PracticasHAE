void main() {
     char i = 0;
     int D = 0;
     TRISC.B0 = 0;

     ADCON1 = 0x07;
     SPI1_Init();
     //Enviamos el paquete de 16 bits
     SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
     SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.

     PORTC.B0 = 1;
     PORTC.B0 = 0;

     while(1){
              //Reiniciamos
              D = 0;
              //Subimos la primera mitad
              for(i = 0; i < 512; i++){
                    SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
                    SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
                    PORTC.B0 = 1;
                    D++;
                    PORTC.B0 = 0;
              }
              //Esperamos 70 milisegundos en el medio
              valor = 512;
              D = 512;

              SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
              SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
              PORTC.B0 = 1;
              delay_ms(70);
              PORTC.B0 = 0;
              //Subimos hasta el final
              for(i = 0; i < 512; i++){
                    SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
                    SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
                    PORTC.B0 = 1;
                    D++;
                    PORTC.B0 = 0;
              }
              
              PORTC.B0 = 1;
              PORTC.B0 = 0;
              SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
              SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.

     }
}
