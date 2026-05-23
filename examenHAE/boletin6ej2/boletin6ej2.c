int alfa = 15536;
int estado = 0;
int x = 0;
void interrupt(){
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF = 0;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
                       switch(estado){
                                      case 0:
                                           if(PORTB.B3){
                                                      estado = 1;
                                                      PORTA.B0 = 1;
                                                      x = 0;
                                           }
                                           break;
                                      case 1:
                                           if(x == 30){
                                                estado = 2;
                                                PORTA.B0 = 0;
                                           }
                                           x++;
                                           break;
                                      case 2:
                                           if(!PORTB.B3){
                                                         estado = 0;
                                           }
                                           break;
                       }
    }
}
void main() {
     TRISA.B0 = 0;
     TRISB.B3 = 1;

     ADCON1 = 0x07;
     INTCON.TMR0IF = 0;
     INTCON.TMR0IE = 1;
          
     T0CON = 0x11;
          
     INTCON.GIE = 1;
     TMR0H = (alfa >> 8);
     TMR0L = alfa;
     T0CON.TMR0ON = 1;

     while(1){
              asm nop;
     }
}