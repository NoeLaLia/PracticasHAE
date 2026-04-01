#line 1 "C:/Users/noeli/Desktop/HAE/practica8/p8f/p8f.c"
#line 8 "C:/Users/noeli/Desktop/HAE/practica8/p8f/p8f.c"
int alfa = 63536;
int lectura = 0;

void interrupt(){

 if(INTCON.TMR0IF){

 INTCON.INT0IF = 0;
 ADCON0.GO = 1;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 }
 if(PIR1.ADIF){
 PIR1.ADIF = 0;

 lectura = ADRESL + (ADRESH << 8);

 SPI1_Write(lectura >> 6);
 SPI1_Write(lectura << 2);
 PORTC.B0 = 1;
 PORTC.B0 = 0;


 }
}

void main() {
 TRISC.B0 = 0;
 TRISC.B6 = 0;
 SPI1_Init();

 ADCON0 = 0b10010001;

 ADCON1 = 0b10000000;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 T0CON = 0b00011000;

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
