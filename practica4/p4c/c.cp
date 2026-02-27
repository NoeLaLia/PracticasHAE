#line 1 "C:/Users/Ivan/Documents/Ing. Informatica/HAE/Practicas/Practica4/c/c.c"



char x;
unsigned char estado_anterior;
unsigned short num = 0;
 char txt[4];

sbit LCD_RS at RD2_bit;
sbit LCD_EN at PORTD.B3;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D3 at RD3_bit;
sbit LCD_D2 at RD2_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD.B3;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D3_Direction at TRISD3_bit;
sbit LCD_D2_Direction at TRISD2_bit;



void interrupt(){

 if(INTCON.RBIF)
 {
 unsigned char estado_actual = PORTB.B5;

 if(estado_anterior == 0 && estado_actual == 1)
 {
 num++;
 }
 estado_anterior = estado_actual;
 }
 ByteToStr(num, txt);

 x = PORTB;
 INTCON.RBIF=0;
}

void main()
{


 ADCON1 = 0x07;


 TRISB = 0xFF;
 TRISD = 0x00;


 Lcd_Init ();
 Lcd_Out(1,1, "Turno:");
 Lcd_Cmd(_LCD_CURSOR_OFF);

 INTCON2.RBPU = 0;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1)
 {
 Lcd_Out(1,7,txt);
 }
}
