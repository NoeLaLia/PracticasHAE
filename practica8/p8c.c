void main() {
     //Se quiere enviar ~3.7voltios
     //3.7/5 * 1023 = 757.02 ~ 758
     //(Voltaje requerido / Voltaje maximo) * (2^bits_adc - 1)
     int D = 758;
     TRISC.B0 = 0;
     
     ADCON1 = 0x07;
     SPI1_Init();
     //Enviamos el paquete de 16 bits
     SPI1_Write(D >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
     SPI1_Write(D << 2); // se envía al DAC el byte bajo del paquete de 16 bits.

     PORTC.B0 = 1;
     PORTC.B0 = 0;

     while(1){
     }
     }