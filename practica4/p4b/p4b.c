char x;
unsigned char contador = 0; //0 - 255
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
void interrupt(){
     char valores [4];
     char valor = PORTB.B5;
     INTCON2.RBIF = 0;
     if(valor == 1){
                  contador++;
                  ByteToStr(contador, valores);
                  Lcd_Out(1, 1,valores);
                  }
     x = PORTB;
     INTCON.RBIF = 0;
}
void main(){
      ADCON1 = 0x07;
      TRISB = 0xF0;
      TRISD = 0;
      //Interrupción RB4-RB7
      INTCON2.RBPU = 0;
      x = PORTB;
      INTCON.RBIF = 0; //Reiniciamos el flag por si acaso
      INTCON.RBIE = 1;//Activamos la interrupción
      INTCON.GIE = 1; //Activamos las interrupciones globalmente
      Lcd_Init();
      while(1){ }
}
