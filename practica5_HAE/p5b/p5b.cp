#line 1 "C:/Users/Electronica/Desktop/p5b/p5b.c"
char Q = 0;
char alfa = 30536;

void interrupt(){
#line 12 "C:/Users/Electronica/Desktop/p5b/p5b.c"
 char a = PORTA.B0;
 if(Q == 0){
 if(a == 0){

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
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 INTCON.GIE = 1;

 TMR0H = (alfa >> 8);
 TMR0L = alfa;



 while(1){

 }
}
