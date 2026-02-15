#line 1 "C:/Users/noeli/Desktop/HAE/p3b/p3b.c"
void interrupt(){

 INTCON3.INT2IF = 0;
 PORTB.B3 += 1;
}

void main() {
 ADCON1 = 0x07;
 TRISB.B2 = 1;
 INTCON2.INTEDG2 = 1;
 INTCON3.INT2IF = 0;
 INTCON3.INT2IE = 1;
 INTCON.GIE = 1;

 TRISB.B3 = 0;
 while(1){

 }
}
