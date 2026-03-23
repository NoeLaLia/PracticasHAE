#line 1 "C:/Users/Electronica/Desktop/practica7/p7e/p7e.c"
sbit LCD_RS at PORTD.B2;
sbit LCD_EN at PORTD.B3;
sbit LCD_D4 at PORTD.B4;
sbit LCD_D5 at PORTD.B5;
sbit LCD_D6 at PORTD.B6;
sbit LCD_D7 at PORTD.B7;

sbit LCD_RS_Direction at TRISD.B2;
sbit LCD_EN_Direction at TRISD.B3;
sbit LCD_D4_Direction at TRISD.B4;
sbit LCD_D5_Direction at TRISD.B5;
sbit LCD_D6_Direction at TRISD.B6;
sbit LCD_D7_Direction at TRISD.B7;

int alfa = 3036;
int lectura;
float voltaje;
float valorMostrar;
float valorKpa = 0;
char mostrar = 0;
char estado = 0;










void interrupt(){
 char texto[15];
 char textoMostrar[7];

 if(PIR1.ADIF){
 PIR1.ADIF = 0;
 lectura = ADRESL + (ADRESH << 8);
 voltaje = lectura * (5.0 / 1024.0);
 mostrar = 1;
 }

 if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 PORTB.B0++;
 ADCON0.GO = 1;
 }

 if(INTCON3.INT1IF){
 INTCON3.INT1IF = 0;
 mostrar = 1;
 if(estado == 7){
 estado = 0;
 }
 else{
 estado++;
 }
 }

 if(mostrar){
 mostrar = 0;
 valorKpa = 54.2 * voltaje - 14.11;
 if(estado ==  0 ){
 valorMostrar = valorKpa;
 strcpy(textoMostrar, "kPa");
 }
 else if(estado ==  1 ){
 valorMostrar = 6.8927 * valorKpa;
 strcpy(textoMostrar, "PSI");
 }
 else if(estado ==  2 ){
 valorMostrar = 101.325 * valorKpa;
 strcpy(textoMostrar, "ATM");
 }
 else if(estado ==  3 ){
 valorMostrar = 0.1 * valorkPa;
 strcpy(textoMostrar, "mBar");
 }
 else if(estado ==  4 ){
 valorMostrar = 0.13328 * valorKpa;
 strcpy(textoMostrar, "mmHg");
 }else if(estado ==  5 ){
 valorMostrar = 0.001 * valorKpa;
 strcpy(textoMostrar, "N/m^2");
 }else if(estado ==  6 ){
 valorMostrar = 98.1 * valorKpa;
 strcpy(textoMostrar, "Kg/cm^2");
 }else if(estado ==  7 ){
 valorMostrar = 98.1 * valorKpa;
 strcpy(textoMostrar, "kp/cm^2");
 }
 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(valorMostrar, texto);
 Lcd_Out(1, 1, texto);
 Lcd_Out_Cp(textoMostrar);
 }
}
void main() {
 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 0;



 T0CON = 0b00010100;

 TRISB.B0 = 0;
 TRISE.B2 = 1;
 ADCON0 = 0b10111001;
 ADCON1 = 0b10000000;
 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;


 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 T0CON.TMR0ON = 1;
 Lcd_Init();
 ADCON0.GO = 1;
 while(1){
 }
}
