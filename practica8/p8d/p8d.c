void main() {
     char i = 0;
     float valor = 0;
     //Se quiere enviar ~3.7voltios
     //3.7/5 * 1023 = 757.02 ~ 758
     //(Voltaje requerido / Voltaje maximo) * (2^bits_adc - 1)
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
              //Subimos la primera mitad
              for(i = 0; i < 100; i++){
                    SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
                    SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
                    PORTC.B0 = 1;
                    delay_us(270);
                    valor += 5.12;
                    D = (int)valor;
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
              for(i = 0; i < 100; i++){
                    SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
                    SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
                    PORTC.B0 = 1;
                    PORTC.B0 = 0;
                    delay_us(270);
                    valor += 5.12;
                    D = (int)valor;
              }
              //Reiniciamos
              valor = 0;
              D = 0;
              PORTC.B0 = 1;
              PORTC.B0 = 0;
              SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
              SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
              delay_us(56);

     }
}