void interrupt(){
     //Se reinicia la interrupción
     INTCON3.INT2IF = 0;
     PORTB.B3 += 1;
}

void main() {
     ADCON1 = 0x07;
     TRISB.B2 = 1; // se configura RB2 como entrada
     INTCON2.INTEDG2 = 1; //la interrupción la provoca flanco de subida
     INTCON3.INT2IF = 0; // se pone el flag de la interrupción INT2 a 0
     INTCON3.INT2IE = 1; // se habilita la interrupción INT2
     INTCON.GIE = 1; // se habilitan las interrupciones en general

     TRISB.B3 = 0;
     while(1){
     
  }
}