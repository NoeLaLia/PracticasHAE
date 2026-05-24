#define ac PORTA.B0
#define ar PORTA.B2
#define ad PORTA.B4

#define bc PORTB.B0
#define br PORTB.B2
#define bd PORTB.B4

#define ma0 PORTC.B0
#define ma1 PORTC.B3
#define mb0 PORTC.B6
#define mb1 PORTD.B0
#define v PORTD.B3

int alfa = 28036;
char estado = 0;
void interrupt(){
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF = 0;
                       TMR0H = (alfa >> 8);
                       TMR0L = alfa;
                       switch(estado){
                                      case 0:
                                           if(bc && ar){
                                                 estado = 1;
                                                 v = 1;
                                                 ma1 = 0;
                                                 ma0 = 1;
                                                 mb1 = 0;
                                                 mb0 = 0;
                                                 
                                           }
                                           else if(ac && br){
                                                estado = 3;
                                                v = 0;
                                                ma1 = 0;
                                                ma0 = 0;
                                                mb1 = 0;
                                                mb0 = 1;
                                           }
                                           break;
                                      case 1:
                                           if(ad){
                                                   estado = 2;
                                                   ma1 = 1;
                                                   ma0 = 0;
                                           }
                                           break;
                                      case 2:
                                           if(ac){
                                                  estado = 0;
                                                  ma1 = 0;
                                           }
                                           break;
                                      case 3:
                                           if(bd){
                                                  estado = 4;
                                                  mb1 = 1;
                                                  mb0 = 0;
                                           }
                                           break;
                                      case 4:
                                           if(bc){
                                                  estado = 0;
                                                  mb1 = 0;
                                           }
                                           break;
                       }
     }
}
void main() {
     TRISA = 0xFF;
     TRISB = 0xFF;
     TRISC = 0;
     TRISD = 0;
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