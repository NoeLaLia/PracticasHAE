char estado = 0;
char x = 0;
int alfa = 15536;
void interrupt(){
     if(INTCON.TMR0IF){
                       switch(estado){
                                      case 0:
                                           if(PORTA.B0){
                                                        PORTB.B0 = 0;
                                                        PORTA.B3 = 1;
                                                        estado = 1;
                                           }
                                           break;
                                      case 1:
                                           if(PORTB.B6){
                                                        PORTA.B3 = 0;
                                                        PORTB.B0 = 0;
                                                        x = 0;
                                                        estado = 2;
                                           }
                                           break;
                                      case 2:
                                           x++;
                                           if(x == 40){
                                                estado = 3;
                                                PORTB.B0 = 1;
                                                PORTA.B3 = 0;
                                           }
                                           break;
                                      case 3:
                                           if(PORTB.B4){
                                                        PORTB.B0 = 0;
                                                        PORTA.B4 = 0;
                                                        estado = 4;
                                           }
                                           break;
                                      case 4:
                                           if(!PORTA.B0){
                                                estado = 0;
                                           }
                                           break;
                       }
                       INTCON.TMR0IF = 0;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
     }
}
void main() {
     ADCON1 = 0x07;
     TRISA = 0x01;
     TRISB.B0 = 0;
     TRISB.B4 = 1;
     TRISB.B6 = 1;
     T0CON = 0x11;
     INTCON.TMR0IF = 0;
     INTCON.TMR0IE = 1;
     
     INTCON.GIE = 1;
     TMR0H = (alfa >> 8);
     TMR0L = alfa;
     T0CON.TMR0ON = 1;
     while(1){
              asm nop;
     }
}
