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
float RLdr;
float Lux;
void interrupt(){
     char texto[15];
     if(PIR1.ADIF){
                   PIR1.ADIF = 0;
                   lectura = ADRESL + (ADRESH << 8);
                   voltaje = lectura * (5.0 / 1024.0);
                   RLdr = 15000 * (5 / voltaje - 1);
                   Lux =  pow((RLdr / 127410), (-1.0 / 0.8582));
                   FloatToStr(Lux, texto);
                   Lcd_Out(1, 1, texto);
     }
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF = 0;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
                       PORTB.B0++;
                       ADCON0.GO = 1;
     }
}
void main() {
     T0CON = 0b00010100;
     //TMR0ON T08BIT T0CS T0SE PSA T0PS2 T0PS1 T0PS0
     TRISB.B0 = 0;
     ADCON0 = 0b10110001;
     ADCON1 = 0b10000010;
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