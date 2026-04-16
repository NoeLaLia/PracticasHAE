#line 1 "C:/Users/User/OneDrive - Universidade de Vigo/Escritorio/Universidad_info/HAE/P9/P9g/P9g.c"







int voltaje_vs;
int voltaje_vref;
int canal =  0 ;
 int vref;
 int vs;
int estado =  0 ;
int alfa_adc = 8;
int alfa = 28036;

void cambiar_canal(unsigned char c) {
 ADCON0 = (c << 3) | 0x41;
 canal = c;
}

void interrupt() {
 vs = voltaje_vs*(5/1024);
 vref = voltaje_vref*(5/1024);

 if(INTCON.TMR0IF == 1) {
 if (PORTA.B4 == 0) {
 estado =  0 ;
 PORTA.B2 = 0;
 } else {

 switch(estado) {
 case  0 :
 estado =  1 ;
 break;

 case  1 :
 PORTA.B2 = 1;
 if (vs >= (vref + alfa_adc)) {
 estado =  2 ;
 }
 break;

 case  2 :
 PORTA.B2 = 0;
 if (vs <= (vref - alfa_adc)) {
 estado =  1 ;
 }
 break;
 }
 }
 ADCON0.B2 = 1;
 INTCON.TMR0IF = 0;
 }
 if(PIR1.ADIF == 1) {
 switch(canal) {
 case  0 :
 voltaje_vs = ADRESL + (ADRESH << 8);
 cambiar_canal( 1 );
 break;
 case  1 :
 voltaje_vref = ADRESL + (ADRESH << 8);
 cambiar_canal( 0 );
 break;


 }

 PIR1.ADIF = 0;
 }
}


void main() {
 TRISA.B2 = 1;
 TRISA.B0 = 0;
 TRISA.B1 = 0;
 TRISA.B4 = 0;
 ADCON0 = 0x41;
 ADCON1 = 0xC4;
 T0CON = 0x11;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 TMR0H = (alfa >> 8);
 TMR0L = alfa;

 T0CON.B7 = 1;
 ADCON0.GO = 1;

 while(1){

 }




}
