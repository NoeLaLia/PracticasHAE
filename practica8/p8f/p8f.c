/* Hay que muestrear la señal vi
(t) = 0,625 + 0,623·sen(2·?·6·t), siendo el periodo de
muestreo igual a 1mseg. Los valores proporcionados por el A/D deben multiplicarse por 4
y el resultado debe enviarse al D/A AD5310 (mira el circuito de la siguiente página).
Componentes ISIS: PIC18F452, CAP, RES, AD5310, Oscilloscope, Sine generator.
Nota: en este apartado no puedes utilizar las funciones delay_ms(), delay_us()
*/
int alfa = 63536;
int lectura = 0;

void interrupt(){

     if(INTCON.TMR0IF){
                       //Reiniciamos el timer
                       INTCON.INT0IF = 0;
                       ADCON0.GO = 1;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
     }
     if(PIR1.ADIF){
                   PIR1.ADIF = 0;
                   //Leemos el valor de los registros del ADC
                   lectura = ADRESL + (ADRESH << 8);
                   //Enviamos la lectura
                   SPI1_Write(lectura >> 6); // se envía al DAC el byte alto del paquete de 16 bits.
                   SPI1_Write(lectura << 2); // se envía al DAC el byte bajo del paquete de 16 bits.
                   PORTC.B0 = 1;
                   PORTC.B0 = 0;


     }
}

void main() {
     TRISC.B0 = 0;
     TRISC.B6 = 0;
     SPI1_Init();
     
     ADCON0 = 0b10010001;
     //ADCS1 ADCS0 CHS2 CHS1 CHS0 GO/DONE — ADON
     ADCON1 = 0b10000000;
     //ADFM ADCS2 — — PCFG3 PCFG2 PCFG1 PCFG0
     PIR1.ADIF = 0;
     PIE1.ADIE = 1;
     
     T0CON = 0b00011000;
     //TMR0ON T08BIT T0CS T0SE PSA T0PS2 T0PS1 T0PS0
     INTCON.TMR0IE = 1;
     INTCON.TMR0IF = 0;
     INTCON.GIE = 1;
     INTCON.PEIE = 1;
     

     TMR0H = (alfa >> 8);
     TMR0L = alfa;
     T0CON.TMR0ON = 1;
    ADCON0.GO = 1;
     
     while(1){
     }
}