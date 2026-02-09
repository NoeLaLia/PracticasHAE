#line 1 "C:/Users/Electronica/Desktop/Practicas/P2bNoeliaCarballeiraAlvarez/P2bNoeliaCarballeiraAlvarez.c"
void main() {
 char i;
 char valores[] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111100, 0b00000111, 0b01111111, 0b01101111};
 char displays[] = {0b00000111, 0b00001011, 0b00001101, 0b00001110};
 char valorActual = 0;
 ADCON1 = 0x07;
 TRISC = 0;
 TRISD = 0;
 TRISB = 0xFF;
 while(1){
 valorActual = PORTB;
 for(i = 0; i < 4; i++){
 PORTC = valores[valorActual % 10];
 PORTD = displays[i];
 valorActual /= 10;
 delay_ms(24);
 }


 }
}
