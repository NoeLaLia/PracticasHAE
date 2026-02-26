char x;
char espera;

void interrupt(){
     //Boton no pulsado
     if(PORTB.B5 == 0){
                 //Se reinicia la espera para que el led se encienda al momento la próxima vez
                 espera = 0;
                 //Se apaga el led
                 PORTA.B0 = 0;
                 //Hay que leer antes de reiniciar la interrupción por alguna razón
                 x = PORTB;
                 INTCON.RBIF = 0;
     }
     else{
          //Se espera 20 veces 25 milisegundos para ganar responsibidad al soltar el botón
          if(espera % 20 == 0){
                    espera = 0;
                    //Hacemos "led toggle"
                    PORTA.B0+=1;
          }
          delay_ms(25);
          espera++;
       }
}
void main() {
     ADCON1 = 0x07;
     TRISB = 0xF0;
     TRISA.B0 = 0;
     
     x = PORTB;
     INTCON.RBIF = 0;
     INTCON.RBIE = 1;
     INTCON.GIE = 1;
     
     while(1){}

}