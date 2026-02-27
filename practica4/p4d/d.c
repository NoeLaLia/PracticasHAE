/*Estructura b?sica de un programa */

//declaracion de variables globales
char x;
unsigned char estado = 0;

//declaracion (y definicion) de funciones

//declaracion y definicion de la ISR (rutina de servicio de interrupciones)
void interrupt(){

 estado = !estado;

 x = PORTB; // para poder borrar el bit RBIF (define x global)
 INTCON.RBIF=0; // se borra el bit RBIF después de llamar a la función tecla()
}

void main()
{
 //declaracion de variables

 ADCON1 = 0x07; //configuraci?n de los canales anal?gicos (AN) como digitales

 // configuracion de puertos
 TRISB.B5 = 1;
 TRISA.B0 = 0;

 //configuracion e inicializacion de los m?dulos del PIC que se vayan a utilizar

 //configuraci?n de interrupciones (si se utilizan)
 INTCON2.RBPU = 0; // se habilitan las resistencias de pullup del puerto B
 x = PORTB; // para poder borrar el RBIF
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1) //bucle infinito
 {
if(estado == 1)
  {
   PORTA = 0xFF;
   delay_ms(500);
   PORTA = 0;
   delay_ms(500);
  }
  else
  {
   PORTA.B0 = 0;
  }
 }
}
// Componentes ISIS: PIC18F452, RES, LED-BLUE