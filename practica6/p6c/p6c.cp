#line 1 "C:/Users/noeli/Desktop/HAE/practica6/p6c/p6c.c"




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

float voltaje;
int lectura;
int alfa = 28036;
int estado_actual = 0;
int temperatura_celsius;
char mostrar_pantalla = 0;
char caracter_temperatura;

int temperatura_mostrar = 0;
void interrupt(){
 char texto[10];
 if(INTCON.INT0IF){
 INTCON.INT0IF = 0;
 if(estado_actual == 2){
 estado_actual = 0;
 }
 else{
 estado_actual++;
 }
 mostrar_pantalla = 1;
 }
 if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;
 T0CON.TMR0ON = 1;
 ADCON0.GO = 1;
 }
 if(PIR1.ADIF){

 PIR1.ADIF = 0;
 lectura = ADRESL;
 lectura += (ADRESH << 8);

 voltaje = lectura * (5.0/1024.0);
 temperatura_celsius = 100 * voltaje - 50;
 mostrar_pantalla = 1;
 }
 if(mostrar_pantalla){
 if(estado_actual ==  0 ){
 temperatura_mostrar = temperatura_celsius;
 caracter_temperatura = 'C';
 }
 if(estado_actual ==  2 ){
 temperatura_mostrar = temperatura_celsius + 273;
 caracter_temperatura = 'K';
 }
 if(estado_actual ==  1 ){
 temperatura_mostrar = ((float)temperatura_celsius * 1.8) + 32;
 caracter_temperatura = 'F';
 }
 mostrar_pantalla = 0;
 IntToStr(temperatura_mostrar, texto);
 Lcd_Out(1,1, texto);
 Lcd_Chr_Cp(223);
 Lcd_Chr_Cp(caracter_temperatura);
 }
}
void main() {
 TRISA.B3 = 1;
 TRISB.B0 = 1;


 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;

 INTCON.INTEDG0 = 1;


 T0CON = 0b00010101;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;


 ADCON0 = 0b10011001;
 ADCON1 = 0b10000100;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;


 INTCON.GIE = 1;
 INTCON.PEIE = 1;



 Lcd_Init();

 T0CON.TMR0ON = 1;
 ADCON0.GO = 1;
 while(1){ }
}
