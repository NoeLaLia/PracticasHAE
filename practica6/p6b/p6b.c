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


void interrupt(){

}
void main() {
     Lcd_Init();
     while(1){ }
}