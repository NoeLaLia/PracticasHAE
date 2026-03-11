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
                   //0.0048828125 es 5V dividido entre 1024
                   voltaje = lectura * (5.0 / 1024.0);
                   FloatToStr(voltaje, escribir);
                   Lcd_Out(1, 1, escribir);
     }
}

void main() {
     TRISA.B3 = 1;
     //Configuracion Timer 1 segundo
     T0CON = 0b00010100;
     //TMR0ON T08BIT T0CS T0SE PSA T0PS2 T0PS1 T0PS0
     INTCON.TMR0IF = 0;
     INTCON.TMR0IE = 1;
     TMR0H = (alfa >> 8);
     TMR0L = alfa;
     //Configuramos puertos analógicos
     ADCON1 = 0b10000100;
     //Configuramos prescaler AD y entrada de lectura AD
     ADCON0 = 0b10011001;
     //ADFM = 1 (Primer bit) Significa que la conversión tendrá formato
     //0000 00 2 bits resultado 8 bits resultado
     //Siendo los primeros 8 bits ADRESH y los ultimos 8 bits ADRESL
     //Limpiamos flag interrupción ADC
     PIR1.ADIF = 0;
     //Activamos la interrupción del ADC
     PIE1.ADIE = 1;
     //Activamos las interrupciones para los perifericos
     INTCON.PEIE = 1;
     INTCON.GIE = 1;
     Lcd_Init();
     //Leemos por primera vez
     ADCON0.GO = 1;
     T0CON.TMR0ON = 1;
     while(1){

     }
}