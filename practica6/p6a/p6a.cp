#line 1 "C:/Users/noeli/Desktop/HAE/practica6/p6a/p6a.c"
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
int alfa = 3036;
void interrupt(){
 char escribir[10];
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

 voltaje = lectura * (5.0 / 1024.0);
 FloatToStr(voltaje, escribir);
 Lcd_Out(1, 1, escribir);
 }
}

void main() {
 TRISA.B3 = 1;

 T0CON = 0b00010100;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 TMR0H = (alfa >> 8);
 TMR0L = alfa;

 ADCON1 = 0b10000100;

 ADCON0 = 0b10011001;




 PIR1.ADIF = 0;

 PIE1.ADIE = 1;

 INTCON.PEIE = 1;
 INTCON.GIE = 1;
 Lcd_Init();

 ADCON0.GO = 1;
 T0CON.TMR0ON = 1;
 while(1){

 }
}
