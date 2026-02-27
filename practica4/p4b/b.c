/*Estructura b?sica de un programa */

//declaracion de variables globales
char x;
unsigned char estado_anterior;
unsigned short num = 0;
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at PORTD.B3;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D3 at RD3_bit;
sbit LCD_D2 at RD2_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD.B3;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D3_Direction at TRISD3_bit;
sbit LCD_D2_Direction at TRISD2_bit;
//declaracion (y definicion) de funciones

//declaracion y definicion de la ISR (rutina de servicio de interrupciones)
void interrupt(){
 char txt[4];
 if(INTCON.RBIF)
   {
      unsigned char estado_actual = PORTB.B5; // leer puerto

      if(estado_anterior == 0 && estado_actual == 1)
      {
         num++;   // solo flanco de subida
      }
      estado_anterior = estado_actual;
   }
 ByteToStr(num, txt);
 Lcd_Out(1,1,txt);
 
 x = PORTB; // para poder borrar el bit RBIF (define x global)
 INTCON.RBIF=0; // se borra el bit RBIF después de llamar a la función tecla()
}

void main()
{
 //declaracion de variables

 ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales

 // configuracion de puertos
 TRISB = 0xFF;
 TRISD = 0x00;

 //configuracion e inicializacion de los m?dulos del PIC que se vayan a utilizar
 Lcd_Init ();
 //configuraci?n de interrupciones (si se utilizan)
 INTCON2.RBPU = 0; // se habilitan las resistencias de pullup del puerto B
 x = PORTB; // para poder borrar el RBIF
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1) //bucle infinito
 {

 }
}
// Componentes ISIS: PIC18F452, RES, LED-BLUE