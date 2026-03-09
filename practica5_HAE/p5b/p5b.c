char Q = 0;
int alfa = 30536;

void interrupt(){
/*
_ si Q = 0 y a = 0: se deja Q = 0 y se deja m = m
_ si Q = 0 y a = 1: se pone Q = 1 y se deja m = m
_ si Q = 1 y a = 0: se pone Q = 2 y se cambia el valor de m
_ si Q = 1 y a = 1: se dejan Q = 1 y m = m
_ si Q = 2 y a = x: se pone Q = 0 y m = m
*/
                 char a = PORTA.B0;
                 if(Q == 0){
                      if(a == 0){
                           //Nada
                           Q = 0;
                      }
                      if(a == 1){
                           Q = 1;
                      }
                 }
                 if(Q == 1){
                      if(a == 0){
                              Q = 2;
                              PORTA.B3++;
                      }
                      if(a == 1){
                           //Nada
                           Q = 1;
                      }
                 }
                 if(Q == 2){
                            Q = 0;
                 }
                 INTCON.TMR0IF = 0;
                 TMR0H = (alfa >> 8);
                 TMR0L = alfa;

}

void main() {
           ADCON1 = 0x07;
           TRISA.B0 = 1;
           TRISA.B3 = 0;
           
           T0CON = 0b10010001;
           INTCON.TMR0IF = 0; // se pone el flag a 0
           INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
           INTCON.GIE = 1; // se habilitan las interrupciones en general

           TMR0H = (alfa >> 8);
           TMR0L = alfa;

           //TMR0ON T08BIT T0CS T0SE PSA T0PS2 T0PS1 T0PS0
           
           while(1){

           }
}