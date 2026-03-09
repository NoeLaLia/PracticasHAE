int alfa = 18661;
int beta = 3036;
char timer_activo = 0;
void interrupt(){

     //Primer boton pulsado
     if(INTCON.INT0IF){
                      INTCON.INT0IF = 0;
                      //Ambos apagados,
                      if(!timer_activo){
                                        PORTC.B0 = 1;
                                        timer_activo = 1;
                                        TMR0H = (alfa >> 8);
                                        TMR0L = alfa;
                                        T0CON.TMR0ON = 1;
                                        
                      }
     }
     //Segundo boton pulsado
     if(INTCON3.INT1IF){
                        INTCON3.INT1IF = 0;
                        if(!timer_activo){
                                          PORTC.B6 = 1;
                                          timer_activo = 1;
                                          TMR0H = (beta >> 8);
                                          TMR0L = beta;
                                          T0CON.TMR0ON = 1;
                        }
     }
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF = 0;
                       PORTC.B0 = 0;
                       PORTC.B6 = 0;
                       timer_activo = 0;
                       T0CON.TMR0ON = 0;

  }
}
void main() {
           ADCON1 = 0x07;
           TRISB.B0 = 1;
           TRISB.B1 = 1;
           TRISC.B0 = 0;
           TRISC.B6 = 0;
           
           //Flancos de subida
          INTCON2.INTEDG0 = 1;
          INTCON.INT0IF = 0;
          INTCON.INT0IE = 1;
          
          //Flancos de subida
          INTCON2.INTEDG1 = 1;
          INTCON3.INT1IF = 0;
          INTCON3.INT1IE = 1;

           T0CON = 0b00010110;
           //TMR0ON T08BIT T0CS T0SE PSA T0PS2 T0PS1 T0PS0
           INTCON.TMR0IF = 0; // se pone el flag a 0
           INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0

           //TMR0L = alfa;



           INTCON.GIE = 1; // se habilitan las interrupciones en general


           while(1){


           }
}