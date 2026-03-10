long int tension;
long int temp;
unsigned char print[7];
// LCD module connections
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections

void interrupt()
{
 if (INTCON.TMR0IF == 1)
 {
  TMR0H = (28036 >> 8);
  TMR0L = 28036;

  INTCON.TMR0IF = 0;
  
  PORTE.B0 = !PORTE.B0;
  ADCON0.GO = 1;
  while(ADCON0.GO);
 
  tension = (ADRESH << 8) + ADRESL;
 
  temp = (tension * 500) / 1023 - 50;
  IntToStr(temp, print);
  Lcd_Out(1,1, print);
  Lcd_Chr(1,8, 223);
 }



}
void main()
{
 ADCON0 = 0x59;
 ADCON1 = 0xC4;

 TRISE.B0 = 0;
 TRISA.B3 = 1; // el AN utilizado como entrada

 Lcd_Init();

 T0CON = 0x06;
 TMR0H = (28036 >> 8);
 TMR0L = 28036;

 T0CON.TMR0ON = 1;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 INTCON.GIE = 1; // se habilitan las interrupciones en general

 while(1)
 {

 }
}