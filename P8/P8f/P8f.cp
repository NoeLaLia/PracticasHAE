#line 1 "C:/Users/User/OneDrive - Universidade de Vigo/Escritorio/Universidad_info/HAE/P8/P8f.c"
int alfa =64535;
int voltaje;
int valorMuestreo;

void interrupt() {
 if(INTCON.TMR0IF == 1) {
 PORTC.B0 = 0;
 SPI1_Write(valorMuestreo >> 6);
 SPI1_Write(valorMuestreo << 2);

 PORTC.B0 = 1;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 T0CON.B7 = 1;
 INTCON.TMR0IF = 0;

 }
 if(PIR1.ADIF == 1) {
 voltaje = ADRESL + (ADRESH << 8);
 valorMuestreo = voltaje * 4;

 ADCON0.B2 = 1;
 PIR1.ADIF = 0;
 }



}

void main() {
 TRISA.B2 = 1;
 TRISC.B0 = 0;

 T0CON = 0x10;
 ADCON0 = 0x51;
 ADCON1 = 0xC0;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 TMR0H = (alfa >> 8);
 TMR0L = alfa;

 SPI1_Init();

 T0CON.B7 = 1;

 ADCON0.B2 = 1;



 while(1) {

 }


}
