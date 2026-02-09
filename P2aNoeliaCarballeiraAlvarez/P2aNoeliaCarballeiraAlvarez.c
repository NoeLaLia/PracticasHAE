void main() {
     char segundero = 0;
     char unidades = 0;
     char decenas = 0;
     char i;
     char valores[] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111100, 0b00000111, 0b01111111, 0b01101111};
     ADCON1 = 0x07;
     TRISD = 0;
     TRISB = 0x00;
     while(1){
              for(segundero = 0; segundero < 60; segundero++){
                            unidades = segundero % 10;
                            decenas = (segundero / 10) % 10;
                            for(i = 0; i < 25; i++){
                                     PORTA = 0x02;
                                     PORTD = valores[unidades];
                                     delay_ms(20);
                                     PORTA = 0x01;
                                     PORTD = valores[decenas];
                                     delay_ms(20);
                            }
//
}
     }
}