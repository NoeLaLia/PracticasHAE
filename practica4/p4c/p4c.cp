#line 1 "C:/Users/noeli/Desktop/HAE/practica4/p4c/p4c.c"
char x;
char primeraVez;
unsigned char turno;

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


void interrupt(){
 char textoInicial[] = {"Turno:   0"};
 char texto [4];
 if(!primeraVez){
 Lcd_Out(1,1, textoInicial);
 primeraVez = 1;
 }
 else{
 if(PORTB.B5 == 1){
 turno++;
 ByteToStr(turno, texto);
 Lcd_Out(1,8, texto);

 }
 }
 x = PORTB;
 INTCON.RBIF = 0;
}

void main() {
 turno = 0;
 primeraVez = 0;
 ADCON1 = 0x07;
 TRISD = 0;
 TRISB.B5 = 1;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 Lcd_Init();

 x = PORTB;
 INTCON.RBIF = 1;

 while(1){}
}
