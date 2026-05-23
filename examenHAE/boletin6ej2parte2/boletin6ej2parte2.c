char estado = 0;
char x = 0;
int alfa = 15536;
void interrupt(){
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF = 0;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
                       switch(estado){
                                      case 0:
                                           if(PORTB.B3){
                                                        estado = 1;
                                           }
                                           break;
                                      case 1:
                                           if(!PORTB.B3){
                                                         estado = 2;
                                                         x = 0;
                                                         PORTA.B0 = 1;
                                                         }
                                           break;
                                      case 2:
                                           if(x == 10){
                                                PORTA.B0 = 0;
                                                estado = 3;
                                           }
                                           x++;
                                           break;
                                      case 3:
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
     INTCON.TMR0IF = 0;
     INTCON.TMR0IE = 1;
     T0CON = 0x12;
     
     INTCON.GIE = 1;
     TMR0H = (alfa >> 8);
     TMR0L = alfa;
     T0CON.TMR0ON = 1;
     while(1){
              asm nop;
     }

}