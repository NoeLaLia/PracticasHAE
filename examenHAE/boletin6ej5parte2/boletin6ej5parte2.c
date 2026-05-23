int alfa = 15536;
char estado = 0;
void interrupt(){
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF = 0;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
                       switch(estado){
                                      case 0:
                                           if(PORTA.B5){
                                                        estado = 1;
                                                        PORTC.B0 = 1;
                                           }
                                           break;
                                      case 1:
                                           if(!PORTA.B5){
                                                         estado = 2;
                                                         //PORTC.B0 = 1;
                                           }
                                           break;
                                      case 2:
                                           if(PORTA.B5){
                                                        estado = 3;
                                                        //PORTC.B0 = 1;
                                           }
                                           break;
                                      case 3:
                                           if(!PORTA.B5){
                                                         estado = 0;
                                                         PORTC.B0 = 0;
                                           }
                                           break;
                       }
     }
}
void main() {
     ADCON1 = 0x07;
     TRISA.B5 = 1;
     TRISC.B0 = 0;
     
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